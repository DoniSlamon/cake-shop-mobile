var express = require("express")
var router = express.Router()
var db = require("./../database/db")
var multer = require("multer")
var auth = require("./../middleware/auth")


function createCake(
    name,
    category,
    flavor,
    size,
    weight,
    description,
    price,
    image_path,
    is_available = true
  ) {
    return new Promise((resolve, reject) => {

      if (
        !name ||
        !category ||
        !flavor ||
        !size ||
        !weight ||
        !description ||
        !price ||
        !image_path
      ) {
        return reject(new Error("Missing required fields"));
      }
  
      const query =
        "INSERT INTO cakes (name, category, flavor, size, weight, description, price, image_path, is_available, rating) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
  
     
      db.query(
        query,
        [name, category, flavor, size, weight, description, price, image_path, is_available, 0.0],
        (err, results) => {
          if (err) {
            console.error("Database insertion error:", err.message);
            return reject(err);
          }
  

          resolve(results);
        }
      );
    });
  }

function getCakes(){ 
    return new Promise((resolve, reject) => {
        db.query("SELECT * FROM cakes", (err, results) => {
            if(err) reject(err)
            else resolve(results)
        })
    })
}

function getCakeById(id){ 
    return new Promise((resolve, reject) => {
        db.query(`SELECT * FROM cakes WHERE id = ?`, [id], (err, results) => {
            if(err) reject(err)
            else resolve(results)
        })
    })
}

function updateCakeRating(id, rating) {
    return new Promise((resolve, reject) => {
        db.query(
            `UPDATE cakes SET rating = ? WHERE id = ?`, 
            [rating, id], 
            (err, results) => {
                if(err) reject(err)
                else resolve(results)
            }
        )
    })
}

function updateCakeAvailability(id, is_available) {
    return new Promise((resolve, reject) => {
        db.query(
            `UPDATE cakes SET is_available = ? WHERE id = ?`, 
            [is_available, id], 
            (err, results) => {
                if(err) reject(err)
                else resolve(results)
            }
        )
    })
}

// Get all cakes
router.get('/', function (req, res, next){
    getCakes().then(
        (result)=>{
            res.status(200).json(result)
        },
        (error)=>{
            res.status(500).send(error)
        }
    )
})

// Get cake by ID
router.get("/get/:id", function (req, res, next){
    getCakeById(req.params.id).then(
        (result)=>{
            if (result.length > 0) {
                res.status(200).json(result[0])
            } else {
                res.status(404).json({ message: "Cake not found" })
            }
        },
        (error)=>{
            res.status(500).send(error)
        }
    )
})

// Update cake rating
router.put("/rating/:id", function (req, res, next){
    const { rating } = req.body;
    
    if (!rating || rating < 0 || rating > 5) {
        return res.status(400).json({ message: "Invalid rating. Must be between 0 and 5." });
    }
    
    updateCakeRating(req.params.id, rating).then(
        (result)=>{
            res.status(200).json({ message: "Rating updated successfully" })
        },
        (error)=>{
            res.status(500).send(error)
        }
    )
})

// Update cake availability
router.put("/availability/:id", function (req, res, next){
    const { is_available } = req.body;
    
    updateCakeAvailability(req.params.id, is_available).then(
        (result)=>{
            res.status(200).json({ message: "Availability updated successfully" })
        },
        (error)=>{
            res.status(500).send(error)
        }
    )
})

var storage = multer.diskStorage({
    destination: (req, file, cb) =>{
        cb(null, 'public/images')
    },
    filename: (req, file, cb) => {
        cb(null, `${Date.now()}${file.originalname}`)
    }   
})

var upload = multer({
    storage: storage
})

// Create new cake
router.post("/create", upload.single("image"), function (req, res, next){
    const body = req.body
    const imagePath = req.file.path.replace("public\\", "");
    
    createCake(
        body.name,
        body.category,
        body.flavor,
        body.size,
        body.weight,
        body.description,
        body.price,
        imagePath,
        body.is_available === 'true'
    ).then(
        (result)=>{
            res.status(200).json({ 
                message: "Cake created successfully",
                id: result.insertId 
            })
        },
        (error)=>{
            res.status(500).send(error)
        }
    )
})

module.exports = router;
