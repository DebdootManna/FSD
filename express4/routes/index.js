var express = require('express');
var router = express.Router();
var Product = require('../models/Product');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.get('/add-product', function(req, res, next) {
  res.render('add-product', { 
    title: 'Add Product',
    heading: 'Add Product',
    editing: false,
    errorMessage: null,
    formAction: '/add-product-process',
    csrfToken: '',
    product: null
  });
});

router.post('/add-product-process', function(req, res, next) {
  var mydata = {
    title: req.body.title,
    imageUrl: req.body.imageUrl,
    price: req.body.price,
    description: req.body.description
  }
  // Assign Data to Model
  var product = new Product(mydata);
  product.save()
  .then(() => {
    res.redirect('/display-products');
  }).catch((err) => {
    res.render('add-product', {
      title: 'Add Product',
      heading: 'Add Product',
      editing: false,
      errorMessage: 'Error adding product: ' + err.message,
      formAction: '/add-product-process',
      csrfToken: '',
      product: req.body
    });
  });
});

router.get('/display-products', function(req, res, next) {
  Product.find()
  .then((products) => {
    res.render('display-products', { title: 'Product List', products: products });
  }).catch((err) => {
    res.status(500).send('Error fetching products');
  });
});

router.get('/edit-product/:id', function(req, res, next) {
  var productId = req.params.id;
  Product.findById(productId)
  .then((product) => {
    if (!product) {
      return res.status(404).send('Product not found');
    }
    res.render('add-product', {
      title: 'Edit Product',
      heading: 'Edit Product',
      editing: true,
      errorMessage: null,
      formAction: '/edit-product-process',
      csrfToken: '',
      product: product
    });
  }).catch((err) => {
    res.status(500).send('Error fetching product');
  });
});

router.post('/edit-product-process', function(req, res, next) {
  var productId = req.body.id;
  var updatedData = {
    title: req.body.title,
    imageUrl: req.body.imageUrl,
    price: req.body.price,
    description: req.body.description
  };
  Product.findByIdAndUpdate(productId, updatedData)
  .then(() => {
    res.redirect('/display-products');
  }).catch((err) => {
    res.render('add-product', {
      title: 'Edit Product',
      heading: 'Edit Product',
      editing: true,
      errorMessage: 'Error updating product: ' + err.message,
      formAction: '/edit-product-process',
      csrfToken: '',
      product: req.body
    });
  });
});

router.get('/delete-product/:id', function(req, res, next) {
  var productId = req.params.id;
  Product.findByIdAndDelete(productId)
  .then(() => {
    res.redirect('/display-products');
  }).catch((err) => {
    res.status(500).send('Error deleting product: ' + err.message);
  });
});

module.exports = router;
