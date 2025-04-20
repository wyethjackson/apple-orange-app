const pool = require('../db');

exports.getFeaturedProducts = async (req, res) => {
    const { rows } = await pool.query('SELECT * FROM products ORDER BY created_at DESC');
    res.json(rows);
};
// This route function will be used when a featured product is clicked on 
// and will grab the other competitor products and do a side by side with all of them
// There will be a default top product for each product grouping
// Ex: overear headphones default top product: Apple Airpods Max

exports.getProductBySlug = async (req, res) => {
    const { slug } = req.params;
    const { rows } = await pool.query('SELECT * FROM products WHERE slug = $1', [slug]);
    res.json(rows[0] || {});
};
