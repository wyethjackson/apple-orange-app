const pool = require('../db');

exports.getAllBlogs = async (req, res) => {
    const { rows } = await pool.query('SELECT * FROM blogs ORDER BY created_at DESC');
    res.json(rows);
};

exports.getBlogBySlug = async (req, res) => {
    const { slug } = req.params;
    const { rows } = await pool.query('SELECT * FROM blogs WHERE slug = $1', [slug]);
    res.json(rows[0] || {});
};
