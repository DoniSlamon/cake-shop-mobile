-- ============================================
-- 🍰 Sweet Dreams Bakery - Update Cake Images
-- ============================================

-- Update all cake images to use beautiful real cake photos from Unsplash

USE sweet_dreams_bakery;

-- Update cake images with beautiful real cake photos
UPDATE cakes SET image_path = 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80' WHERE id = 1; -- Chocolate Dream Cake
UPDATE cakes SET image_path = 'https://images.unsplash.com/photo-1551024506-0bccd828d307?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80' WHERE id = 2; -- Strawberry Delight
UPDATE cakes SET image_path = 'https://images.unsplash.com/photo-1464349095431-e9a21285b5f3?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80' WHERE id = 3; -- Rainbow Birthday Special
UPDATE cakes SET image_path = 'https://images.unsplash.com/photo-1586985289688-ca3cf47d3e6e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80' WHERE id = 4; -- Classic Red Velvet
UPDATE cakes SET image_path = 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80' WHERE id = 5; -- Tiramisu Heaven
UPDATE cakes SET image_path = 'https://images.unsplash.com/photo-1519915028121-7d3463d20b13?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80' WHERE id = 6; -- Lemon Zest Cake
UPDATE cakes SET image_path = 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80' WHERE id = 7; -- Chocolate Fudge Brownie
UPDATE cakes SET image_path = 'https://images.unsplash.com/photo-1576618148400-f54bed99fcfd?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80' WHERE id = 8; -- Vanilla Bean Cupcakes
UPDATE cakes SET image_path = 'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80' WHERE id = 9; -- Black Forest Cake
UPDATE cakes SET image_path = 'https://images.unsplash.com/photo-1563729784474-d77dbb933a9e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80' WHERE id = 10; -- Carrot Cake with Nuts
UPDATE cakes SET image_path = 'https://images.unsplash.com/photo-1524351199678-941a58a3df50?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80' WHERE id = 11; -- Blueberry Cheesecake
UPDATE cakes SET image_path = 'https://images.unsplash.com/photo-1488477181946-6428a0291777?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80' WHERE id = 12; -- Unicorn Fantasy Cake

-- Verify the updates
SELECT 
    id,
    name,
    category,
    price,
    image_path,
    rating
FROM cakes 
ORDER BY id;

SELECT '🍰 Cake images updated with beautiful real photos! ✨' as status;
