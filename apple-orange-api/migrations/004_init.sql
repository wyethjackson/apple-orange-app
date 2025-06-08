ALTER TABLE products ADD COLUMN is_featured BOOLEAN DEFAULT FALSE;

UPDATE products SET is_featured = TRUE WHERE slug = 'apple-airpods-max';

-- 1. Insert product_grouping for Air Fryers
WITH product_grouping AS (
  INSERT INTO product_groupings (type, slug) VALUES ('Premium Air Fryers', 'premium-air-fryers') RETURNING id
)
INSERT INTO products (name, slug, link, description, price, image_file, subtitle, pro_text, con_text, product_grouping_id, is_featured) 
VALUES
('Ninja DT201 Foodi 10-in-1 XL Pro Air Fry Oven', 'ninja-dt201-foodi-xl-air-fry-oven', 'https://amzn.to/44FUnPu', 
'Powerful air fry oven offering 10 cooking functions and a large family-size capacity.', 
249.99, 'ninja_dti201.png', 'Best multi-function', 'Large capacity, versatile cooking functions, fast cooking times', 'Bulky design, learning curve on controls', (SELECT id FROM product_grouping), FALSE),

('Breville Smart Oven Air Fryer Pro', 'breville-smart-oven-air-fryer-pro', 'https://amzn.to/3GtZubu', 
'High-end air fryer oven with Element iQ system for precise cooking and crisping.', 
399.95, 'breville_smart_oven.png', 'Most precise cooking', 'Superior heat distribution, multiple smart presets, premium build', 'Very expensive, large footprint', (SELECT id FROM product_grouping), TRUE),

('COSORI Pro III Air Fryer Dual Blaze', 'cosori-pro-iii-air-fryer', 'https://amzn.to/3GHmHa4', 
'Smart dual-heating air fryer with large basket and easy app control.', 
179.99, 'cosori_pro_iii.png', 'Smartest choice', 'Dual heating elements, smart controls, crisp results', 'Shorter cord, app occasionally glitches', (SELECT id FROM product_grouping), FALSE),

('Instant Omni Plus 18L Air Fryer Oven', 'instant-omni-plus-air-fryer', 'https://amzn.to/4cM3kZs', 
'Spacious, versatile air fryer with rotisserie function and multiple presets.', 
229.99, 'instant_omni_plus.png', 'Best rotisserie air fryer', 'Large capacity, rotisserie option, good preset programs', 'Takes up significant counter space', (SELECT id FROM product_grouping), FALSE),

('Philips Premium Airfryer XXL', 'philips-premium-airfryer-xxl', 'https://amzn.to/4jw3ffh', 
'Top-tier air fryer with patented Twin TurboStar technology for superior air circulation.', 
198.99, 'philips_airfryer_xxl.png', 'Best quality fry', 'Even crisping, reliable temperature control, easy cleaning', 'Expensive, limited in functions compared to ovens', (SELECT id FROM product_grouping), FALSE);

-- 2. Insert Product Comparison (air fryers)
INSERT INTO product_comparisons (title, overview, conclusion, slug, product_grouping_id)
VALUES (
  'Best Premium Air Fryers for Crispier, Faster Cooking',
  'When shopping for a high-end air fryer, it`s important to consider capacity, heating precision, versatility, and overall build quality. Here`s a curated list of top performers to upgrade your kitchen.',
  'For multi-function needs, Ninja DT201 is unbeatable. Breville Smart Oven offers elite precision. Cosori shines for tech lovers, Instant Omni is best for rotisserie fans, and Philips XXL provides the crispiest results.',
  'best-premium-air-fryers-ninja-breville-cosori-instant-philips',
  (SELECT id FROM product_groupings WHERE slug = 'premium-air-fryers')
);

INSERT INTO categories (name, slug, path, title, overview, conclusion) VALUES (
  'Premium Air Fryers', 
  'premium-air-fryers', 
  'Home-Appliances.Premium-Air-Fryers', 
  'Best Premium Air Fryers for Crispier, Faster Cooking',
  'When shopping for a high-end air fryer, it`s important to consider capacity, heating precision, versatility, and overall build quality. Here`s a curated list of top performers to upgrade your kitchen.',
  'For multi-function needs, Ninja DT201 is unbeatable. Breville Smart Oven offers elite precision. Cosori shines for tech lovers, Instant Omni is best for rotisserie fans, and Philips XXL provides the crispiest results.'
);

-- 3. Insert into 'kitchen-countertop-appliances' category
UPDATE products
SET category_id = (SELECT id FROM categories WHERE slug = 'premium-air-fryers')
WHERE product_grouping_id = (SELECT id FROM product_groupings WHERE slug = 'premium-air-fryers');


