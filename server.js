var http = require('http');
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/html'});
  res.write("<br><h1>Welcome to My Server</h1>");
  res.end('<h1>Hello World</h1><p>This is a simple HTTP server.</p>');
}).listen(8080);
console.log('Server running at http://127.0.0.1:8080/');