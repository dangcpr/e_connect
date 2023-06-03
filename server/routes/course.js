const express = require('express');
const User = require("../models/user");
const bcryptjs = require('bcryptjs');
const auth = require('../middleware/auth');
const Course = require('../models/course');
const List_Student = require('../models/list_student');

const courseRouter = express.Router();

const generateRandomString = () => {
    return Math.floor(Math.random() * Date.now()).toString(36);
};

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
        
        const dateObjStart = new Date(+year1, +month1 - 1, +day1, 0, 0, 0)

        let [day2, month2, year2] = dateEnd.split('/')
        const dateObjEnd = new Date(+year2, +month2 - 1, +day2, 23, 59, 59,999)
        if(now.getFullYear() != dateObjStart.getFullYear() 
            || now.getMonth() != dateObjStart.getMonth()  
            || now.getDate() != dateObjStart.getDate()) {
                if(dateObjStart < now) {
                    return res.status(400).json({ msg: "Ngày bắt đầu khóa học không được ở quá khứ"})
                }
        }
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

    } catch (e) {
        res.status(500).json({ error: e.message })
    } 
});

courseRouter.get("/course/teacher/get", auth, async (req, res) => {
    const user = await User.findById(req.user);
    if(!user || (user && user.role != "Giáo viên")) {
        return res.status(400).json({ msg: "Teacher does not exist!"})
    }

    const course = await Course.find({ teacher: user.email });
    res.json(course);
})

courseRouter.post("/course/student/join", auth, async (req, res) => {
    try {
        const { courseID, pass } = req.body;
        const user = await User.findById(req.user);
        if (!user || (user && user.role != "Học sinh")) {
            return res.status(400).json({ msg: "Học sinh không tồn tại"});
        }

        const course = await Course.findOne( {courseID : courseID});
        if (!course) {
            return res.status(400).json({ msg: "Khóa học không tồn tại"});
        }

        const isMatch = await bcryptjs.compare(pass, course.pass);
        if (!isMatch) {
            return res.status(400).json({ msg: "Mật khẩu khóa học không đúng"})
        }

        const now = new Date()
        if(now < course.dateStart) {
            return res.status(400).json( { msg: "Khóa học chưa đến thời gian bắt đầu"})
        }
        if(now > course.dateEnd) {
            return res.status(400).json( { msg: "Khóa học đã kết thúc"})
        }

        // Nếu số lượng đã đăng ký lớn hơn hoặc bằng sỉ số thì không được phép đăng ký
        // Nếu limit = 0 tức là lớp học không giới hạn số học sinh
        if(course.limit != 0 && course.registered >= course.limit) {
            return res.status(400).json( { msg: "Khóa học đã đủ số lượng học sinh"})
        }

        const student_course = await List_Student.findOne({ courseID: courseID });
        if(student_course) {
            return res.status(400).json({ msg: "Bạn đã tham gia khóa học này"})
        }

        let list_student = new List_Student({
            courseID: courseID,
            student: user.email,
            dateJoin: new Date(),
        })

        list_student = await list_student.save();

        await Course.findOneAndUpdate({ courseID: courseID }, { $inc: { registered: 1}})
        res.json(list_student)
    } catch (e) {
        res.status(500).json({ error: e.message })
    }
})

courseRouter.get("/course/student/get", auth, async(req, res) => {
    try {
        const user = await User.findById(req.user);
        if (!user || (user && user.role != "Học sinh")) {
            return res.status(400).json({ msg: "Student does not exists "})
        }

        const student_course = await List_Student.find({ student: user.email });
        let student_course_detail = [];
        for (var i = 0, l = student_course.length; i < l; i++) {
            let course_detail = await Course.findOne({ courseID: student_course[i].courseID })
            student_course_detail.push({ student: student_course[i].student, dateJoin: student_course[i].dateJoin, ...course_detail._doc})
        }

        res.json(student_course_detail)
        
    } catch (e) {
        return res.status(500).json({ error: e.message })
    }
})

module.exports = courseRouter;