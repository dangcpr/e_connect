const express = require('express');
const User = require("../models/user");
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken')
const auth = require('../middleware/auth');

const authRouter = express.Router();

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

authRouter.get("/", auth , async(req, res) => {
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token})
})
module.exports = authRouter;