-- 1. Insert product_grouping for Gaming Laptops
WITH product_grouping AS (
  INSERT INTO product_groupings (type, slug) VALUES ('Premium Gaming Laptops', 'premium-gaming-laptops') RETURNING id
)
INSERT INTO products (name, slug, link, description, price, image_file, subtitle, pro_text, con_text, product_grouping_id, is_featured) 
VALUES
('ASUS ROG Zephyrus G14', 'asus-rog-zephyrus-g14', 'https://amzn.to/4iym3ZK', 
'High-performance 14-inch gaming laptop featuring AMD Ryzen 9 CPU and NVIDIA RTX 4060 GPU.', 
1599.00, 'asus_rog_zephyrus_g14.png', 'Best portable power', 'Exceptional performance, compact design, strong battery life', 'No webcam, premium price', (SELECT id FROM product_grouping), FALSE),

('Razer Blade 15', 'razer-blade-15', 'https://amzn.to/3YKh3dt', 
'Powerful and sleek 15-inch gaming laptop with RTX 4070 graphics and a 240Hz display.', 
2399.99, 'razer_blade_15.png', 'Best premium build', 'Thin and powerful, high refresh rate screen, premium metal chassis', 'Expensive, limited port selection', (SELECT id FROM product_grouping), FALSE),

('MSI Raider GE78 HX', 'msi-raider-ge78-hx', 'https://amzn.to/4jt0yuT', 
'Desktop-class power in a gaming laptop featuring Intel 13th Gen i9 and RTX 4080.', 
2999.00, 'msi_raider_ge78.png', 'Best performance beast', 'Top-tier CPU and GPU, massive display, impressive thermals', 'Very heavy and thick', (SELECT id FROM product_grouping), FALSE),

('Alienware m16 R2', 'alienware-m16-r2', 'https://amzn.to/3EsxPqV', 
'High-end gaming laptop with excellent cooling and vivid QHD+ display.', 
2199.00, 'alienware_m16.png', 'Best for long sessions', 'Outstanding cooling, gorgeous screen, gamer aesthetics', 'Bulky chassis', (SELECT id FROM product_grouping), FALSE),

('Gigabyte AORUS 17X', 'gigabyte-aorus-17x', 'https://amzn.to/4jWvBzb', 
'Massive 17-inch gaming powerhouse with RTX 4090 GPU and mechanical keyboard.', 
3499.00, 'gigabyte_aorus_17x.png', 'Best ultimate laptop', 'Highest possible performance, mechanical keyboard, 240Hz panel', 'Extremely expensive, massive size', (SELECT id FROM product_grouping), TRUE);

-- Product Comparison for Gaming Laptops
INSERT INTO product_comparisons (title, overview, conclusion, slug, product_grouping_id)
VALUES (
  'Best Premium Gaming Laptops for Unmatched Performance',
  'Selecting a high-end gaming laptop involves balancing portability, raw power, screen quality, and cooling solutions. Here are our top picks for serious gamers.',
  'For sheer performance, MSI Raider dominates. Razer Blade 15 is best for premium builds. Zephyrus G14 wins portability. Alienware m16 shines in marathon sessions. AORUS 17X is the no-compromise beast.',
  'best-premium-gaming-laptops-asus-razer-msi-alienware-gigabyte',
  (SELECT id FROM product_groupings WHERE slug = 'premium-gaming-laptops')
);

INSERT INTO categories (name, slug, path, title, overview, conclusion) VALUES (
  'Premium Gaming Laptops', 
  'best-premium-gaming-laptops-asus-razer-msi-alienware-gigabyte', 
  'Gaming.Gaming-Laptops', 
  'Best Premium Gaming Laptops for Unmatched Performance',
  'Selecting a high-end gaming laptop involves balancing portability, raw power, screen quality, and cooling solutions. Here are our top picks for serious gamers.',
  'For sheer performance, MSI Raider dominates. Razer Blade 15 is best for premium builds. Zephyrus G14 wins portability. Alienware m16 shines in marathon sessions. AORUS 17X is the no-compromise beast.'
);

UPDATE products
SET category_id = (SELECT id FROM categories WHERE slug = 'best-premium-gaming-laptops-asus-razer-msi-alienware-gigabyte')
WHERE product_grouping_id = (SELECT id FROM product_groupings WHERE slug = 'premium-gaming-laptops');

--------------------------------------------------------------------------------

