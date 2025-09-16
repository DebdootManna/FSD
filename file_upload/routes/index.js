var express = require('express');
var router = express.Router();
const path = require('path');
const fs = require('fs');

// Ensure uploads directory exists
const uploadDir = path.join(__dirname, '../public/images');
if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir, { recursive: true });
}

/* GET home page. */
router.get('/', function(req, res, next) {
  // Read the contents of the images directory
  fs.readdir(uploadDir, (err, files) => {
    if (err) return next(err);
    
    // Filter out any non-image files and create full URLs
    const images = files
      .filter(file => /\.(jpg|jpeg|png|gif)$/i.test(file))
      .map(file => `/images/${file}`);
      
    res.render('file_upload', { 
      title: 'Image Upload',
      images: images
    });
  });
});

// Handle file upload
router.post('/upload', (req, res, next) => {
  if (!req.files || !req.files.image) {
    return res.status(400).send('No files were uploaded.');
  }

  const image = req.files.image;
  const uploadPath = path.join(uploadDir, image.name);

  // Move the uploaded file to the upload directory
  image.mv(uploadPath, (err) => {
    if (err) return res.status(500).send(err);
    res.redirect('/');
  });
});

module.exports = router;
