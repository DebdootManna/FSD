const express = require('express');
const router = express.Router();
const multer = require('multer');
const path = require('path');

// Set up storage engine
const storage = multer.diskStorage({
  destination: './public/uploads/',
  filename: function(req, file, cb){
    cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname));
  }
});

// File filter for PDF
const fileFilter = (req, file, cb) => {
  if (file.mimetype === 'application/pdf') {
    cb(null, true);
  } else {
    cb(new Error('Invalid file type. Only PDF files are allowed.'), false);
  }
};

// Initialize upload
const upload = multer({
  storage: storage,
  limits: { fileSize: 2 * 1024 * 1024 }, // 2MB limit
  fileFilter: fileFilter
}).single('resume'); // 'resume' is the name attribute of the input field

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index');
});

/* POST upload route */
router.post('/upload', function(req, res) {
  upload(req, res, function(err) {
    if (err) {
      if (err.code === 'LIMIT_FILE_SIZE') {
        err.message = 'File is too large. Maximum size is 2MB.';
      }
      res.render('index', { message: err.message, error: true });
    } else {
      if (req.file == undefined) {
        res.render('index', { message: 'No file selected!', error: true });
      } else {
        res.render('index', { message: 'File uploaded successfully!', error: false });
      }
    }
  });
});

module.exports = router;
