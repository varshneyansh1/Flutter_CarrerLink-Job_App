const { text } = require("body-parser");
var nodemailer = require("nodemailer");

async function sendEmail(params, callback) {
  const transporter = nodemailer.createTransport({
    service: "Gmail",
    host: "smtp.gmail.com",
    port: 465,
    secure: true,
    auth: { user: "enter_your_email", pass: "enter_pass" },
  });
  var mailOptions = {
    from: "enter_your_email",
    to: params.email,
    subject: params.subject,
    text: params.body,
  };

  transporter.sendMail(mailOptions, function (error, info) {
    if (error) {
      return callback(error);
    } else {
      return callback(null, info.response);
    }
  });
}
module.exports = {
  sendEmail,
};
