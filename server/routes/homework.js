const express = require('express');
const Homework = require('../models/homework');
const User = require('../models/user');
const Course = require('../models/course');
const auth = require('../middleware/auth');

const homeworkRouter = express.Router();

const generateRandomString = () => {
    return Math.floor(Math.random() * Date.now()).toString(36);
};

homeworkRouter.post("/homework/create", auth, async(req, res) => {
    try {
        const { courseID, nameHomework, description, dateStart, timeStart, dateEnd, timeEnd } = req.body;

        const user = await User.findById(req.user);
        if(!user || (user && user.role != "Giáo viên")) {
            return res.status(400).json({ msg: "Giáo viên không tồn tại"})
        }

        const course = await Course.findOne({ courseID: courseID })
        if(!course) {
            return res.status(400).json({ msg: "Khóa học không tồn tại"})
        }

        const now = new Date();
        let [day1, month1, year1] = dateStart.split('/')
        let [hour1, min1] = timeStart.split(':')
        const dateObjStart = new Date(+year1, +month1 - 1, +day1, hour1, min1, 0)

        let [day2, month2, year2] = dateEnd.split('/')
        let [hour2, min2] = timeEnd.split(':')
        const dateObjEnd = new Date(+year2, +month2 - 1, +day2, hour2, min2, 0)
        
        if(dateObjStart < now) {
            return res.status(400).json({ msg: "Thời gian bắt đầu không được ở quá khứ"})
        }
        
        if(dateObjEnd <= dateObjStart) {
            return res.status(400).json({ msg: "Thời gian kết thúc phải lớn hơn thời gian bắt đầu"});
        }

        const homeworkID = await generateRandomString();

        let homework = new Homework({
            courseID: courseID,
            homeworkID: homeworkID,
            nameHomework: nameHomework,
            description: description,
            start: dateObjStart,
            end: dateObjEnd
        })

        homework = await homework.save();
        res.json(homework);
    } catch(e) {
        return res.status(500).json({ error: e.message })
    }
})

module.exports = homeworkRouter;