// src/server.js
const express = require('express');
const runMigrations = require('./migrate');
const comparisonRoutes = require('./routes/comparisonRoutes');
const productRoutes = require('./routes/productRoutes');
const categoryRoutes = require('./routes/categoryRoutes');
const homepageController = require('./controllers/homepageController');
require('dotenv').config();

const app = express();
app.use(express.json());

(async () => {
    await runMigrations();

    app.use('/comparisons', comparisonRoutes);
    app.use('/products', productRoutes);
    app.use('/categories', categoryRoutes);
    app.get('/', homepageController.getHomePage);

    const PORT = process.env.PORT || 4000;
    app.listen(PORT, '0.0.0.0', () => {
        console.log(`🚀 API running on port ${PORT}`);
    });
})();
