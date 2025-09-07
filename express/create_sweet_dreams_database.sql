-- ============================================
-- 🍰 Sweet Dreams Bakery - Complete Database Setup
-- ============================================

-- 1. Create database (if not exists)
CREATE DATABASE IF NOT EXISTS sweet_dreams_bakery;
USE sweet_dreams_bakery;

-- 2. Drop tables if exist (for clean setup)
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS cakes;
DROP TABLE IF EXISTS users;

-- 3. Create users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    role ENUM('customer', 'admin', 'baker') DEFAULT 'customer',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    INDEX idx_username (username),
    INDEX idx_email (email),
    INDEX idx_role (role)
);

-- 4. Create cakes table
CREATE TABLE cakes (
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

-- 4. Insert sample cake data
INSERT INTO cakes (name, category, flavor, size, weight, description, price, image_path, is_available, rating) VALUES
-- Birthday Cakes
('Chocolate Dream Cake', 'Birthday Cakes', 'Rich chocolate with vanilla cream', 'Medium (8 inch)', 1000, 'Kue coklat yang lezat dengan lapisan krim vanilla yang lembut. Cocok untuk perayaan ulang tahun atau acara spesial. Dibuat dengan coklat premium dan krim vanilla yang creamy.', 150000, 'images/monitor1.jpg', TRUE, 4.5),

('Strawberry Delight', 'Birthday Cakes', 'Fresh strawberries with vanilla sponge', 'Medium (8 inch)', 950, 'Kue sponge vanilla yang lembut dengan potongan strawberry segar dan krim yang lezat. Perfect untuk pecinta buah-buahan dengan rasa yang menyegarkan.', 175000, 'images/monitor2.jpg', TRUE, 4.8),

('Rainbow Birthday Special', 'Birthday Cakes', 'Colorful layers with buttercream', 'Large (10 inch)', 1500, 'Kue pelangi dengan berbagai lapisan warna-warni dan buttercream yang manis. Perfect untuk ulang tahun anak-anak dengan tampilan yang ceria dan menarik.', 200000, 'images/monitor3.jpg', TRUE, 4.7),

-- Cupcakes
('Vanilla Cupcakes (6 pcs)', 'Cupcakes', 'Classic vanilla with buttercream', 'Individual', 300, 'Set 6 cupcakes vanilla klasik dengan buttercream topping yang lezat. Sempurna untuk acara kecil atau sebagai dessert sehari-hari.', 75000, 'images/monitor1.jpg', TRUE, 4.3),

('Chocolate Fudge Cupcakes (6 pcs)', 'Cupcakes', 'Double chocolate with fudge frosting', 'Individual', 320, 'Cupcakes coklat yang kaya dengan frosting fudge yang melting di mulut. Surga bagi pecinta coklat sejati.', 85000, 'images/monitor2.jpg', TRUE, 4.6),

('Red Velvet Mini Cakes (4 pcs)', 'Cupcakes', 'Red velvet with cream cheese', 'Individual', 280, 'Mini red velvet cakes dengan cream cheese frosting yang premium. Tampilan elegan dengan rasa yang tak terlupakan.', 95000, 'images/monitor3.jpg', TRUE, 4.4),

-- Wedding Cakes
('Red Velvet Romance', 'Wedding Cakes', 'Red velvet with cream cheese frosting', 'Extra Large (12 inch)', 2500, 'Kue red velvet yang mewah dengan cream cheese frosting. Sempurna untuk pernikahan atau acara formal dengan dekorasi yang elegan dan rasa yang istimewa.', 450000, 'images/monitor2.jpg', TRUE, 4.9),

('Classic White Wedding Cake', 'Wedding Cakes', 'Vanilla sponge with white chocolate ganache', 'Extra Large (12 inch)', 2800, 'Kue pernikahan klasik dengan sponge vanilla dan white chocolate ganache. Desain yang timeless dan elegan untuk hari bahagia Anda.', 500000, 'images/monitor1.jpg', TRUE, 4.8),

-- Custom Cakes
('Chocolate Chip Cookie Dough Cake', 'Custom Cakes', 'Chocolate chip cookie dough flavor', 'Medium (8 inch)', 1200, 'Kue dengan rasa cookie dough chocolate chip yang unik dan menarik. Perpaduan antara cake dan cookie yang akan memanjakan lidah Anda.', 180000, 'images/monitor3.jpg', FALSE, 4.4),

('Tiramisu Delight Cake', 'Custom Cakes', 'Coffee-flavored with mascarpone', 'Medium (8 inch)', 1100, 'Kue dengan rasa tiramisu yang autentik, lengkap dengan mascarpone cream dan sentuhan kopi yang pas. Untuk pencinta kopi dan dessert Italia.', 220000, 'images/monitor1.jpg', TRUE, 4.7),

-- Seasonal Specials
('Christmas Fruit Cake', 'Seasonal Specials', 'Mixed fruits with brandy essence', 'Large (10 inch)', 1400, 'Kue buah khas Natal dengan campuran buah-buahan kering dan essence brandy. Traditional Christmas cake dengan resep turun temurun.', 250000, 'images/monitor2.jpg', TRUE, 4.2),

('Valentine Heart Cake', 'Seasonal Specials', 'Strawberry and cream with rose essence', 'Medium (8 inch)', 1000, 'Kue berbentuk hati dengan rasa strawberry dan krim, ditambah essence mawar yang romantis. Perfect untuk Valentine atau anniversary.', 190000, 'images/monitor3.jpg', TRUE, 4.6);

-- 5. Create reviews table
CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    cake_id INT NOT NULL,
    rating DECIMAL(3,2) NOT NULL CHECK (rating >= 1.0 AND rating <= 5.0),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (cake_id) REFERENCES cakes(id) ON DELETE CASCADE,
    INDEX idx_reviews_user (user_id),
    INDEX idx_reviews_cake (cake_id),
    INDEX idx_reviews_rating (rating)
);

