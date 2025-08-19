const mongoose = require('mongoose');
var ProductSchema = new mongoose.Schema({
  title: String,
  imageUrl: String,
  price: Number,
  description: String
});
var Product = mongoose.model('Product', ProductSchema);

module.exports = Product;