-- 3. Insert featured Wearables
WITH product_grouping AS (
  INSERT INTO product_groupings (type, slug) VALUES ('Premium Wearables', 'premium-wearables') RETURNING id
)
INSERT INTO products (name, slug, link, description, price, image_file, subtitle, pro_text, con_text, product_grouping_id, is_featured) 
VALUES
('Apple Watch Ultra 2', 'apple-watch-ultra-2', 'https://amzn.to/3YQ3yJj', 
'Rugged adventure-ready smartwatch with precise GPS, dive features, and titanium case.', 
799.00, 'apple_watch_ultra.png', 'Best adventure smartwatch', 'Extremely durable, bright screen, great GPS accuracy', 'Large size, expensive', (SELECT id FROM product_grouping), TRUE),

('Garmin Fenix 7X Pro', 'garmin-fenix-7x', 'https://amzn.to/3YNmrwy', 
'Ultra-durable outdoor multisport watch with solar charging and topo maps.', 
799.00, 'garmin_fenix_7x.png', 'Best for outdoors', 'Solar charging, long battery, rugged build', 'Complex UI', (SELECT id FROM product_grouping), FALSE),

('Samsung Galaxy Watch 6 Classic', 'samsung-galaxy-watch-6-classic', 'https://amzn.to/3Sa7f8Y', 
'Sleek premium smartwatch with rotating bezel and rich fitness features.', 
429.00, 'samsung_galaxy_watch_6.png', 'Best Android watch', 'Elegant design, good battery, excellent display', 'Fewer apps vs Apple', (SELECT id FROM product_grouping), FALSE);

UPDATE products
SET category_id = (SELECT id FROM categories WHERE slug = 'premium-wearables')
WHERE product_grouping_id = (SELECT id FROM product_groupings WHERE slug = 'premium-wearables');


--------------------------------------------------------------------------------
-- 1. Cameras (Action & Entry Level)

WITH product_grouping AS (
  INSERT INTO product_groupings (type, slug) VALUES ('Action Cameras', 'action-cameras') RETURNING id
)
INSERT INTO products (name, slug, link, description, price, image_file, subtitle, pro_text, con_text, product_grouping_id, is_featured)
VALUES
('GoPro HERO 12 Black', 'gopro-hero-12-black', 'https://amzn.to/4lPG40V', 'Top-tier action camera with stabilization and 5.3K video.', 399.00, 'gopro_hero_12_black.png', 'Best action camera', 'HyperSmooth stabilization, waterproof, 5.3K video', 'Small screen', (SELECT id FROM product_grouping), TRUE),

('Sony ZV-1', 'sony-zv-1', 'https://amzn.to/4iTaP2x', 'Compact vlogging camera with flip screen and 4K video.', 749.00, 'sony_zv1.png', 'Best for vlogging', 'Excellent autofocus, flip screen, solid audio', 'Average battery life', (SELECT id FROM product_grouping), FALSE),

('Canon EOS Rebel T7', 'canon-eos-rebel-t8i', 'https://amzn.to/4cZQZBi', 'User-friendly DSLR with 24MP sensor and Dual Pixel AF.', 749.00, 'canon_rebel_t8i.png', 'Best beginner DSLR', 'Good autofocus, intuitive controls', 'Plastic body', (SELECT id FROM product_grouping), FALSE),

('DJI Osmo Action 4', 'dji-osmo-action-4', 'https://amzn.to/4jS1Gbk', 'Premium action cam with 4K HDR and RockSteady stabilization.', 269.00, 'dji_osmo_action_4.png', 'Best for durability', 'Great build, dual screens, easy mounts', 'Limited accessories', (SELECT id FROM product_grouping), FALSE);

--------------------------------------------------------------------------------
-- 2. Blenders (Premium Consumer)

WITH product_grouping AS (
  INSERT INTO product_groupings (type, slug) VALUES ('Top Blenders for Smoothies and Cooking', 'top-blenders-smoothies-cooking') RETURNING id
)
INSERT INTO products (name, slug, link, description, price, image_file, subtitle, pro_text, con_text, product_grouping_id, is_featured)
VALUES
('Vitamix E310 Explorian Blender', 'vitamix-e310-explorian', 'https://amzn.to/42HqiOl', 'Professional-grade blender for smoothies, soups, and more.', 349.00, 'vitamix_e310.png', 'Best performance blender', 'Unmatched power, durable construction', 'Very loud', (SELECT id FROM product_grouping), TRUE),

('Ninja Foodi Power Blender Ultimate System', 'ninja-foodi-power-blender', 'https://amzn.to/3GHkbkb', 'Multi-use system for blending, chopping, and processing.', 239.00, 'ninja_foodi_blender.png', 'Best for versatility', 'Blend, process, dough maker', 'Bulky', (SELECT id FROM product_grouping), FALSE),

