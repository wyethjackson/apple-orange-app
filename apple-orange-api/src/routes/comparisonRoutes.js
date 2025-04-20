const express = require('express');
const router = express.Router();
const comparisonController = require('../controllers/comparisonController');

router.get('/', comparisonController.getTopComparisons);
router.get('/:slug', comparisonController.getBySlug);

module.exports = router;
