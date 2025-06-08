-- Insert sub-categories under Electronics
INSERT INTO categories (name, slug, path)
VALUES
  ('Audio', 'audio', 'Audio'),
  ('Cameras', 'cameras-photography', 'Cameras-Photography'),
  ('Wearable Tech', 'wearables', 'Wearables'),
  ('Gaming', 'gaming', 'Gaming');
ALTER TABLE categories ADD COLUMN title VARCHAR(255);
ALTER TABLE categories ADD COLUMN overview TEXT;
ALTER TABLE categories ADD COLUMN conclusion TEXT;
INSERT INTO categories (name, slug, path, title, overview, conclusion) 
VALUES(
    'High-End Headphones', 
    'headphones-high-end', 
    'Audio.High-End-Headphones', 
    'The Ultimate Premium Headphones Guide: Finding Your Perfect Match',
    'When considering premium wireless headphones, it`s essential to evaluate products based on their standalone performance across critical attributes like sound quality, comfort, battery life, design, and noise cancellation. Here`s an in-depth comparison of the Apple AirPods Max alongside four prominent competitors:',
    'The Apple AirPods Max cater well to those seeking premium quality audio and materials. Sony WH-1000XM5 are ideal for noise cancellation enthusiasts. Bose QuietComfort Ultra headphones provide unmatched comfort and are perfect for travelers. Sennheiser Momentum 4 Wireless are optimal for users prioritizing long battery life and balanced audio, while Bowers & Wilkins PX7 S2 are excellent for audiophiles who appreciate a warm, refined sound combined with luxurious design.'
);

UPDATE products 
SET category_id = (SELECT id FROM categories WHERE slug = 'headphones-high-end') 
WHERE id IN (
    SELECT id 
    FROM products 
    WHERE product_grouping_id = (
        SELECT id FROM product_groupings WHERE slug = 'premium-over-ear-headphones'
    )
)