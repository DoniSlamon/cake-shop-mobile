var express = require("express");
var router = express.Router();
var session = require("express-session");

var passport = require("passport");
var GoogleStrategy = require("passport-google-oauth20").Strategy;
var db = require("../database/db");
var jwt = require("jsonwebtoken");
router.use(
  session({
    secret: "keyboard cat",
    resave: false,
    saveUninitialized: false,
  })
);

passport.use(
  new GoogleStrategy(
    {
      clientID: process.env.CLIENT_ID,
      clientSecret: process.env.CLIENT_SECRET,
      callbackURL: "http://localhost:3000/google/auth/google/callback",
    },
    function (accessToken, refreshToken, profile, cb) {
      db.query("select username,password from users where oauth_id = ?", [profile.id],
    (error,result)=>{
      if(error) cb(error)
         if(result.length ===0){
        db.query("insert into users (username,oauth_id) values (?,?)",[
          profile.displayName,
          profile.id
        ],(error,result)=>{
          if(error) cb(error)
          else {
         const token = jwt.sign(
          {
            username: profile.displayName
          },process.env.SECRET_KEY,
          {
            expiresIn: "1d"
          }
         )
         cb(null,{
          username:profile.displayName,
          token: token,
         })
      }
        })
      }else {
         const token = jwt.sign(
          {
            username: profile.displayName
          },process.env.SECRET_KEY,
          {
            expiresIn: "1d"
          }
         )
         cb(null,{
          username: profile.displayName,
          token: token,
         })
      }
    })
     
      
    }
  )
);

passport.serializeUser(function (user, cb) {
  process.nextTick(function () {
    cb(null, { id: user.id, username: user.username, name: user.name });
  });
});

passport.deserializeUser(function (user, cb) {
  process.nextTick(function () {
    return cb(null, user);
  });
});

router.get(
  "/auth/google",
  passport.authenticate("google", { scope: ["profile"] })
);

router.get(
  "/auth/google/callback",
  passport.authenticate("google", { failureRedirect: "/login" }),
  function (req, res) {
    res.redirect("/");
    res.status(200).json(req.user);
  }
);

module.exports = router;
