var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index');
});

/* POST calculate */
router.post('/calculate', function(req, res, next) {
  const { income1, income2 } = req.body;
  const num1 = parseFloat(income1);
  const num2 = parseFloat(income2);

  if (isNaN(num1) || isNaN(num2)) {
    res.render('index', {
      error: 'Please enter valid numbers for both income sources.',
      income1: income1,
      income2: income2
    });
  } else {
    const total = num1 + num2;
    res.render('index', {
      total: total.toFixed(2),
      income1: income1,
      income2: income2
    });
  }
});

module.exports = router;
