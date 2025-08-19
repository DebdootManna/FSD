var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.get('/home' , function(req,res,next) {
  res.render('home' , {title: 'Home'});
})

router.get('/about' , function(req,res,next) {
  res.render('about' , {title: 'About'});
})

router.get('/addstudent' , function(req,res,next) {
  res.render('addstudent' , {title: 'Add Student'});
})

module.exports = router;
