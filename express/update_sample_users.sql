-- ============================================
-- 🍰 Sweet Dreams Bakery - Update Sample Users
-- ============================================

-- Update sample users with properly hashed passwords
-- Password untuk semua user: 'password123'

USE sweet_dreams_bakery;

-- Hapus users lama dan buat yang baru dengan hash yang benar
DELETE FROM reviews;
DELETE FROM users;

-- Reset auto increment
ALTER TABLE users AUTO_INCREMENT = 1;
ALTER TABLE reviews AUTO_INCREMENT = 1;

-- Insert sample users dengan hash password yang benar
-- Password: 'password123' - hashed dengan bcrypt round 10
INSERT INTO users (username, password, email, full_name, phone, role, is_active) VALUES
('admin', '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin@sweetdreams.co.id', 'Admin Sweet Dreams', '+62-21-1234-5678', 'admin', TRUE),
('baker1', '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'baker@sweetdreams.co.id', 'Chef Maria Rodriguez', '+62-812-3456-7890', 'baker', TRUE),
('customer1', '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'andi.wijaya@gmail.com', 'Andi Wijaya', '+62-813-9876-5432', 'customer', TRUE),
('customer2', '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'sari.indah@yahoo.com', 'Sari Indah Permata', '+62-821-1111-2222', 'customer', TRUE),
('customer3', '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'budi.santoso@hotmail.com', 'Budi Santoso', '+62-856-3333-4444', 'customer', TRUE);

-- Insert sample reviews
INSERT INTO reviews (user_id, cake_id, rating, comment) VALUES
(3, 1, 5.0, 'Kue coklat terenak yang pernah saya coba! Teksturnya lembut dan rasanya pas banget. Recommended!'),
(4, 1, 4.5, 'Enak banget! Anak-anak suka sekali. Cuma agak manis untuk saya, tapi overall bagus.'),
(5, 2, 5.0, 'Strawberry-nya fresh dan krimnya gak terlalu manis. Perfect untuk acara ulang tahun kemarin.'),
(3, 2, 4.0, 'Rasa strawberry-nya authentic, tapi harganya agak mahal. Tapi worth it sih untuk special occasion.'),
(4, 3, 5.0, 'Kue pelanginya cantik banget! Anak saya sampai gak mau makan karena sayang warna-warnanya 😄'),
(5, 3, 4.5, 'Warna-warninya menarik dan rasanya juga enak. Cocok buat foto Instagram!');

-- Verify users
SELECT 
    id,
    username,
    email,
    full_name,
    role,
    is_active,
    'password123' as sample_password
FROM users 
ORDER BY role, username;

SELECT 'Users updated successfully! 🍰' as status;
