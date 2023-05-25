const mongoose = require('mongoose');

const otp_verifiedSchema = mongoose.Schema({
    email: {
        require: true,
        type: String,
    },
    otp: {
        require: true,
        type: String,
    },
    createAt: {
        require: true,
        type: Date
    }
})

const otp_verified = mongoose.model("OTP_Verified", otp_verifiedSchema);
module.exports = otp_verified;