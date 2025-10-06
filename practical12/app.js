
const express = require('express');
const app = express();
const port = 3000;

app.set('view engine', 'ejs');
app.use(express.urlencoded({ extended: true }));

app.get('/', (req, res) => {
  res.render('index');
});

app.post('/calculate', (req, res) => {
  const { num1, num2, operation } = req.body;
  const number1 = parseFloat(num1);
  const number2 = parseFloat(num2);
  let result;

  if (isNaN(number1) || isNaN(number2)) {
    return res.render('result', { error: 'Invalid input. Please enter numbers only.' });
  }

  switch (operation) {
    case 'add':
      result = number1 + number2;
      break;
    case 'subtract':
      result = number1 - number2;
      break;
    case 'multiply':
      result = number1 * number2;
      break;
    case 'divide':
      if (number2 === 0) {
        return res.render('result', { error: 'Cannot divide by zero.' });
      }
      result = number1 / number2;
      break;
    default:
      return res.render('result', { error: 'Invalid operation.' });
  }

  res.render('result', { result });
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});
