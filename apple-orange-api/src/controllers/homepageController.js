const pool = require('../db');

const { getCache, setCache } = require('../cache');

/**
 * Controller method to fetch all categories and build a hierarchical tree.
 */
const getAllCategories = async (req, res) => {
    res.json(await fetchAllCategories());
};

const fetchAllCategories = async () => {
    try {
        const cacheKey = 'categories';
        // Try to get cached categories.
        const cachedCategories = await getCache(cacheKey);
        if (cachedCategories) {
            return cachedCategories;
        }

        // Query the database if cache is empty.
        const result = await pool.query('SELECT * FROM categories ORDER BY path ASC');
        const categories = result.rows;
        const categoryTree = buildCategoryTree(categories);

        await setCache(cacheKey, categoryTree, 120);

        return categoryTree
    } catch (error) {
        console.error('Error fetching categories:', error);
        return res.status(500).json({ error: 'Error fetching categories' });
    }
}

/**
 * Helper function to build a hierarchical tree from a flat list of categories.
 * Each category is expected to have a unique 'path' string that uses dots to
 * separate levels (e.g., "Kitchen.Premium-Cookware").
 */
function buildCategoryTree(categories) {
    // Create a mapping keyed by the category's path.
    const pathMap = {};
    categories.forEach(cat => {
        // Initialize each category with a children array.
        pathMap[cat.path] = { ...cat, children: [] };
    });

    const tree = [];
    categories.forEach(cat => {
        // If there is no dot, it's a root category.
        if (cat.path.indexOf('.') === -1) {
            tree.push(pathMap[cat.path]);
        } else {
            // Determine parent's path by removing the last segment.
            const lastDot = cat.path.lastIndexOf('.');
            const parentPath = cat.path.substring(0, lastDot);
            if (pathMap[parentPath]) {
                pathMap[parentPath].children.push(pathMap[cat.path]);
            } else {
                // Fallback: if no parent is found, treat it as a root node.
                tree.push(pathMap[cat.path]);
            }
        }
    });

    return tree;
}

const getHomePage = async (req, res) => {
    try {
        const cacheKey = `homepage`;
        // Try to get cached categories.
        const cachedData = await getCache(cacheKey);
        if (cachedData) {
            return res.json(cachedData);
        }
        const allCategories = await fetchAllCategories();
        const leafCategoriesResult = await pool.query(`
        SELECT
  p.name as productName,
  p.link,
  p.description,
  p.subtitle,
  p.image_file,
  p.pro_text,
  p.con_text,
  p.price,
        c.slug,
  c.name as cat_title,
  c.path
  FROM products AS p
  INNER JOIN categories c ON p.category_id = c.id AND p.is_featured = TRUE
    `);

        const leafCategoryProducts = leafCategoriesResult.rows;
    const responseData = {
        leafCategoryProducts,
        allCategories,
        heroImage: "hero_image.png"
    }
        await setCache(cacheKey, responseData, 120);
        return res.json(responseData);
    } catch (error) {
        console.error("Error in getCategoryBySlug:", error);
        return res.status(500).json({ error: 'Internal server error' });
    }
};

const getNavCategory = async (category, cacheKey) => {
    const leafCategoriesResult = await pool.query(`
        SELECT
  child.slug,
  child.name,
  child.path,
  ARRAY(
    SELECT name FROM categories AS ancestor
    WHERE ancestor.path @> child.path
    AND ancestor.path != child.path
    ORDER BY nlevel(ancestor.path)
  ) AS breadcrumbs
FROM categories AS child
WHERE child.path <@ (
  SELECT path FROM categories WHERE slug = $1
)
AND NOT EXISTS (
  SELECT 1 FROM categories AS subchild
  WHERE subchild.path <@ child.path
  AND nlevel(subchild.path) = nlevel(child.path) + 1
)
    `, [slug]);

    const leafCategories = leafCategoriesResult.rows;

    const responseData = {
        category: {
            slug: category.slug,
            title: category.title,
            overview: category.overview,
            conclusion: category.conclusion,
            breadcrumb,
            is_leaf: category.is_leaf,
            leafCategories,
        },
        allCategories,
    };
    await setCache(cacheKey, responseData, 120);
    return responseData;
}

exports.getAllCategories = getAllCategories;
exports.getHomePage = getHomePage;

