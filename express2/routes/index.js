var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});
router.get('/home', function(req, res, next) {
  res.render('home', { title: 'Express' });
});
router.get('/about', function(req, res, next) {
  res.render('about', { title: 'Express' });
});
router.get('/contact', function(req, res, next) {
  res.render('contact', { title: 'Express' });
});

router.get('/add-student', function(req, res, next) {
  res.render('add-student', { title: 'Add Student' });
  var StudentData = {
    name: req.body.name,
    age: req.body.age,
    email: req.body.email
  }

  var mydata = new Student(StudentData);
  mydata.save()
    .then(item => {
      res.send("Student saved to database");
    })
    .catch(err => {
      res.status(400).send("Unable to save to database");
    });

    Student.find({}, function(err, students) {
      if (err) return console.error(err);
      res.render('students', { title: 'Students List', students: students });
    });
});

module.exports = router;
