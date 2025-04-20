const pool = require('../db');
const { getCache, setCache } = require('../cache');
exports.getTopComparisons = async (req, res) => {
    const { slug } = req.params;
    const cacheKey = `comparison:TopComparisons`
    try {
        const cachedComparison = await getCache(cacheKey);
        if (cachedComparison) {
            return res.json(cachedComparison);
        }
        const { rows } = await pool.query(
            `
        SELECT pc.slug, pc.title, p.image_file FROM product_comparisons pc 
        INNER JOIN product_groupings pg ON pc.product_grouping_id = pg.id 
        INNER JOIN products p ON pg.id = products.product_grouping_id 
        ORDER BY created_at DESC LIMIT 10
        `
        );
        await setCache(cacheKey, rows[0] || {}, 120);
        res.json(rows[0] || {});
    } catch (error) {
        console.error('Error getting comparison:', error);
    }
    const { rows } = await pool.query(
        `
        SELECT pc.slug, pc.title, p.image_file FROM product_comparisons pc 
        INNER JOIN product_groupings pg ON pc.product_grouping_id = pg.id 
        INNER JOIN products p ON pg.id = products.product_grouping_id 
        ORDER BY created_at DESC LIMIT 10
        `
    );
    res.json(rows);
};

exports.getBySlug = async (req, res) => {
    const { slug } = req.params;
    const cacheKey = `comparison:${slug}`
    try {
        const cachedComparison = await getCache(cacheKey);
        if (cachedComparison) {
            return res.json(cachedComparison);
        }
        const { rows } = await pool.query(
            `   
        SELECT pc.slug, pc.title, pc.overview, pc.conclusion, p.* FROM product_comparisons pc
        INNER JOIN product_groupings pg ON pc.product_grouping_id = pg.id
        INNER JOIN products p ON pg.id = products.product_grouping_id
        WHERE pc.slug = $1
        `,
            [slug]
        );
        await setCache(cacheKey, rows[0] || {}, 120);
        res.json(rows[0] || {});
    } catch (error) {
        console.error('Error getting comparison:', error);
    }
};