('Breville Super Q Blender', 'breville-super-q-blender', 'https://amzn.to/448GM33', 'Luxury blender with noise control and personal cup.', 599.00, 'breville_super_q.png', 'Best for quiet power', 'Quieter, premium build', 'Very expensive', (SELECT id FROM product_grouping), FALSE),

('Blendtec Total Classic Blender', 'blendtec-total-classic', 'https://amzn.to/4lKU0cJ', 'High-power blender with preprogrammed cycles.', 399.00, 'blendtec_total_classic.png', 'Best preprogrammed blender', 'Programmed cycles, thick smoothies', 'Industrial look', (SELECT id FROM product_grouping), FALSE);

--------------------------------------------------------------------------------
-- 3. Game Systems and VR

WITH product_grouping AS (
  INSERT INTO product_groupings (type, slug) VALUES ('Top Gaming Consoles and VR Headsets', 'top-gaming-consoles-vr') RETURNING id
)
INSERT INTO products (name, slug, link, description, price, image_file, subtitle, pro_text, con_text, product_grouping_id, is_featured)
VALUES
('Nintendo Switch OLED', 'nintendo-switch-oled', 'https://amzn.to/4lPDjfW', 'Portable gaming console with vibrant OLED display.', 349.00, 'nintendo_switch_oled.png', 'Best handheld console', 'Bright OLED, portable, huge library', 'Low internal storage', (SELECT id FROM product_grouping), FALSE),

('PlayStation 5 Standard Edition', 'playstation-5-standard', 'https://amzn.to/3GsodNq', 'Next-gen console with ultra-fast SSD and stunning 4K graphics.', 499.00, 'ps5_standard.png', 'Best graphics', '4K gaming, fast load times', 'Huge size', (SELECT id FROM product_grouping), TRUE),

('Xbox Series X', 'xbox-series-x', 'https://amzn.to/3EAAzCD', 'Powerful console with Game Pass integration and 4K.', 499.00, 'xbox_series_x.png', 'Best ecosystem', 'Game Pass, great power', 'Less exclusive games', (SELECT id FROM product_grouping), FALSE),

('Meta Quest 3', 'meta-quest-3', 'https://amzn.to/3REoPSy', 'Next-gen VR headset with mixed reality capabilities.', 499.00, 'meta_quest_3.png', 'Best standalone VR', 'No wires, excellent graphics', 'Battery life limited', (SELECT id FROM product_grouping), FALSE);

--------------------------------------------------------------------------------
-- 4. Vacuums (Robot and Upright)

WITH product_grouping AS (
  INSERT INTO product_groupings (type, slug) VALUES ('Top Home Vacuums', 'top-home-vacuums') RETURNING id
)
INSERT INTO products (name, slug, link, description, price, image_file, subtitle, pro_text, con_text, product_grouping_id, is_featured)
VALUES
('iRobot Roomba j7+', 'irobot-roomba-j7-plus', 'https://amzn.to/3ErWGv1', 'Smart robot vacuum with obstacle avoidance.', 649.00, 'roomba_j7_plus.png', 'Best obstacle avoidance', 'Excellent AI navigation', 'High cost', (SELECT id FROM product_grouping), TRUE),

('Roborock Q7+ Robot Vacuum', 'roborock-q7-plus', 'https://amzn.to/3Yhdvzn', 'Self-emptying robot vacuum with strong suction.', 599.00, 'roborock_q7_plus.png', 'Best self-emptying', 'Great suction, smart mapping', 'Loud bin emptying', (SELECT id FROM product_grouping), FALSE),

('Tineco Pure One S15', 'tineco-pure-one-s15', 'https://amzn.to/44HhZmK', 'Cordless smart vacuum with dirt detection.', 299.00, 'tineco_pure_one_s15.png', 'Best cordless vacuum', 'Lightweight, strong suction', 'Small dustbin', (SELECT id FROM product_grouping), FALSE),

('Shark Stratos Cordless', 'shark-stratos-cordless', 'https://amzn.to/3YSboSK', 'Cordless stick vacuum with Clean Sense IQ.', 499.00, 'shark_stratos_cordless.png', 'Best adaptive cleaning', 'Auto adjusts suction, good battery', 'Heavier than Dyson', (SELECT id FROM product_grouping), FALSE);

--------------------------------------------------------------------------------
-- 5. Coffee Machines (Premium Consumer)

