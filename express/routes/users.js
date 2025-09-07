var express = require('express');
var router = express.Router();
var db = require('../database/db');
var bcrypt = require("bcrypt");
var jwt = require("jsonwebtoken");

// Sweet Dreams Bakery - User Authentication
const SECRET_KEY = process.env.JWT_SECRET || 'sweet_dreams_secret_key_2024';

function verifyToken(req, res, next) {
  const authHeader = req.headers['authorization'];
  
  if (!authHeader) {
    return res.status(401).send('Access Denied: No Token Provided!');
  }

  const token = authHeader.split(' ')[1];
  
  jwt.verify(token, SECRET_KEY, (err, user) => {
    if (err) {
      return res.status(403).send('Invalid Token');
    }
    
    req.user = user;
    next();
  });
}


function Register(username, password, email, fullName, phone) {
  return new Promise(function (resolve, reject) {
    // Validate required fields
    if (!username || !password || !email || !fullName) {
      return reject("Missing required fields");
    }

    // Check if user already exists
    db.query("SELECT * FROM users WHERE username = ? OR email = ?", [username, email],
      (error, result) => {
        if (error) {
          reject(error);
        } else if (result.length > 0) {
          reject("User with this username or email already exists");
        } else {
          // Create new user
          var hashedPassword = bcrypt.hashSync(password, 10);
          db.query(
            "INSERT INTO users (username, password, email, full_name, phone, role, is_active, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, NOW())", 
            [username, hashedPassword, email, fullName, phone || null, 'customer', true],
            (error, result) => {
              if (error) reject(error);
              else resolve({ 
                id: result.insertId, 
                username: username, 
                email: email,
                full_name: fullName,
                message: "Registration successful! Welcome to Sweet Dreams Bakery! 🍰" 
              });
            }
          );
        }
      }
    );
  });
}

function Login(username, password) {
  return new Promise(function (resolve, reject) {
    // Allow login with username or email
    db.query("SELECT * FROM users WHERE username = ? OR email = ?", [username, username],
      (error, result) => {
        if (error) {
          reject(error);
        } else if (result.length === 0) {
          reject("User not found. Please check your username/email.");
        } else if (!result[0].is_active) {
          reject("Account is deactivated. Please contact Sweet Dreams Bakery.");
        } else if (!bcrypt.compareSync(password, result[0].password)) {
          reject("Incorrect password. Please try again.");
        } else {
          const user = result[0];
          const token = jwt.sign({ 
            id: user.id,
            username: user.username,
            email: user.email,
            role: user.role
          }, SECRET_KEY, { expiresIn: '24h' });
          
          // Update last login
          db.query("UPDATE users SET last_login = NOW() WHERE id = ?", [user.id]);
          
          resolve({ 
            user: {
              id: user.id,
              username: user.username,
              email: user.email,
              full_name: user.full_name,
              role: user.role
            },
            token: token,
            message: `Welcome back to Sweet Dreams Bakery, ${user.full_name}! 🍰`
          });
        }
      }
    );
  });
}


function Logout() {
  return new Promise(function (resolve) {
    resolve("Success");
  });
}



router.post('/login', function (req, res) {
  const body = req.body;
  console.log('🍰 Sweet Dreams Bakery - Login attempt:', { username: body.username });

  Login(body.username, body.password).then(
    (result) => {
      console.log('✅ Login successful for user:', result.user.username);
      res.status(200).json(result);
    },
    (error) => {
      console.log('❌ Login failed:', error);
      res.status(401).json({ error: error });
    }
  );
});

router.post('/register', function (req, res) {
  const body = req.body;
  Register(body.username, body.password, body.email, body.full_name, body.phone).then(
    (result) => {
      res.status(200).json(result);
    },
    (error) => {
      res.status(400).json({ error: error });
    }
  );
});

router.get('/current_user', verifyToken, function (req, res) {
  res.status(200).send(req.user);
}

);




router.post('/logout', function (req, res) {
  Logout().then(
    (result) => {
      res.status(200).json({ message: "Logged out successfully. Thanks for visiting Sweet Dreams Bakery! 🍰" });
    }
  );
});

// Get user profile
router.get('/profile', verifyToken, function (req, res) {
  db.query("SELECT id, username, email, full_name, phone, role, created_at, last_login FROM users WHERE id = ?", [req.user.id],
    (error, result) => {
      if (error) {
        res.status(500).json({ error: error });
      } else if (result.length === 0) {
        res.status(404).json({ error: "User not found" });
      } else {
        res.status(200).json({ user: result[0] });
      }
    }
  );
});

// Update user profile
router.put('/profile', verifyToken, function (req, res) {
  const { full_name, phone, email } = req.body;
  
  db.query("UPDATE users SET full_name = ?, phone = ?, email = ?, updated_at = NOW() WHERE id = ?", 
    [full_name, phone, email, req.user.id],
    (error, result) => {
      if (error) {
        res.status(500).json({ error: error });
      } else {
        res.status(200).json({ message: "Profile updated successfully! 🍰" });
      }
    }
  );
});

// Change password
router.put('/change-password', verifyToken, function (req, res) {
  const { current_password, new_password } = req.body;
  
  if (!current_password || !new_password) {
    return res.status(400).json({ error: "Current password and new password are required" });
  }
  
  // Verify current password
  db.query("SELECT password FROM users WHERE id = ?", [req.user.id],
    (error, result) => {
      if (error) {
        res.status(500).json({ error: error });
      } else if (result.length === 0) {
        res.status(404).json({ error: "User not found" });
      } else if (!bcrypt.compareSync(current_password, result[0].password)) {
        res.status(401).json({ error: "Current password is incorrect" });
      } else {
        // Update password
        const hashedNewPassword = bcrypt.hashSync(new_password, 10);
        db.query("UPDATE users SET password = ?, updated_at = NOW() WHERE id = ?", 
          [hashedNewPassword, req.user.id],
          (error, result) => {
            if (error) {
              res.status(500).json({ error: error });
            } else {
              res.status(200).json({ message: "Password changed successfully! 🔒" });
            }
          }
        );
      }
    }
  );
});

module.exports = router;
