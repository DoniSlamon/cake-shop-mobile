# 🍰 Sweet Dreams Bakery - Database Setup Guide

## 📋 Prerequisites
- MySQL Server installed and running
- MySQL command line client or MySQL Workbench

## 🚀 Quick Setup Steps

### 1. Start MySQL Server
**Windows:**
```bash
# If using XAMPP
Start XAMPP Control Panel → Start MySQL

# If using MySQL Windows Service
net start mysql
```

**Mac/Linux:**
```bash
sudo systemctl start mysql
# or
brew services start mysql
```

### 2. Create Database
```sql
-- Connect to MySQL as root
mysql -u root -p

-- Create the database
CREATE DATABASE sweet_dreams_bakery;

-- Use the database
USE sweet_dreams_bakery;

-- Exit MySQL
EXIT;
```

### 3. Run the SQL Script
```bash
# Navigate to express directory
cd express

# Run the SQL script to create tables and insert sample data
mysql -u root -p sweet_dreams_bakery < create_cakes_table.sql
```

### 4. Verify Setup
```sql
-- Connect to the database
mysql -u root -p sweet_dreams_bakery

-- Check if table exists
SHOW TABLES;

-- Check sample data
SELECT * FROM cakes;

-- Exit
EXIT;
```

## 🔧 Alternative Setup Methods

### Method 1: Using MySQL Workbench
1. Open MySQL Workbench
2. Connect to your MySQL server
3. Create new schema: `sweet_dreams_bakery`
4. Open the `create_cakes_table.sql` file
5. Execute the script

### Method 2: Manual Table Creation
If the SQL file doesn't work, create manually:

```sql
CREATE DATABASE sweet_dreams_bakery;
USE sweet_dreams_bakery;

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

-- Insert sample data
INSERT INTO cakes (name, category, flavor, size, weight, description, price, image_path, is_available, rating) VALUES
('Chocolate Dream Cake', 'Birthday Cakes', 'Rich chocolate with vanilla cream', 'Medium (8 inch)', 1000, 'Kue coklat yang lezat dengan lapisan krim vanilla yang lembut. Cocok untuk perayaan ulang tahun atau acara spesial.', 150000, 'images/monitor1.jpg', TRUE, 4.5),
('Strawberry Delight', 'Birthday Cakes', 'Fresh strawberries with vanilla sponge', 'Medium (8 inch)', 950, 'Kue sponge vanilla yang lembut dengan potongan strawberry segar dan krim yang lezat.', 175000, 'images/monitor2.jpg', TRUE, 4.8),
('Rainbow Birthday Special', 'Birthday Cakes', 'Colorful layers with buttercream', 'Large (10 inch)', 1500, 'Kue pelangi dengan berbagai lapisan warna-warni dan buttercream yang manis. Perfect untuk ulang tahun anak-anak.', 200000, 'images/monitor3.jpg', TRUE, 4.7);
```

## 🔑 Database Configuration

### Option 1: Create .env file (Recommended)
Create a `.env` file in the express directory:
```
DATABASE_HOST=localhost
DATABASE_PORT=3306
DATABASE_USER=root
DATABASE_PASSWORD=your_mysql_password
DATABASE_NAME=sweet_dreams_bakery
```

### Option 2: Edit db.js directly
If you can't create .env file, edit `database/db.js` and change:
```javascript
const dbConfig = {
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: 'YOUR_MYSQL_PASSWORD', // Change this!
    database: 'sweet_dreams_bakery'
};
```

## 🔍 Troubleshooting

### Error: ECONNREFUSED 127.0.0.1:3306
- **Cause**: MySQL server is not running
- **Fix**: Start MySQL server (see step 1 above)

### Error: Access denied for user 'root'
- **Cause**: Wrong password or user doesn't exist
- **Fix**: Check your MySQL root password or create new user

### Error: Unknown database 'sweet_dreams_bakery'
- **Cause**: Database doesn't exist
- **Fix**: Run step 2 above to create the database

### Error: Table 'cakes' doesn't exist
- **Cause**: SQL script wasn't executed
- **Fix**: Run step 3 above to create tables

## ✅ Success Indicators
When everything is working, you should see:
```
🍰 Sweet Dreams Bakery - Connecting to database...
📍 Host: localhost:3306
🗄️  Database: sweet_dreams_bakery
👤 User: root
✅ Connected to Sweet Dreams Bakery database!
🍰 Ready to serve delicious cakes!
```

## 🎯 Next Steps
After database setup is complete:
1. Start the Express server: `npm start`
2. Test the API endpoints:
   - GET http://localhost:3000/cake (should return sample cakes)
3. Start the Flutter app: `cd ../my_app && flutter run`

---
**Sweet Dreams Bakery** - *Database powered by love! 🍰💾* 