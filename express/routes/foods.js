var express = require("express")
var router = express.Router()
var db = require("./../database/db")
var multer = require("multer")
var auth = require("./../middleware/auth")


function createFoodInDb(
    name,
    category,
    is_spicy,
    level_of_spice,
    vegetarian,
    image,
    date){
        return new Promise((resolve, reject) => {
        db.query("insert into foods (name,category,is_spicy,level_of_spice,vegetarian,image,date) values (?,?,?,?,?,?,?)",[name,category,is_spicy,level_of_spice,vegetarian,image,date] ,(err, results) => {
            if(err) reject(err)
            else resolve(results)
        })
    })
}
function getfoods(){ 
    return new Promise((resolve, reject) => {
        db.query("SELECT * FROM foods", (err, results) => {
            if(err) reject(err)
            else resolve(results)
        })
    })
}
function getfoodbyid(id){ 
    return new Promise((resolve, reject) => {
        db.query(`SELECT * FROM foods where id= ? `,[id], (err, results) => {
            if(err) reject(err)
            else resolve(results)
        })
    })
}
router.get('/', function (req,res,next){
    getfoods().then(
        (result)=>{
            res.status(200).json(result)
        },
        (error)=>{
            res.status(500).send(error)
        }
    )
    
})



router.get("/get/:id",auth, function (req, res, next){
    console.log(req.user.username)
    getfoodbyid(req.params.id).then(
        (result)=>{
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
    createFoodInDb(body.name,body.category,body.is_spicy,body.level_of_spice,
        body.vegetarian,
        req.file.path.replace("public\\",""),
        body.date).then(
        (result)=>{
            res.status(200).json(result)
        },
        (error)=>{
            res.status(500).send(error)
        }
    )
})
module.exports = router;