WITH product_grouping AS (
  INSERT INTO product_groupings (type, slug) VALUES ('Top Coffee and Espresso Machines', 'top-coffee-espresso-machines') RETURNING id
)
INSERT INTO products (name, slug, link, description, price, image_file, subtitle, pro_text, con_text, product_grouping_id, is_featured)
VALUES
('Breville Barista Express', 'breville-barista-express', 'https://amzn.to/42JE3L2', 'All-in-one espresso machine with built-in grinder.', 699.00, 'breville_barista_express.png', 'Best semi-auto machine', 'Built-in grinder, great espresso', 'Learning curve', (SELECT id FROM product_grouping), TRUE),

('Gaggia Classic Pro', 'gaggia-classic-pro', 'https://amzn.to/446AtwS', 'Classic Italian semi-automatic espresso machine.', 449.00, 'gaggia_classic_pro.png', 'Best for traditionalists', 'Excellent crema, durable design', 'Manual steaming', (SELECT id FROM product_grouping), FALSE),

('DeLonghi Dinamica', 'delonghi-dinamica', 'https://amzn.to/3S8AvNr', 'Fully automatic espresso machine with iced coffee option.', 799.00, 'delonghi_dinamica.png', 'Best fully automatic', 'Easy to use, strong brew options', 'Plastic body', (SELECT id FROM product_grouping), FALSE),

('Nespresso VertuoPlus Deluxe', 'nespresso-vertuoplus-deluxe', 'https://amzn.to/42Pwvq0', 'Easy-to-use pod espresso system with crema technology.', 229.00, 'nespresso_vertuo_plus.png', 'Best pod machine', 'Fast, delicious crema, easy cleanup', 'Pods expensive', (SELECT id FROM product_grouping), FALSE);

--------------------------------------------------------------------------------
-- 6. Soundbars

WITH product_grouping AS (
  INSERT INTO product_groupings (type, slug) VALUES ('top_soundbars', 'top-soundbars') RETURNING id
)
INSERT INTO products (name, slug, link, description, price, image_file, subtitle, pro_text, con_text, product_grouping_id, is_featured)
VALUES
('Sonos Beam Gen 2', 'sonos-beam-gen-2', 'https://amzn.to/4jwfd8G', 'Compact smart soundbar with Dolby Atmos.', 499.00, 'sonos_beam_gen2.png', 'Best compact soundbar', 'Dolby Atmos, Alexa/Google built-in', 'No separate subwoofer', (SELECT id FROM product_grouping), FALSE),

('Bose Smart Soundbar 600', 'bose-smart-soundbar-600', 'https://amzn.to/3YObYAU', 'High-quality small Dolby Atmos soundbar.', 449.00, 'bose_smart_soundbar_600.png', 'Best sound clarity', 'Excellent vocal clarity, good size', 'Limited bass', (SELECT id FROM product_grouping), TRUE),

('Samsung HW-Q800D', 'samsung-hw-q800d', 'https://amzn.to/3EHNouS', '5.1.2 Dolby Atmos soundbar with powerful bass.', 799.00, 'samsung_hw_q800d.png', 'Best immersive sound', 'Powerful bass, great separation', 'No rear speakers included', (SELECT id FROM product_grouping), FALSE);

-- Cameras (GoPro, Canon, Sony ZV-1)
UPDATE products
SET category_id = (SELECT id FROM categories WHERE slug = 'action-cameras')
WHERE product_grouping_id = (SELECT id FROM product_groupings WHERE slug = 'action-cameras');

-- Blenders (Vitamix, Ninja, Breville)
UPDATE products
SET category_id = (SELECT id FROM categories WHERE slug = 'kitchen-countertop-appliances')
WHERE product_grouping_id = (SELECT id FROM product_groupings WHERE slug = 'top-blenders-smoothies-cooking');

-- Game Consoles / VR
UPDATE products
SET category_id = (SELECT id FROM categories WHERE slug = 'gaming')
WHERE product_grouping_id = (SELECT id FROM product_groupings WHERE slug = 'top-gaming-consoles-vr');

-- Vacuums (Roomba, Roborock, etc.)
UPDATE products
SET category_id = (SELECT id FROM categories WHERE slug = 'home-appliances-vacuums')
WHERE product_grouping_id = (SELECT id FROM product_groupings WHERE slug = 'top-home-vacuums');

-- Coffee & Espresso Machines (Breville, Gaggia, DeLonghi)
UPDATE products
SET category_id = (SELECT id FROM categories WHERE slug = 'kitchen-coffee-espresso')
WHERE product_grouping_id = (SELECT id FROM product_groupings WHERE slug = 'top-coffee-espresso-machines');

-- Soundbars (Sonos, Bose, Samsung)
UPDATE products
SET category_id = (SELECT id FROM categories WHERE slug = 'soundbars')
WHERE product_grouping_id = (SELECT id FROM product_groupings WHERE slug = 'top-soundbars');

