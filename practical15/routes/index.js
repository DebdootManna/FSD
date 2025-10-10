var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { user: req.session.user });
});

// GET login page
router.get('/login', function(req, res, next) {
  res.render('login');
});

// POST login
router.post('/login', function(req, res, next) {
  req.session.user = {
    name: req.body.username,
    loginTime: new Date()
  };
  res.redirect('/profile');
});

// GET profile page
router.get('/profile', function(req, res, next) {
  if (req.session.user) {
    res.render('profile', { user: req.session.user });
  } else {
    res.redirect('/login');
  }
});

// GET logout
router.get('/logout', function(req, res, next) {
  req.session.destroy(function(err) {
    if (err) {
      return next(err);
    }
    res.redirect('/');
  });
});

module.exports = router;
