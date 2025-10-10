
const express = require('express');
const router = express.Router();
const Student = require('../models/student');

// Home page - list students and show add form
router.get('/', async (req, res) => {
  const students = await Student.find();
  res.render('index', { students });
});

// Add student
router.post('/add', async (req, res) => {
  const { name, age, grade } = req.body;
  const newStudent = new Student({ name, age, grade });
  await newStudent.save();
  res.redirect('/');
});

// Show edit form
router.get('/edit/:id', async (req, res) => {
  const student = await Student.findById(req.params.id);
  res.render('edit', { student });
});

// Update student
router.post('/update/:id', async (req, res) => {
  const { name, age, grade } = req.body;
  await Student.findByIdAndUpdate(req.params.id, { name, age, grade });
  res.redirect('/');
});

// Delete student
router.get('/delete/:id', async (req, res) => {
  await Student.findByIdAndDelete(req.params.id);
  res.redirect('/');
});

module.exports = router;
