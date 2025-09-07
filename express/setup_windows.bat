@echo off
echo.
echo 🍰 Sweet Dreams Bakery - Windows Setup Script
echo ================================================
echo.

echo 📝 This script will help you setup the database for Sweet Dreams Bakery
echo.

echo 🔍 Checking if MySQL is accessible...
mysql --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ MySQL command not found in PATH
    echo 💡 Please install MySQL or add it to your PATH variable
    echo 📖 See setup_database.md for manual instructions
    pause
    exit /b 1
)

echo ✅ MySQL found!
echo.

echo 🗄️  Creating database 'sweet_dreams_bakery'...
echo Please enter your MySQL root password when prompted.
echo.

mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS sweet_dreams_bakery; USE sweet_dreams_bakery;"

if %ERRORLEVEL% NEQ 0 (
    echo ❌ Failed to create database
    echo 🔍 Please check your MySQL credentials
    pause
    exit /b 1
)

echo ✅ Database created successfully!
echo.

echo 📊 Creating tables and inserting sample data...
mysql -u root -p sweet_dreams_bakery < create_cakes_table.sql

if %ERRORLEVEL% NEQ 0 (
    echo ❌ Failed to create tables
    echo 🔍 Please run the SQL script manually
    pause
    exit /b 1
)

echo ✅ Tables created and sample data inserted!
echo.

echo 🎯 Verifying setup...
mysql -u root -p sweet_dreams_bakery -e "SELECT COUNT(*) as total_cakes FROM cakes;"

echo.
echo 🎉 Database setup completed successfully!
echo.
echo 🚀 Next steps:
echo    1. Run: npm start
echo    2. Open browser: http://localhost:3000/cake
echo    3. Start Flutter app: cd ../my_app && flutter run
echo.
pause 