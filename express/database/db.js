var mysql2 = require('mysql2');
const path = require('path');

// Try to load config, fallback to defaults if env variables not set
const dbConfig = {
    host: process.env.DATABASE_HOST || 'localhost',
    port: process.env.DATABASE_PORT || 3306,
    user: process.env.DATABASE_USER || 'root',
    password: process.env.DATABASE_PASSWORD || '',
    database: 'sweet_dreams_bakery', // Force use Sweet Dreams Bakery database
    // Remove invalid MySQL2 configuration options
    connectTimeout: 60000
};

console.log('🍰 Sweet Dreams Bakery - Connecting to database...');
console.log(`📍 Host: ${dbConfig.host}:${dbConfig.port}`);
console.log(`🗄️  Database: ${dbConfig.database}`);
console.log(`👤 User: ${dbConfig.user}`);

var db = mysql2.createConnection(dbConfig);

db.connect((err) => {
    if (err) {
        console.error('❌ Database connection failed!');
        console.error('🔍 Error details:', err.message);
        console.log('\n📝 Quick Fix Instructions:');
        console.log('1. Make sure MySQL server is running');
        console.log('2. Check if the database exists: CREATE DATABASE sweet_dreams_bakery;');
        console.log('3. Verify your MySQL credentials');
        console.log('4. Run the SQL script: mysql -u root -p sweet_dreams_bakery < create_cakes_table.sql\n');
        
        // Don't throw error immediately, allow server to start
        console.log('⚠️  Server will start without database connection. Fix database and restart.');
        return;
    }
    console.log('✅ Connected to Sweet Dreams Bakery database!');
    console.log('🍰 Ready to serve delicious cakes!\n');
});

// Handle connection errors
db.on('error', function(err) {
    console.error('Database error:', err);
    if (err.code === 'PROTOCOL_CONNECTION_LOST') {
        console.log('Attempting to reconnect to database...');
        // Handle reconnection if needed
    } else {
        throw err;
    }
});

module.exports = db;