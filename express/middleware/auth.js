var jwt = require('jsonwebtoken');

auth = (req,res,next) => {
    token = req.headers["authorization"]
    jwt.verify(token,process.env.SECRET_KEY,(error,decoded) => {
        if(!!error) return res.status(401).send(token);
        req.user = {
            username: decoded.username
        }
        next();
    })
}

module.exports = auth