INSERT INTO categories (title, overview, conclusion, slug, name, path)
VALUES (
  'Best Affordable Smartwatches for Fitness and Lifestyle',
  'You no longer need to spend a fortune to get a reliable, feature-packed smartwatch. Modern options deliver solid fitness tracking, stylish looks, and essential notifications at affordable prices.',
  'The Apple Watch SE (2nd Gen) is the best overall choice for iPhone users. Samsung Galaxy Watch 6 offers the best experience for Android fans, while Garmin Venu Sq 2 and Fitbit Versa 4 are ideal for fitness-first users.',
  'best-standard-smartwatches',
  'Standard Smartwatches',
  'Wearables.Standard-Smartwatches'
);

--------------------------------------------------------------------------------
-- 2. Insert New Product Grouping for Smartwatches
WITH product_grouping AS (
  INSERT INTO product_groupings (type, slug) VALUES ('Best Standard Smartwatches', 'best-standard-smartwatches') RETURNING id
)
INSERT INTO products (name, slug, link, description, price, image_file, subtitle, pro_text, con_text, product_grouping_id, is_featured)
VALUES
('Apple Watch SE (2nd Gen)', 'apple-watch-se-2nd-gen', 'https://amzn.to/42u4BRE', 'Affordable Apple smartwatch with strong performance and health tracking.', 249.00, 'apple_watch_se_2nd_gen.png', 'Best budget Apple watch', 'Fast processor, crash detection, great fitness tracking', 'No always-on display', (SELECT id FROM product_grouping), TRUE),

('Samsung Galaxy Watch 6', 'samsung-galaxy-watch-6', 'https://amzn.to/4jqD0GN', 'Elegant Android smartwatch with classic design and powerful features.', 299.00, 'samsung_galaxy_watch_6.png', 'Best for Android users', 'Rotating bezel, bright display, strong fitness tracking', 'App support lags behind Apple', (SELECT id FROM product_grouping), FALSE),

('Garmin Venu Sq 2', 'garmin-venu-sq-2', 'https://amzn.to/4jWJGMZ', 'Affordable GPS smartwatch with vibrant AMOLED display.', 249.00, 'garmin_venu_sq_2.png', 'Best fitness tracking', 'Great battery life, lots of fitness modes', 'Simpler OS', (SELECT id FROM product_grouping), FALSE),

('Fitbit Versa 4', 'fitbit-versa-4', 'https://amzn.to/4cQKDUv', 'Fitness-first smartwatch with sleep tracking and daily readiness score.', 199.00, 'fitbit_versa_4.png', 'Best sleep and wellness focus', 'Excellent sleep tracking, slim design', 'Limited app ecosystem', (SELECT id FROM product_grouping), FALSE),

('Amazfit T-Rex 3', 'amazfit-trex-3', 'https://amzn.to/3Gu0b4z', 'Affordable smartwatch with advanced GPS and fitness features.', 279.99, 'amazfit_gtr_4.png', 'Best value GPS watch', 'Advanced GPS, long battery life, stylish, water-resistant', 'Fewer 3rd party apps', (SELECT id FROM product_grouping), FALSE);

--------------------------------------------------------------------------------
-- 3. Associate Products with New Standard Smartwatches Category
UPDATE products
SET category_id = (SELECT id FROM categories WHERE slug = 'wearables-standard-smartwatches')
WHERE product_grouping_id = (SELECT id FROM product_groupings WHERE slug = 'best-standard-smartwatches');

UPDATE products
SET category_id = (SELECT id FROM categories WHERE slug = 'wearables-standard-smartwatches')
WHERE product_grouping_id = (SELECT id FROM product_groupings WHERE slug = 'best-standard-smartwatches');

INSERT INTO product_comparisons (title, overview, conclusion, slug, product_grouping_id)
VALUES (
  'Best Action and Entry Cameras for Every Adventure',
  'Choosing the right camera depends on whether you prioritize portability, ruggedness, or video quality. Action cams like GoPro shine for extreme activities, while compact vloggers and beginner DSLRs offer better creative flexibility.',
  'For extreme durability and ease of use, the GoPro HERO 12 remains unbeatable. Sony ZV-1 is the best choice for content creators, and Canon T8i is ideal for beginners seeking DSLR flexibility.',
  'action-cameras',
  (SELECT id FROM product_groupings WHERE slug = 'action-cameras')
);

