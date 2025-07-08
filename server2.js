var http = require('http')
http.createServer((req, res) => {
    if (req.url == '/') {
        res.end('<h1>Welcome to My Server</h1>');
    } else if (req.url == '/about') {
        res.end('<h1>About Us</h1><p>This is the about page.</p>');
    } else if (req.url == '/contact') {
        res.end('<h1>Contact Us</h1><p>This is the contact page.</p>');
    } else {
        res.writeHead(404, { 'Content-Type': 'text/html' });
        res.end('<h1>404 Not Found</h1><p>The page you are looking for does not exist.</p>');
    }
}).listen(8080);
console.log('Server running at http://127.0.0.1:8080/');