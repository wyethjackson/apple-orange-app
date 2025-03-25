// src/server.js
const express = require('express');
const runMigrations = require('./migrate');
const blogRoutes = require('./routes/blogRoutes');
const productRoutes = require('./routes/productRoutes');
require('dotenv').config();

const app = express();
app.use(express.json());

(async () => {
    await runMigrations();

    app.use('/blogs', blogRoutes);
    app.use('/products', productRoutes);

    app.get('/', (req, res) => res.json({ status: 'API running' }));

    const PORT = process.env.PORT || 4000;
    app.listen(PORT, () => {
        console.log(`🚀 API running on port ${PORT}`);
    });
})();
