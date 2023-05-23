const express = require('express');
const User = require("../models/user");
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken')
const auth = require('../middleware/auth');
const Course = require('../models/course');

const courseRouter = express.Router();

const generateRandomString = () => {
    return Math.floor(Math.random() * Date.now()).toString(36);
};
const hello = async () =>  {
    const acc = await Course.find({});
    console.log(acc);
}

hello();

courseRouter.post("/course/create", auth, async(req, res) => {
    try {   
        const { nameCourse, dateStart, dateEnd, pass, limit } = req.body;

        const user = await User.findById(req.user);

        if(!user || (user && user.role != "Giáo viên")) {
            return res.status(400).json({msg: "Teacher does not exist!"})
        }

        const hased_Password = await bcryptjs.hash(pass, 8);

        var courseID = generateRandomString();

        let [day1, month1, year1] = dateStart.split('/')
        const now = new Date();
        console.log(now)
        
        const dateObjStart = new Date(+year1, +month1 - 1, +day1, 0, 0, 0)

        let [day2, month2, year2] = dateEnd.split('/')
        const dateObjEnd = new Date(+year2, +month2 - 1, +day2, 23, 59, 59,999)

        if(dateObjEnd < dateObjStart) {
            return res.status(400).json({ msg: "Ngày kết thúc khóa học phải lớn hơn ngày bắt đầu"});
        }

        let course = new Course({
            teacher: user.email, 
            courseID: courseID, 
            nameCourse: nameCourse, 
            dateStart: dateObjStart, 
            dateEnd: dateObjEnd, 
            pass: hased_Password, 
            limit: limit
        })

        course = await course.save();
        console.log(course);
        res.json(course);

        // const timeCourse = await Course.findOne({courseID: courseID});
        // const time = new Date(timeCourse.dateStart);
        // console.log(time.getDate());
    } catch (e) {
        res.status(500).json({ error: e.message })
    } 
});

courseRouter.get("/course/teacher/get", auth, async (req, res) => {
    const user = await User.findById(req.user)

    if(!user || (user && user.role != "Giáo viên")) {
        return res.status(400).json({ msg: "Teacher does not exist!"})
    }

    const course = await Course.find({ teacher: user.email });
    res.json(course);
}) 

module.exports = courseRouter;