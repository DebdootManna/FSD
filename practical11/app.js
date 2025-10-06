const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('<h1>Welcome to the Project Template</h1><p><a href="/home">Go to Home</a></p>');
});

app.get('/home', (req, res) => {
  res.send('<h1>Welcome to the Home Page!</h1>');
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});
