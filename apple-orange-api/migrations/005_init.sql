

-- COUNTERTOP BLENDERS
-- INSERT INTO categories (name, slug, path)
-- VALUES ('High-End Blenders', 'kitchen-countertop-blenders', 'Home-Appliances.Blenders');

-- -- GAMING CONSOLES & VR
-- INSERT INTO categories (name, slug, path)
-- VALUES ('Consoles & VR', 'gaming-consoles-vr', 'Gaming.Consoles-VR');

-- -- PREMIUM VACUUMS
-- INSERT INTO categories (name, slug, path)
-- VALUES ('Premium Vacuums', 'home-appliances-vacuums', 'Home-Appliances.Vacuums');

-- -- COFFEE & ESPRESSO
-- INSERT INTO categories (name, slug, path)
-- VALUES ('Coffee & Espresso Machines', 'kitchen-coffee-espresso', 'Home-Appliances.Coffee-Espresso');

-- -- SOUNDBARS
-- INSERT INTO categories (name, slug, path)
-- VALUES ('Soundbars', 'soundbars', 'Audio.Soundbars');

-- -- PREMIUM SMARTWATCHES
-- INSERT INTO categories (name, slug, path)
-- VALUES ('Premium Smartwatches', 'premium-wearables', 'Wearables.Premium-Smartwatches');


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
