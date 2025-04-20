CREATE TABLE IF NOT EXISTS product_groupings (
  id SERIAL PRIMARY KEY,
  type VARCHAR(255) NOT NULL,
  slug VARCHAR(255) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

ALTER TABLE products
ADD COLUMN product_grouping_id INTEGER REFERENCES product_groupings(id);

ALTER TABLE products
ADD COLUMN image_file TEXT;

ALTER TABLE products 
ADD COLUMN con_text TEXT;

ALTER TABLE products 
ADD COLUMN pro_text TEXT;

ALTER TABLE products 
ADD COLUMN subtitle TEXT;

CREATE TABLE IF NOT EXISTS product_comparisons (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  overview TEXT NOT NULL,
  conclusion TEXT NOT NULL,
  slug VARCHAR(255) UNIQUE NOT NULL,
  product_grouping_id INTEGER REFERENCES product_groupings(id),
  created_at TIMESTAMP DEFAULT NOW()
);

WITH product_grouping AS (
  INSERT INTO product_groupings (type, slug) VALUES ('Premium Over-Ear Headphones', 'premium-over-ear-headphones') RETURNING id
) INSERT INTO products (name, slug, link, description, price, image_file, subtitle, pro_text, con_text, product_grouping_id) 
VALUES (
    'Apple AirPods Max', 
    'apple-airpods-max', 
    'https://amzn.to/4iVohni', 
    'Premium over-ear headphones offering high-fidelity audio, active noise cancellation, Spatial Audio, and seamless integration with the Apple ecosystem.', 
    539.00,
    'Apple_Airpods_Max.png',
    'Best luxury buy',
    'Exceptional audio quality, premium materials, effective ANC and transparency mode',
    'Heavy design, average battery life, premium price',
    (SELECT id FROM product_grouping)),

('Sony WH-1000XM5', 'sony-wh-1000xm5', 'https://amzn.to/4j46omb', 
'High-performance wireless headphones featuring industry-leading noise cancellation, customizable EQ settings, and a comfortable lightweight design.', 
399.00,
'Sony_WH-1000XM5.png',
'Best noice-cancelling technology',
'Industry-leading noise cancellation, excellent sound quality, comfortable lightweight design, strong battery life',
'No water resistance, design could feel less premium compared to competitors',
(SELECT id FROM product_grouping)
),

('Bose QuietComfort Ultra Headphones', 'bose-quietcomfort-ultra', 'https://amzn.to/42uWHHx', 'Highly comfortable wireless headphones designed for superior noise cancellation, perfect for travel and extended listening.', 
429.00,
'Bose_QuietComfort_Ultra_Headphones.png',
'Best comfort buy',
'Superior comfort, excellent noise cancellation for travel, good battery life',
'Audio less dynamic compared to competitors, ANC may cause slight ear pressure',
(SELECT id FROM product_grouping)
),

('Sennheiser Momentum 4 Wireless', 'sennheiser-momentum-4-wireless', 'https://amzn.to/4lhG1KX',
'Wireless headphones with exceptional battery life (up to 60 hours), balanced sound quality, and comfortable build ideal for extended use', 
379.95,
'sennheiser_momentum_4.png',
'Best budget buy',
'Exceptional battery life, balanced and detailed audio, comfortable for extended wear',
'Noise cancellation slightly weaker compared to leading competitors, less premium build',
(SELECT id FROM product_grouping)
),

('Bowers & Wilkins PX7 S2', 'bowers-wilkins-px7-s2', 'https://amzn.to/3FTKmnD', 
'Luxurious over-ear headphones offering warm sound quality, premium materials, and sophisticated design suitable for audiophile users.', 
304.76,
'bowers_and_williers.png',
'Best for audiophiles',
'Warm and detailed audio suited for audiophiles, premium build quality, good battery life',
'Moderate noise cancellation, heavier design, no traditional headphone jack',
(SELECT id FROM product_grouping)
);

INSERT INTO product_comparisons (title, overview, conclusion, slug, product_grouping_id)
VALUES (
    'The Ultimate Premium Headphones Guide: Finding Your Perfect Match', 
    'When considering premium wireless headphones, it`s essential to evaluate products based on their standalone performance across critical attributes like sound quality, comfort, battery life, design, and noise cancellation. Here`s an in-depth comparison of the Apple AirPods Max alongside four prominent competitors:',
    'The Apple AirPods Max cater well to those seeking premium quality audio and materials. Sony WH-1000XM5 are ideal for noise cancellation enthusiasts. Bose QuietComfort Ultra headphones provide unmatched comfort and are perfect for travelers. Sennheiser Momentum 4 Wireless are optimal for users prioritizing long battery life and balanced audio, while Bowers & Wilkins PX7 S2 are excellent for audiophiles who appreciate a warm, refined sound combined with luxurious design.',
    'the-ultimate-premium-headphones-guide-apple-airpods-max-sony-wh-1000xm5-bose-quietcomfort-ultra-sennheiser-momentum-4-wireless-bowers-wilkins-px7-s2',
    (SELECT id FROM product_groupings WHERE slug = 'premium-over-ear-headphones')
);

CREATE EXTENSION IF NOT EXISTS ltree;

CREATE TABLE IF NOT EXISTS categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE,
    path LTREE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- 2. Update the products table to add a category_id column
ALTER TABLE products
    ADD COLUMN category_id INTEGER;

-- 3. Add a foreign key constraint linking products.category_id to categories.id
ALTER TABLE products
    ADD CONSTRAINT fk_products_category
    FOREIGN KEY (category_id)
    REFERENCES categories(id)
    ON DELETE SET NULL;


-- 4. Insert root categories
INSERT INTO categories (name, slug, path) VALUES 
  ('Kitchen', 'kitchen', 'Kitchen'),
  ('Bathroom', 'bathroom', 'Bathroom'),
  ('Health and Wellness', 'health-and-wellness', 'HealthAndWellness');

-- 5. Insert sub-categories for the Kitchen section
INSERT INTO categories (name, slug, path) VALUES 
  ('High-End Appliances', 'kitchen-high-end-appliances', 'Kitchen.High-End-Appliances'),
  ('Premium Cookware', 'kitchen-premium-cookware', 'Kitchen.Premium-Cookware'),
  ('Countertop Appliances', 'kitchen-countertop-appliances', 'Kitchen.Countertop-Appliances');

-- 6. Insert sub-categories for the Bathroom section
INSERT INTO categories (name, slug, path) VALUES 
  ('Luxury Fixtures', 'bathroom-luxury-fixtures', 'Bathroom.Luxury-Fixtures'),
  ('Premium Shower Systems', 'bathroom-premium-shower-systems', 'Bathroom.Premium-Shower-Systems');

-- 7. Insert sub-categories for the Health and Wellness section
INSERT INTO categories (name, slug, path) VALUES 
  ('Massage Chairs', 'health-and-wellness-massage-chairs', 'HealthAndWellness.Massage-Chairs'),
  ('Saunas', 'health-and-wellness-saunas', 'HealthAndWellness.Saunas'),
  ('Fitness Equipment', 'health-and-wellness-fitness-equipment', 'HealthAndWellness.Fitness-Equipment');