INSERT INTO categories (title, overview, conclusion, slug, name, path)
VALUES (
  'Best Action and Entry Cameras for Every Adventure',
  'Choosing the right camera depends on whether you prioritize portability, ruggedness, or video quality. Action cams like GoPro shine for extreme activities, while compact vloggers and beginner DSLRs offer better creative flexibility.',
  'For extreme durability and ease of use, the GoPro HERO 12 remains unbeatable. Sony ZV-1 is the best choice for content creators, and Canon T8i is ideal for beginners seeking DSLR flexibility.',
  'action-cameras',
  'Action Cameras',
  'Cameras-Photography.Action-Cameras'
);


INSERT INTO product_comparisons (title, overview, conclusion, slug, product_grouping_id)
VALUES (
  'Top Blenders for Smoothies, Soups, and Everyday Cooking',
  'Finding a blender that matches your cooking style means balancing raw power, versatility, and durability. Premium blenders offer faster blending, quieter motors, and longer-lasting construction compared to cheaper options.',
  'Vitamix E310 remains the gold standard for serious blending. For versatility on a budget, Ninja Foodi shines, while Breville Super Q brings luxury and quiet power to the kitchen.',
  'top-blenders-smoothies-cooking',
  (SELECT id FROM product_groupings WHERE slug = 'top-blenders-smoothies-cooking')
);

INSERT INTO categories (title, overview, conclusion, slug, name, path)
VALUES (
  'Top Blenders for Smoothies, Soups, and Everyday Cooking',
  'Finding a blender that matches your cooking style means balancing raw power, versatility, and durability. Premium blenders offer faster blending, quieter motors, and longer-lasting construction compared to cheaper options.',
  'Vitamix E310 remains the gold standard for serious blending. For versatility on a budget, Ninja Foodi shines, while Breville Super Q brings luxury and quiet power to the kitchen.',
  'top-blenders-smoothies-cooking',
  'Premium Blenders',
  'Home-Appliances.Premium-Blenders'
);


INSERT INTO product_comparisons (title, overview, conclusion, slug, product_grouping_id)
VALUES (
  'Best Gaming Consoles and VR Headsets for Every Player',
  'From traditional consoles to cutting-edge VR, today’s gaming options offer something for every type of player. The right choice depends on whether you value portability, exclusives, raw power, or immersion.',
  'Nintendo Switch OLED is best for gaming on the go. PlayStation 5 leads with performance and exclusives, Xbox Series X dominates Game Pass value, and Meta Quest 3 brings standalone VR to the mainstream.',
  'top-gaming-consoles-vr',
  (SELECT id FROM product_groupings WHERE slug = 'top-gaming-consoles-vr')
);


INSERT INTO categories (title, overview, conclusion, slug, name, path)
VALUES (
  'Best Gaming Consoles and VR Headsets for Every Player',
  'From traditional consoles to cutting-edge VR, today’s gaming options offer something for every type of player. The right choice depends on whether you value portability, exclusives, raw power, or immersion.',
  'Nintendo Switch OLED is best for gaming on the go. PlayStation 5 leads with performance and exclusives, Xbox Series X dominates Game Pass value, and Meta Quest 3 brings standalone VR to the mainstream.',
  'top-gaming-consoles-vr',
  'Consoles & VR',
  'Gaming.Consoles-VR'
);

INSERT INTO product_comparisons (title, overview, conclusion, slug, product_grouping_id)
VALUES (
  'Top Home Vacuums for Cleaner, Smarter Living',
  'Choosing a vacuum today means considering smart navigation, self-emptying options, and cordless convenience. Premium models can save time and reduce effort while maintaining a cleaner home.',
  'The Roomba j7+ offers excellent AI obstacle avoidance, while Roborock Q7+ excels at self-emptying performance. Tineco Pure One S15 is the best cordless stick vacuum for daily flexibility.',
  'top-home-vacuums',
  (SELECT id FROM product_groupings WHERE slug = 'top-home-vacuums')
);

INSERT INTO categories (title, overview, conclusion, slug, name, path)
VALUES (
  'Top Home Vacuums for Cleaner, Smarter Living',
  'Choosing a vacuum today means considering smart navigation, self-emptying options, and cordless convenience. Premium models can save time and reduce effort while maintaining a cleaner home.',
  'The Roomba j7+ offers excellent AI obstacle avoidance, while Roborock Q7+ excels at self-emptying performance. Tineco Pure One S15 is the best cordless stick vacuum for daily flexibility.',
  'top-home-vacuums',
  'Premium Vacuums',
  'Home-Appliances.Premium-Vacuums'
);

