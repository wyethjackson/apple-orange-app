-- Insert the root Electronics category
INSERT INTO categories (name, slug, path)
VALUES ('Electronics', 'electronics', 'Electronics');

-- Insert sub-categories under Electronics
INSERT INTO categories (name, slug, path)
VALUES
  ('Audio & Headphones', 'electronics-audio-headphones', 'Electronics.Audio-Headphones'),
  ('Computers & Laptops', 'electronics-computers-laptops', 'Electronics.Computers-Laptops'),
  ('Smartphones & Tablets', 'electronics-smartphones-tablets', 'Electronics.Smartphones-Tablets'),
  ('Cameras & Photography', 'electronics-cameras-photography', 'Electronics.Cameras-Photography'),
  ('Wearables', 'electronics-wearables', 'Electronics.Wearables'),
  ('Gaming', 'electronics-gaming', 'Electronics.Gaming'),
  ('Home Theater & Projectors', 'electronics-home-theater-projectors', 'Electronics.Home-Theater-Projectors');

-- Insert more specific sub-categories for finer granularity
INSERT INTO categories (name, slug, path)
VALUES
  ('Gaming Laptops', 'electronics-computers-gaming-laptops', 'Electronics.Computers-Laptops.Gaming-Laptops'),
  ('Professional Cameras', 'electronics-cameras-professional', 'Electronics.Cameras-Photography.Professional-Cameras');
ALTER TABLE categories ADD COLUMN title VARCHAR(255);
ALTER TABLE categories ADD COLUMN overview TEXT;
ALTER TABLE categories ADD COLUMN conclusion TEXT;
INSERT INTO categories (name, slug, path, title, overview, conclusion) 
VALUES(
    'High-End Audio', 
    'electronics-audio-high-end', 
    'Electronics.Audio-Headphones.High-End-Audio', 
    'The Ultimate Premium Headphones Guide: Finding Your Perfect Match',
    'When considering premium wireless headphones, it`s essential to evaluate products based on their standalone performance across critical attributes like sound quality, comfort, battery life, design, and noise cancellation. Here`s an in-depth comparison of the Apple AirPods Max alongside four prominent competitors:',
    'The Apple AirPods Max cater well to those seeking premium quality audio and materials. Sony WH-1000XM5 are ideal for noise cancellation enthusiasts. Bose QuietComfort Ultra headphones provide unmatched comfort and are perfect for travelers. Sennheiser Momentum 4 Wireless are optimal for users prioritizing long battery life and balanced audio, while Bowers & Wilkins PX7 S2 are excellent for audiophiles who appreciate a warm, refined sound combined with luxurious design.'
);

UPDATE products 
SET category_id = (SELECT id FROM categories WHERE slug = 'electronics-audio-high-end') 
WHERE id IN (
    SELECT id 
    FROM products 
    WHERE product_grouping_id = (
        SELECT id FROM product_groupings WHERE slug = 'premium-over-ear-headphones'
    )
)