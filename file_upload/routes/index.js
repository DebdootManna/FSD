const express = require('express');
const router = express.Router();
const path = require('path');
const fs = require('fs');

// Ensure uploads directory exists
const uploadDir = path.join(__dirname, '../public/images');
if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir, { recursive: true });
}

// Middleware to check if user is authenticated
const requireLogin = (req, res, next) => {
    if (!req.session.authenticated) {
        return res.redirect('/login');
    }
    next();
};

// Login page
router.get('/login', (req, res) => {
    if (req.session.authenticated) {
        return res.redirect('/');
    }
    res.render('login', { title: 'Login', error: null });
});

// Handle login form submission
router.post('/login', (req, res) => {
    const { username } = req.body;
    
    if (username === 'hello') {
        req.session.authenticated = true;
        req.session.username = username;
        return res.redirect('/');
    }
    
    res.render('login', { 
        title: 'Login', 
        error: 'Invalid username!' 
    });
});

// Logout route
router.get('/logout', (req, res) => {
    req.session.destroy();
    res.redirect('/login');
});

// Home page - requires login
router.get('/', requireLogin, (req, res, next) => {
    // Read the contents of the images directory
    fs.readdir(uploadDir, (err, files) => {
        if (err) return next(err);
        
        // Filter out any non-image files and create full URLs
        const images = files
            .filter(file => /\.(jpg|jpeg|png|gif)$/i.test(file))
            .map(file => `/images/${file}`);
            
        res.render('file_upload', { 
            title: 'Image Upload',
            images: images,
            username: req.session.username
        });
    });
});

// Handle file upload - requires login
router.post('/upload', requireLogin, (req, res, next) => {
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
