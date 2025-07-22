let express = require('express');
let app = express();    
let port = 3000;

app.set('view engine', 'ejs');
app.set('views', __dirname + '/views');
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});

app.get('/', (req, res) => {
  let context = {'name': 'Debdoot Manna'};
  res.render('home', context);
});