# 🍰 Sweet Dreams Bakery - Manual Database Setup

## 📋 Cara Manual Setup Database

### 🚀 Opsi 1: Setup Lengkap Sekaligus

1. **Buka MySQL Command Line atau MySQL Workbench**
2. **Login ke MySQL**:
   ```bash
   mysql -u root -p
   ```
3. **Run script lengkap**:
   ```bash
   # Di command line MySQL:
   source F:/business/free/express/create_sweet_dreams_database.sql;
   
   # ATAU copy-paste isi file create_sweet_dreams_database.sql
   ```

### 🛠️ Opsi 2: Setup Step by Step

#### Step 1: Create Database
```sql
CREATE DATABASE IF NOT EXISTS sweet_dreams_bakery;
USE sweet_dreams_bakery;
```

#### Step 2: Create Table
```sql
CREATE TABLE cakes (
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
```

#### Step 3: Insert Sample Data
```sql
INSERT INTO cakes (name, category, flavor, size, weight, description, price, image_path, is_available, rating) VALUES
('Chocolate Dream Cake', 'Birthday Cakes', 'Rich chocolate with vanilla cream', 'Medium (8 inch)', 1000, 'Kue coklat yang lezat dengan lapisan krim vanilla yang lembut', 150000, 'images/monitor1.jpg', TRUE, 4.5),
('Strawberry Delight', 'Birthday Cakes', 'Fresh strawberries with vanilla sponge', 'Medium (8 inch)', 950, 'Kue sponge vanilla yang lembut dengan potongan strawberry segar', 175000, 'images/monitor2.jpg', TRUE, 4.8),
('Rainbow Birthday Special', 'Birthday Cakes', 'Colorful layers with buttercream', 'Large (10 inch)', 1500, 'Kue pelangi dengan berbagai lapisan warna-warni dan buttercream yang manis', 200000, 'images/monitor3.jpg', TRUE, 4.7),
('Vanilla Cupcakes (6 pcs)', 'Cupcakes', 'Classic vanilla with buttercream', 'Individual', 300, 'Set 6 cupcakes vanilla klasik dengan buttercream topping', 75000, 'images/monitor1.jpg', TRUE, 4.3),
('Red Velvet Romance', 'Wedding Cakes', 'Red velvet with cream cheese frosting', 'Extra Large (12 inch)', 2500, 'Kue red velvet yang mewah dengan cream cheese frosting', 450000, 'images/monitor2.jpg', TRUE, 4.9);
```

#### Step 4: Verify Setup
```sql
-- Check tables
SHOW TABLES;

-- Check data
SELECT COUNT(*) as total_cakes FROM cakes;
SELECT * FROM cakes LIMIT 5;

-- Check by category
SELECT category, COUNT(*) as count FROM cakes GROUP BY category;
```

### 🖥️ Opsi 3: Menggunakan MySQL Workbench

1. **Buka MySQL Workbench**
2. **Connect ke MySQL server Anda**
3. **Klik "Create a new schema"** atau jalankan:
   ```sql
   CREATE DATABASE sweet_dreams_bakery;
   ```
4. **Set sebagai default schema**: Klik kanan pada `sweet_dreams_bakery` → "Set as Default Schema"
5. **Buka file SQL**:
   - File → Open SQL Script
   - Pilih file `create_sweet_dreams_database.sql`
   - Klik Execute (⚡)

### 🎯 Opsi 4: Import dari Command Line

```bash
# Navigate ke folder express
cd F:/business/free/express

# Create database first
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS sweet_dreams_bakery;"

# Import the SQL file
mysql -u root -p sweet_dreams_bakery < create_sweet_dreams_database.sql
```

## ✅ Verifikasi Setup Berhasil

Setelah setup, test dengan query ini:

```sql
USE sweet_dreams_bakery;
SELECT 
    COUNT(*) as total_cakes,
    COUNT(CASE WHEN is_available = TRUE THEN 1 END) as available_cakes,
    COUNT(DISTINCT category) as categories
FROM cakes;
```

**Expected Output:**
```
total_cakes: 12
available_cakes: 11  
categories: 5
```

## 🔧 Files Yang Tersedia

1. **`create_sweet_dreams_database.sql`** - Setup lengkap dengan 12 sample cakes
2. **`step_by_step_setup.sql`** - Setup bertahap dengan 3 sample cakes
3. **`create_cakes_table.sql`** - File original (basic)

## 🚀 Setelah Database Setup

1. **Test koneksi Express.js**:
   ```bash
   cd express
   npm start
   ```

2. **Test API endpoint**:
   ```bash
   # Buka browser atau use curl:
   http://localhost:3000/cake
   ```

3. **Run Flutter app**:
   ```bash
   cd my_app
   flutter run
   ```

## 🆘 Troubleshooting

### Error: "Table doesn't exist"
- Pastikan sudah run CREATE TABLE
- Check: `SHOW TABLES;`

### Error: "Database doesn't exist" 
- Run: `CREATE DATABASE sweet_dreams_bakery;`
- Check: `SHOW DATABASES;`

### Error: "Access denied"
- Check username/password MySQL
- Try: `mysql -u root -p`

---
**Sweet Dreams Bakery** - *Manual setup made easy! 🍰📝*