INSERT INTO product_comparisons (title, overview, conclusion, slug, product_grouping_id)
VALUES (
  'Best Coffee and Espresso Machines for Home Brewing',
  'For coffee lovers, the right machine can transform your morning routine. Semi-automatic, super-automatic, or pod-based solutions each offer their own strengths depending on how hands-on you want to be.',
  'Breville Barista Express remains the best all-around espresso experience. Gaggia Classic Pro is perfect for traditionalists, while DeLonghi Dinamica shines for easy one-touch brewing.',
  'top-coffee-espresso-machines',
  (SELECT id FROM product_groupings WHERE slug = 'top-coffee-espresso-machines')
);

INSERT INTO categories (title, overview, conclusion, slug, name, path)
VALUES (
  'Best Coffee and Espresso Machines for Home Brewing',
  'For coffee lovers, the right machine can transform your morning routine. Semi-automatic, super-automatic, or pod-based solutions each offer their own strengths depending on how hands-on you want to be.',
  'Breville Barista Express remains the best all-around espresso experience. Gaggia Classic Pro is perfect for traditionalists, while DeLonghi Dinamica shines for easy one-touch brewing.',
  'top-coffee-espresso-machines',
  'Coffee & Espresso Machines',
  'Home-Appliances.Coffee-Espresso-Machines'
);

INSERT INTO product_comparisons (title, overview, conclusion, slug, product_grouping_id)
VALUES (
  'Top Soundbars to Upgrade Your Home Theater',
  'Choosing the best soundbar involves balancing audio clarity, bass response, smart features, and Dolby Atmos support. Compact models now deliver impressive performance without needing a full speaker system.',
  'Sonos Beam Gen 2 offers superb smart features and compact clarity, Bose Smart Soundbar 600 brings crisp dialogue to smaller rooms, while Samsung HW-Q800C delivers serious immersive audio for blockbuster nights.',
  'top-soundbars',
  (SELECT id FROM product_groupings WHERE slug = 'top-soundbars')
);

INSERT INTO categories (title, overview, conclusion, slug, name, path)
VALUES (
  'Top Soundbars to Upgrade Your Home Theater',
  'Choosing the best soundbar involves balancing audio clarity, bass response, smart features, and Dolby Atmos support. Compact models now deliver impressive performance without needing a full speaker system.',
  'Sonos Beam Gen 2 offers superb smart features and compact clarity, Bose Smart Soundbar 600 brings crisp dialogue to smaller rooms, while Samsung HW-Q800C delivers serious immersive audio for blockbuster nights.',
  'top-soundbars',
  'Soundbars',
  'Audio.Soundbars'
);

INSERT INTO product_comparisons (title, overview, conclusion, slug, product_grouping_id)
VALUES (
  'Best Affordable Smartwatches for Fitness and Lifestyle',
  'You no longer need to spend a fortune to get a reliable, feature-packed smartwatch. Modern options deliver solid fitness tracking, stylish looks, and essential notifications at affordable prices.',
  'The Apple Watch SE (2nd Gen) is the best overall choice for iPhone users. Samsung Galaxy Watch 6 offers the best experience for Android fans, while Garmin Venu Sq 2 and Fitbit Versa 4 are ideal for fitness-first users.',
  'best-standard-smartwatches',
  (SELECT id FROM product_groupings WHERE slug = 'best-standard-smartwatches')
);

INSERT INTO product_comparisons (title, overview, conclusion, slug, product_grouping_id)
VALUES (
  'The Best Premium Smartwatches for Adventure and Everyday Use',
  'When it comes to premium wearables, buyers expect more than just step tracking. Rugged design, precise GPS, extended battery life, and powerful health metrics are key for those who demand the best from their smartwatch.',
  'The Apple Watch Ultra remains the ultimate choice for iPhone users seeking adventure-ready features. Garmin Fenix 7 excels for outdoor athletes and hikers, while the Galaxy Watch 5 Pro offers strong endurance for Android fans at a lower cost.',
  'premium-wearables',
  (SELECT id FROM product_groupings WHERE slug = 'premium-wearables')
);

INSERT INTO categories (title, overview, conclusion, slug, name, path)
VALUES (
  'The Best Premium Smartwatches for Adventure and Everyday Use',
  'When it comes to premium wearables, buyers expect more than just step tracking. Rugged design, precise GPS, extended battery life, and powerful health metrics are key for those who demand the best from their smartwatch.',
  'The Apple Watch Ultra remains the ultimate choice for iPhone users seeking adventure-ready features. Garmin Fenix 7 excels for outdoor athletes and hikers, while the Galaxy Watch 5 Pro offers strong endurance for Android fans at a lower cost.',
  'premium-wearables',
  'Premium Smartwatches',
  'Wearables.Premium-Smartwatches'
);

