var express = require("express")
var router = express.Router()
var db = require("./../database/db")
var multer = require("multer")
var auth = require("./../middleware/auth")


function createMonitor(
    name,
    category,
    brand,
    resolution,
    refresh_rate,
    srgb,
    price
    ,image_path
  ) {
    return new Promise((resolve, reject) => {

      if (
        !name ||
        !category ||
        !brand ||
        !resolution ||
        !refresh_rate ||
        !srgb ||
        !price ||
        !image_path
      ) {
        return reject(new Error("Missing required fields"));
      }
  
      const query =
        "INSERT INTO monitors (name, category, brand, resolution, refresh_rate, srgb, price,image_path) VALUES (?, ?, ?, ?, ?, ?, ?,?)";
  
     
      db.query(
        query,
        [name, category, brand, resolution, refresh_rate, srgb, price, image_path],
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
function getMonitors(){ 
    return new Promise((resolve, reject) => {
        db.query("SELECT * FROM Monitors", (err, results) => {
            if(err) reject(err)
            else resolve(results)
        })
    })
}
function getMonitorbyid(id){ 
    return new Promise((resolve, reject) => {
        db.query(`SELECT * FROM monitors where id= ? `,[id], (err, results) => {
            if(err) reject(err)
            else resolve(results)
        })
    })
}
router.get('/', function (req,res,next){
    getMonitors().then(
        (result)=>{
            res.status(200).json(result)
        },
        (error)=>{
            res.status(500).send(error)
        }
    )
    
})



router.get("/get/:id", function (req, res, next){
    getMonitorbyid(req.params.id).then(
        (result)=>{
            // if (result.image_url) {
            //     result.image_url = `http://localhost:3000/${result.image_url}`;
            //   }
                res.status(200).json(result)
        },
        (error)=>{
            res.status(500).send(error)
        }
    )
})

var storage = multer.diskStorage({
    destination: (req,file,cb) =>{
        cb(null, 'public/images')
    },
    filename: (req, file, cb) => {
        cb(null, `${Date.now()}${file.originalname}`)
    }   
})


var upload = multer({
    storage:storage
})
router.post("/create", upload.single("image"), function (req, res, next){
    const body= req.body
    const imagePath = req.file.path.replace("public\\", "");
    createMonitor(
        body.name,body.category,body.brand,body.resolution,body.refresh_rate,body.srgb,body.price,
        imagePath,
        ).then(
        (result)=>{
            res.status(200).json(result)
        },
        (error)=>{
            res.status(500).send(error)
        }
    )
})
module.exports = router;
