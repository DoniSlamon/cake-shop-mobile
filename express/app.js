require("dotenv").config()
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var cors = require('cors');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var foodRouter = require('./routes/foods');
// var googleRouter = require('./routes/google'); // Disabled - OAuth not configured
var monitorRouter = require('./routes/monitor');
var cakeRouter = require('./routes/cake');
var reviewRouter = require('./routes/review');

var app = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());


app.use(cors());

app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/foods', foodRouter);
// app.use("/google",googleRouter); // Disabled - OAuth not configured
app.use("/monitor",monitorRouter);
app.use("/cake",cakeRouter);
app.use("/reviews",reviewRouter);
app.use('/images', express.static("public/images"));

module.exports = app;
