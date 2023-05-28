const express = require('express');
const User = require("../models/user");
const OTP_Verified = require("../models/otp_verified");
const sendEmailOTP = require("../routes/mail_verified");
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken')
const auth = require('../middleware/auth');


const authRouter = express.Router();


const generateOTP = () => {
          
    // Declare a digits variable 
    // which stores all digits
    var digits = '0123456789';
    let OTP = '';
    for (let i = 0; i < 4; i++ ) {
        OTP += digits[Math.floor(Math.random() * 10)];
    }
    return OTP;
}

authRouter.post("/api/signup", async (req, res) => {
    try {
        const { email, password, role } = req.body;

        const existingEmail = await User.findOne({ email });
        if (existingEmail) {
            return res.status(400).json({msg: "Email alreday exists! Try agian!"})
        }

        const  hasedPassword = await bcryptjs.hash(password, 5);

        let user = new User({
            email, password: hasedPassword, role
        });

        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message })
    }
})

authRouter.post("/api/signin", async (req, res) => { //Luôn luôn phải có dấu / ở đầu địa chỉ api
    try {
        const {email, password} = req.body;

        var user = await User.findOne({ email: email });
        if(!user) {
            return res.status(400).json({msg: "User with this email does not exist!"})
        }

        const isMatch = await bcryptjs.compare(password, user.password);

        if(!isMatch) {
            return res.status(400).json({msg: "Incorrect password."})
        }

        const lastLogin = new Date();
        await User.findOneAndUpdate({ email: email }, {lastLogin: lastLogin});

        if (user.verified) {
            const token = jwt.sign({ id: user._id }, "t5K9wFYVDcnLaxQp3qbx4PYt"); //Sử dụng id user để xác thực
            return res.json({ ...user._doc, token: token });
        }
        else {
            return res.json({ ...user._doc, token: ''});
        }

    } catch (e) {
        res.status(500).json({error: e.message});
    }
})

authRouter.post("/tokenIsValid", async(req, res) => {
    try {
        const token = req.header("x-auth-token");
        if(!token) return res.json({ status: false });
        const verified = jwt.verify(token, "t5K9wFYVDcnLaxQp3qbx4PYt");
        if(!verified) return res.json({ status: false });
        
        const user = await User.findById(verified.id);
        if(!user) return res.json({ status: false }) ;
        res.json({ status: true });
    } catch (e) {
        res.status(500).json({error: e.message});
    }
})

authRouter.post("/sendOTPVerified", async(req, res) => {
    try {
        const { email } = req.body;

        const user = await OTP_Verified.findOne({ email: email});

        const user_F = await User.findOne({ email: email })

        if(user_F.verified === true) {
            return res.status(400).json({ msg: 'Email này đã được xác thực'});
        }

        const now = new Date();

        if (user &&  now - user.createAt < 5*60000) {
            return res.status(400).json({ msg: 'Vui lòng đợi 5 phút sau lần gửi mã gần nhất'});
        }

        const OTP = generateOTP();
        const hashOTP = await bcryptjs.hash(OTP, 5);

        const user_OTP = await OTP_Verified.findOneAndUpdate({ email: email }, { otp: hashOTP, createAt: now}, { upsert : true, returnOriginal: false } )
        await sendEmailOTP(email, OTP);
        res.json(user_OTP);

    } catch(e) {
        return res.status(500).json({error: e.message});
    }
})

authRouter.post("/api/verified", async (req,res) => {
    try {
        const { email, otp } = req.body;

        const user = await OTP_Verified.findOne({ email: email });
        const user_1 =  await User.findOne({ email: email });
        if (user_1.verified === true) {
            return res.status(400).json({ msg: 'Email này đã được xác thực'});
        }
        //const now = new Date();
        const isMatch = await bcryptjs.compare(otp, user.otp);

        if (user) {
            if (!isMatch)
                return res.status(400).json({ msg: 'Mã xác thực không đúng'});
            const now = new Date();
            if (now - user.createAt > 5*60000)
                return res.status(400).json({ msg: 'Mã xác thực đã hết hạn. Vui lòng nhấn "Gửi lại mã"'});
        } else {
            return res.status(400).json({ msg: 'Email không tồn tại'});
        }


        const updateUser = await User.findOneAndUpdate({ email: email }, { verified: true}, { upsert : true, returnOriginal: false } )
        await OTP_Verified.deleteOne({ email: email});
        res.json(updateUser);

    } catch(e) {
        return res.status(500).json({error: e.message});
    }   
})

authRouter.get("/", auth , async(req, res) => {
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token})
})
module.exports = authRouter;