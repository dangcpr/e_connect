const nodemailer = require('nodemailer');

const sendEmailOTP = (email, otp) => {
    var transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
            user: 'sukien.chuvanancpr@gmail.com',
            pass: 'jublhxishmwexkrx'
        },
        tls: {
            rejectUnauthorized: false
        }
    });

    var mailOptions = {
        from: 'sukien.chuvanancpr@gmail.com',
        to: email,
        subject: 'Mã xác thực E-Connect',
        text: 'Mã xác thực của bạn là ' +  otp + '. Mã có hiệu lực trong vòng 5 phút, vui lòng không chia sẻ mã này cho bất kì ai.'
    };

    transporter.sendMail(mailOptions, function(error, info){
        if (error) {
            console.log(error);
        } else {
            console.log('Email sent: ' + info.response);
        }
    }); 
}

module.exports = sendEmailOTP;