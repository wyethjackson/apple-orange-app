const pool = require('../db');

exports.getAllProducts = async (req, res) => {
    const { rows } = await pool.query('SELECT * FROM products ORDER BY created_at DESC');
    res.json(rows);
};

exports.getProductBySlug = async (req, res) => {
    const { slug } = req.params;
    const { rows } = await pool.query('SELECT * FROM products WHERE slug = $1', [slug]);
    res.json(rows[0] || {});
};
