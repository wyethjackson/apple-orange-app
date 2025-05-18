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

const getBySlug = async (req, res) => {
    const { slug } = req.params;
    try {
        const cacheKey = `category:${slug}`;
        // Try to get cached categories.
        const cachedCategories = await getCache(cacheKey);
        if (cachedCategories) {
            return res.json(cachedCategories);
        }
        
        // 1. Fetch the category by its slug
        const catResult = await pool.query(
            `  SELECT c.*,
    NOT EXISTS (
      SELECT 1 FROM categories AS child
      WHERE child.path <@ c.path
        AND nlevel(child.path) = nlevel(c.path) + 1
    ) AS is_leaf
  FROM categories AS c
  WHERE c.slug = $1`,
            [slug]
        );

        if (catResult.rows.length === 0) {
            return res.status(404).json({ error: 'Category not found' });
        }

        const category = catResult.rows[0];
        if(!category.is_leaf) {
            const navCat = await getNavCategory(category, cacheKey);
            return res.json(navCat);
        }
        // 2. Fetch breadcrumb data using the LTREE path.
        // This query returns all categories whose path is an ancestor of the current category's path (including itself),
        // ordered by the level (from root to current).
        const breadcrumbResult = await pool.query(
            'SELECT * FROM categories WHERE path @> $1 ORDER BY nlevel(path) ASC',
            [category.path]
        );
        const breadcrumb = breadcrumbResult.rows.map(row => ({
            name: row.name,
            slug: row.slug,
        }));

        // 3. Fetch all products for this category
        const prodResult = await pool.query(
            'SELECT * FROM products WHERE category_id = $1 ORDER BY id',
            [category.id]
        );
        const products = prodResult.rows;
        const allCategories = await fetchAllCategories();
        // 4. Build the response object with the desired structure
        const responseData = {
            category:{
                slug: category.slug,
                name: category.name,
                title: category.title,
                overview: category.overview,
                conclusion: category.conclusion,
                breadcrumb,
                is_leaf: category.is_leaf,
                products: products.map(prod => ({
                    name: prod.name,
                    subtitle: prod.subtitle,
                    description: prod.description,
                    price: parseFloat(prod.price),
                    image_file: prod.image_file,
                    pro_text: prod.pro_text,
                    con_text: prod.con_text,
                    link: prod.link,
                })),
            },
            allCategories,
        };
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
  p.name,
  p.link,
  p.description,
  p.subtitle,
  p.pro_text,
  p.con_text,
  p.price,
  p.image_file,
        child.slug,
  child.name as cat_title,
  child.path
  FROM categories AS child
  LEFT JOIN products p ON p.category_id = child.id AND p.is_featured = TRUE
  WHERE child.path <@ (
  SELECT path FROM categories WHERE slug = $1
  ) 
  AND NOT EXISTS (
    SELECT 1 FROM categories AS subchild
    WHERE subchild.path <@ child.path
    AND nlevel(subchild.path) = nlevel(child.path) + 1
  )
    `, [category.slug]);

    const leafCategoryProducts = leafCategoriesResult.rows;
    const allCategories = await fetchAllCategories();
    const responseData = {
        category: {
            slug: category.slug,
            title: category.name,
            overview: category.overview,
            conclusion: category.conclusion,
            is_leaf: category.is_leaf,
            leafCategoryProducts,
        },
        allCategories,
    };
    console.log(responseData.category);
    await setCache(cacheKey, responseData, 120);
    return responseData;
}

exports.getAllCategories = getAllCategories;
exports.getBySlug = getBySlug;

