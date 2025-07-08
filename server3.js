var http = require('http');
var fs = require('fs');

http.createServer((req, res) => {
    fs.readFile('signup.html', "utf-8", (err, data) => {
        console.log("File read successfully");
        res.end(data);
    });
}).listen(8080);
console.log('Server running at http://127.0.0.1:8080/');