-- ACTION CAMERAS
UPDATE products
SET category_id = (SELECT id FROM categories WHERE slug = 'action-cameras')
WHERE product_grouping_id = (SELECT id FROM product_groupings WHERE slug = 'action-cameras');

-- HIGH-END BLENDERS
UPDATE products
SET category_id = (SELECT id FROM categories WHERE slug = 'top-blenders-smoothies-cooking')
WHERE product_grouping_id = (SELECT id FROM product_groupings WHERE slug = 'top-blenders-smoothies-cooking');

-- GAMING CONSOLES & VR
UPDATE products
SET category_id = (SELECT id FROM categories WHERE slug = 'top-gaming-consoles-vr')
WHERE product_grouping_id = (SELECT id FROM product_groupings WHERE slug = 'top-gaming-consoles-vr');

-- PREMIUM VACUUMS
UPDATE products
SET category_id = (SELECT id FROM categories WHERE slug = 'top-home-vacuums')
WHERE product_grouping_id = (SELECT id FROM product_groupings WHERE slug = 'top-home-vacuums');

-- COFFEE & ESPRESSO
UPDATE products
SET category_id = (SELECT id FROM categories WHERE slug = 'top-coffee-espresso-machines')
WHERE product_grouping_id = (SELECT id FROM product_groupings WHERE slug = 'top-coffee-espresso-machines');

-- SOUNDBARS
UPDATE products
SET category_id = (SELECT id FROM categories WHERE slug = 'top-soundbars')
WHERE product_grouping_id = (SELECT id FROM product_groupings WHERE slug = 'top-soundbars');

-- STANDARD SMARTWATCHES
UPDATE products
SET category_id = (SELECT id FROM categories WHERE slug = 'best-standard-smartwatches')
WHERE product_grouping_id = (SELECT id FROM product_groupings WHERE slug = 'best-standard-smartwatches');

-- PREMIUM SMARTWATCHES
UPDATE products
SET category_id = (SELECT id FROM categories WHERE slug = 'premium-wearables')
WHERE product_grouping_id = (SELECT id FROM product_groupings WHERE slug = 'premium-wearables');
