
const express = require('express');
const fs = require('fs');
const path = require('path');

const app = express();
const port = 3000;

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

app.get('/', (req, res) => {
  res.send('<h1>Welcome to the Log Viewer</h1><p><a href="/logs">View Logs</a></p>');
});

app.get('/logs', (req, res) => {
  const logFilePath = path.join(__dirname, 'logs.txt');

  fs.readFile(logFilePath, 'utf8', (err, data) => {
    if (err) {
      console.error(err);
      res.status(500).render('logs', { error: 'Error reading log file.' });
      return;
    }
    res.render('logs', { logs: data });
  });
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});
