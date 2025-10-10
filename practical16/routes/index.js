const express = require('express');
const router = express.Router();
const nodemailer = require('nodemailer');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

/* POST send email */
router.post('/send', async (req, res, next) => {
  const { name, email, message } = req.body;

  // Basic validation
  if (!name || !email || !message) {
    return res.render('index', { message: 'All fields are required.', error: true });
  }

  try {
    // Create a test account for Ethereal
    let testAccount = await nodemailer.createTestAccount();

    // Create a transporter
    let transporter = nodemailer.createTransport({
      host: 'smtp.ethereal.email',
      port: 587,
      secure: false, // true for 465, false for other ports
      auth: {
        user: testAccount.user, // generated ethereal user
        pass: testAccount.pass, // generated ethereal password
      },
    });

    // Email options
    let mailOptions = {
      from: `"${name}" <${email}>`,
      to: 'your-email@example.com', // The recipient email address
      subject: 'New Contact Form Submission',
      text: message,
      html: `<p>You have a new contact request</p><h3>Contact Details</h3><ul><li>Name: ${name}</li><li>Email: ${email}</li></ul><h3>Message</h3><p>${message}</p>`
    };

    // Send email
    let info = await transporter.sendMail(mailOptions);

    res.render('index', {
      message: 'Message sent successfully!',
      error: false,
      previewLink: nodemailer.getTestMessageUrl(info)
    });

  } catch (error) {
    console.log(error);
    res.render('index', { message: 'Failed to send message. Please try again later.', error: true });
  }
});

module.exports = router;
