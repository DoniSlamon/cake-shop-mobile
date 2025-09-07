// Sweet Dreams Bakery - Database Configuration
module.exports = {
  development: {
    host: process.env.DATABASE_HOST || 'localhost',
    port: process.env.DATABASE_PORT || 3306,
    user: process.env.DATABASE_USER || 'root',
    password: process.env.DATABASE_PASSWORD || '',
    database: process.env.DATABASE_NAME || 'sweet_dreams_bakery'
  },
  production: {
    host: process.env.DATABASE_HOST || 'localhost',
    port: process.env.DATABASE_PORT || 3306,
    user: process.env.DATABASE_USER || 'root',
    password: process.env.DATABASE_PASSWORD || '',
    database: process.env.DATABASE_NAME || 'sweet_dreams_bakery'
  }
};

// Default configuration for quick setup
const defaultConfig = {
  host: 'localhost',
  port: 3306,
  user: 'root',
  password: '', // Change this to your MySQL root password
  database: 'sweet_dreams_bakery'
};

module.exports.default = defaultConfig; 