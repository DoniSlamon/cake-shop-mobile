-- ============================================
-- 🍰 Sweet Dreams Bakery - Step by Step Setup
-- ============================================

-- STEP 1: Create Database
-- Run this first if database doesn't exist
CREATE DATABASE IF NOT EXISTS sweet_dreams_bakery;

-- STEP 2: Use the database
USE sweet_dreams_bakery;

-- STEP 3: Create the cakes table
CREATE TABLE IF NOT EXISTS cakes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL,
    flavor VARCHAR(255) NOT NULL,
    size VARCHAR(50) NOT NULL,
    weight INT NOT NULL,
    description TEXT NOT NULL,
    price INT NOT NULL,
    image_path VARCHAR(500) NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,
    rating DECIMAL(3,2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- STEP 4: Check if table was created
SHOW TABLES;
DESCRIBE cakes;

-- STEP 5: Insert sample data (run this after table is created)
INSERT INTO cakes (name, category, flavor, size, weight, description, price, image_path, is_available, rating) VALUES
('Chocolate Dream Cake', 'Birthday Cakes', 'Rich chocolate with vanilla cream', 'Medium (8 inch)', 1000, 'Kue coklat lezat dengan krim vanilla', 150000, 'images/monitor1.jpg', TRUE, 4.5),
('Strawberry Delight', 'Birthday Cakes', 'Fresh strawberries with vanilla sponge', 'Medium (8 inch)', 950, 'Kue strawberry segar dengan sponge vanilla', 175000, 'images/monitor2.jpg', TRUE, 4.8),
('Rainbow Birthday Special', 'Birthday Cakes', 'Colorful layers with buttercream', 'Large (10 inch)', 1500, 'Kue pelangi untuk ulang tahun', 200000, 'images/monitor3.jpg', TRUE, 4.7);

-- STEP 6: Verify data was inserted
SELECT COUNT(*) as total_cakes FROM cakes;
SELECT * FROM cakes;

-- STEP 7: Create indexes for performance (optional)
CREATE INDEX idx_cakes_category ON cakes(category);
CREATE INDEX idx_cakes_is_available ON cakes(is_available);

-- SUCCESS MESSAGE
SELECT 'Setup completed successfully! 🍰' as message;
