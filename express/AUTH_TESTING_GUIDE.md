# 🍰 Sweet Dreams Bakery - Authentication Testing Guide

## 🔐 Authentication System Overview

Sweet Dreams Bakery sekarang memiliki sistem autentikasi yang lengkap dengan:
- **User Registration** dengan field lengkap (username, email, full_name, phone)
- **Login/Logout** dengan JWT tokens
- **User Roles**: customer, admin, baker
- **Profile Management** dan password change
- **Review System** dengan user authentication

## 📋 Database Schema

### Users Table
```sql
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
    last_login TIMESTAMP NULL
);
```

### Reviews Table
```sql
CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    cake_id INT NOT NULL,
    rating DECIMAL(3,2) NOT NULL CHECK (rating >= 1.0 AND rating <= 5.0),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (cake_id) REFERENCES cakes(id) ON DELETE CASCADE
);
```

## 👥 Sample Users (Password: `password123`)

| Username | Email | Full Name | Role | Active |
|----------|--------|-----------|------|--------|
| admin | admin@sweetdreams.co.id | Admin Sweet Dreams | admin | ✅ |
| baker1 | baker@sweetdreams.co.id | Chef Maria Rodriguez | baker | ✅ |
| customer1 | andi.wijaya@gmail.com | Andi Wijaya | customer | ✅ |
| customer2 | sari.indah@yahoo.com | Sari Indah Permata | customer | ✅ |
| customer3 | budi.santoso@hotmail.com | Budi Santoso | customer | ✅ |

## 🧪 API Testing

### 1. User Registration
```http
POST /users/register
Content-Type: application/json

{
    "username": "testuser",
    "password": "testpass123",
    "email": "test@example.com",
    "full_name": "Test User",
    "phone": "+62-812-1234-5678"
}
```

**Expected Response:**
```json
{
    "id": 6,
    "username": "testuser",
    "email": "test@example.com",
    "full_name": "Test User",
    "message": "Registration successful! Welcome to Sweet Dreams Bakery! 🍰"
}
```

### 2. User Login
```http
POST /users/login
Content-Type: application/json

{
    "username": "customer1",
    "password": "password123"
}
```

**Expected Response:**
```json
{
    "user": {
        "id": 3,
        "username": "customer1",
        "email": "andi.wijaya@gmail.com",
        "full_name": "Andi Wijaya",
        "role": "customer"
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "message": "Welcome back to Sweet Dreams Bakery, Andi Wijaya! 🍰"
}
```

### 3. Get User Profile (Requires Authentication)
```http
GET /users/profile
Authorization: Bearer YOUR_JWT_TOKEN
```

### 4. Create Review (Requires Authentication)
```http
POST /reviews/create
Content-Type: application/json
Authorization: Bearer YOUR_JWT_TOKEN

{
    "user_id": 3,
    "cake_id": 1,
    "rating": 5.0,
    "comment": "Kue coklat terenak yang pernah saya coba!"
}
```

### 5. Get Reviews for Cake
```http
GET /reviews/cake/1
```

## 🚀 Testing Steps

### Step 1: Setup Database
```bash
# Run the complete SQL script
mysql -u root -p sweet_dreams_bakery < create_sweet_dreams_database.sql
```

### Step 2: Start Express Server
```bash
cd express
npm start

# Expected output:
# 🍰 Sweet Dreams Bakery - Connecting to database...
# ✅ Connected to Sweet Dreams Bakery database!
# 🍰 Ready to serve delicious cakes!
```

### Step 3: Test Authentication Endpoints

**A. Test Login**
```bash
curl -X POST http://localhost:3000/users/login \
  -H "Content-Type: application/json" \
  -d '{"username":"customer1","password":"password123"}'
```

**B. Test Registration**
```bash
curl -X POST http://localhost:3000/users/register \
  -H "Content-Type: application/json" \
  -d '{
    "username":"newuser",
    "password":"newpass123",
    "email":"new@example.com",
    "full_name":"New User",
    "phone":"+62-812-9999-8888"
  }'
```

**C. Test Protected Route**
```bash
# First login to get token, then:
curl -X GET http://localhost:3000/users/profile \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### Step 4: Test Review System

**A. Create Review**
```bash
curl -X POST http://localhost:3000/reviews/create \
  -H "Content-Type: application/json" \
  -d '{
    "user_id": 3,
    "cake_id": 1,
    "rating": 5.0,
    "comment": "Amazing chocolate cake!"
  }'
```

**B. Get Reviews**
```bash
curl -X GET http://localhost:3000/reviews/cake/1
```

## 🎯 Success Criteria

✅ **User Registration**
- Creates new user with all fields
- Validates unique username/email
- Hashes password properly
- Returns success message

✅ **User Login**
- Accepts username or email
- Validates password
- Returns JWT token
- Updates last_login timestamp
- Returns user info and welcome message

✅ **Protected Routes**
- Verify JWT token
- Return user information
- Handle expired/invalid tokens

✅ **Review System**
- Create reviews with rating (1-5)
- Link reviews to users and cakes
- Get reviews by cake ID
- Join queries return user and cake info

## 🔧 Troubleshooting

### Authentication Fails
1. Check if users table exists and has sample data
2. Verify password hashing (bcrypt)
3. Check JWT secret key configuration

### Reviews Not Working
1. Verify foreign key relationships
2. Check if reviews table exists
3. Validate rating constraints (1.0-5.0)

### Database Connection Issues
1. Verify MySQL is running
2. Check database name: `sweet_dreams_bakery`
3. Confirm all tables created successfully

## 📱 Flutter Integration

Update Flutter app to use new authentication system:

1. **Login Screen**: Update to handle new response format
2. **Registration Screen**: Add new fields (email, full_name, phone)
3. **User Profile**: Display full user information
4. **Review System**: Use user authentication for reviews

---

**🍰 Sweet Dreams Bakery Authentication is ready for testing!** 

All endpoints are properly themed with cake emojis and Indonesian messages. The system now supports a complete user experience with registration, login, profile management, and authenticated reviews.
