-- Create cakes table for Sweet Dreams Bakery
CREATE TABLE IF NOT EXISTS cakes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL,
    flavor VARCHAR(255) NOT NULL,
    size VARCHAR(50) NOT NULL,
    weight INT NOT NULL COMMENT 'Weight in grams',
    description TEXT NOT NULL,
    price INT NOT NULL COMMENT 'Price in Rupiah',
    image_path VARCHAR(500) NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,
    rating DECIMAL(3,2) DEFAULT 0.00 COMMENT 'Rating from 0.00 to 5.00',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert sample data
INSERT INTO cakes (name, category, flavor, size, weight, description, price, image_path, is_available, rating) VALUES
('Chocolate Dream Cake', 'Birthday Cakes', 'Rich chocolate with vanilla cream', 'Medium (8 inch)', 1000, 'Kue coklat yang lezat dengan lapisan krim vanilla yang lembut. Cocok untuk perayaan ulang tahun atau acara spesial.', 150000, 'images/monitor1.jpg', TRUE, 4.5),
('Strawberry Delight', 'Birthday Cakes', 'Fresh strawberries with vanilla sponge', 'Medium (8 inch)', 950, 'Kue sponge vanilla yang lembut dengan potongan strawberry segar dan krim yang lezat.', 175000, 'images/monitor2.jpg', TRUE, 4.8),
('Rainbow Birthday Special', 'Birthday Cakes', 'Colorful layers with buttercream', 'Large (10 inch)', 1500, 'Kue pelangi dengan berbagai lapisan warna-warni dan buttercream yang manis. Perfect untuk ulang tahun anak-anak.', 200000, 'images/monitor3.jpg', TRUE, 4.7),
('Vanilla Cupcakes (6 pcs)', 'Cupcakes', 'Classic vanilla with buttercream', 'Individual', 300, 'Set 6 cupcakes vanilla klasik dengan buttercream topping yang lezat.', 75000, 'images/monitor1.jpg', TRUE, 4.3),
('Red Velvet Romance', 'Wedding Cakes', 'Red velvet with cream cheese frosting', 'Extra Large (12 inch)', 2500, 'Kue red velvet yang mewah dengan cream cheese frosting. Sempurna untuk pernikahan atau acara formal.', 450000, 'images/monitor2.jpg', TRUE, 4.9),
('Chocolate Chip Cookies Cake', 'Custom Cakes', 'Chocolate chip cookie dough flavor', 'Medium (8 inch)', 1200, 'Kue dengan rasa cookie dough chocolate chip yang unik dan menarik.', 180000, 'images/monitor3.jpg', FALSE, 4.4);

-- Create indexes for better performance
CREATE INDEX idx_cakes_category ON cakes(category);
CREATE INDEX idx_cakes_is_available ON cakes(is_available);
CREATE INDEX idx_cakes_rating ON cakes(rating); 