-- 6. Create indexes for better performance
CREATE INDEX idx_cakes_category ON cakes(category);
CREATE INDEX idx_cakes_is_available ON cakes(is_available);
CREATE INDEX idx_cakes_rating ON cakes(rating);
CREATE INDEX idx_cakes_price ON cakes(price);

-- 7. Insert sample users
INSERT INTO users (username, password, email, full_name, phone, role, is_active) VALUES
-- Password for all sample users is 'password123' (hashed with bcrypt)
('admin', '$2b$10$9Y2k0Z8L9xXvKpQ3rNmYm.E8FxQ7rJ2pR4mY1vB6K8gT5sN3qW9tK', 'admin@sweetdreams.co.id', 'Admin Sweet Dreams', '+62-21-1234-5678', 'admin', TRUE),
('baker1', '$2b$10$9Y2k0Z8L9xXvKpQ3rNmYm.E8FxQ7rJ2pR4mY1vB6K8gT5sN3qW9tK', 'baker@sweetdreams.co.id', 'Chef Maria Rodriguez', '+62-812-3456-7890', 'baker', TRUE),
('customer1', '$2b$10$9Y2k0Z8L9xXvKpQ3rNmYm.E8FxQ7rJ2pR4mY1vB6K8gT5sN3qW9tK', 'andi.wijaya@gmail.com', 'Andi Wijaya', '+62-813-9876-5432', 'customer', TRUE),
('customer2', '$2b$10$9Y2k0Z8L9xXvKpQ3rNmYm.E8FxQ7rJ2pR4mY1vB6K8gT5sN3qW9tK', 'sari.indah@yahoo.com', 'Sari Indah Permata', '+62-821-1111-2222', 'customer', TRUE),
('customer3', '$2b$10$9Y2k0Z8L9xXvKpQ3rNmYm.E8FxQ7rJ2pR4mY1vB6K8gT5sN3qW9tK', 'budi.santoso@hotmail.com', 'Budi Santoso', '+62-856-3333-4444', 'customer', TRUE);

-- 8. Insert sample reviews
INSERT INTO reviews (user_id, cake_id, rating, comment) VALUES
(3, 1, 5.0, 'Kue coklat terenak yang pernah saya coba! Teksturnya lembut dan rasanya pas banget. Recommended!'),
(4, 1, 4.5, 'Enak banget! Anak-anak suka sekali. Cuma agak manis untuk saya, tapi overall bagus.'),
(5, 2, 5.0, 'Strawberry-nya fresh dan krimnya gak terlalu manis. Perfect untuk acara ulang tahun kemarin.'),
(3, 2, 4.0, 'Rasa strawberry-nya authentic, tapi harganya agak mahal. Tapi worth it sih untuk special occasion.'),
(4, 3, 5.0, 'Kue pelanginya cantik banget! Anak saya sampai gak mau makan karena sayang warna-warnanya 😄'),
(5, 3, 4.5, 'Warna-warninya menarik dan rasanya juga enak. Cocok buat foto Instagram!'),
(3, 5, 5.0, 'Red velvet untuk pernikahan kemarin sempurna! Tamu-tamu pada nanya dimana belinya.'),
(4, 6, 3.5, 'Cupcake-nya lucu tapi agak kering. Mungkin next time bisa lebih moist ya.'),
(5, 4, 4.5, 'Vanilla cupcakes yang classic tapi enak. Harganya juga reasonable untuk 6 pieces.');

-- 10. Show results and verify setup
SELECT '🍰 Sweet Dreams Bakery Database Setup Complete!' as status;

-- Show table counts
SELECT COUNT(*) as total_users FROM users;
SELECT COUNT(*) as total_cakes FROM cakes;
SELECT COUNT(*) as total_reviews FROM reviews;

-- Show users by role
SELECT role, COUNT(*) as count FROM users GROUP BY role;

-- Show cakes by category
SELECT category, COUNT(*) as count FROM cakes GROUP BY category;

-- Show sample data
SELECT 
    id,
    name,
    category,
    CONCAT('Rp ', FORMAT(price, 0)) as formatted_price,
    rating,
    is_available
FROM cakes 
ORDER BY category, name
LIMIT 5;

-- Show sample users (without passwords)
SELECT 
    id,
    username,
    email,
    full_name,
    role,
    is_active
FROM users 
ORDER BY role, username;

-- Show sample reviews with cake and user info
SELECT 
    r.id,
    u.full_name as reviewer,
    c.name as cake_name,
    r.rating,
    LEFT(r.comment, 50) as comment_preview
FROM reviews r
JOIN users u ON r.user_id = u.id
JOIN cakes c ON r.cake_id = c.id
ORDER BY r.created_at DESC
LIMIT 5;

-- Show all tables
SHOW TABLES;

-- Show table structures
DESCRIBE users;
DESCRIBE cakes;
DESCRIBE reviews;
