const mongoose = require('mongoose');

const courseSchema = mongoose.Schema({
    teacher: {
        required: true,
        type: String,
    },
    courseID: {
        require: true,
        type: String,
    },
    nameCourse: {
        required: true,
        type: String,
    },
    dateStart: {
        required: true,
        type: Date
    },
    dateEnd: {
        required: true,
        type: Date,
    },
    pass: {
        type: String,
    },
    limit: {
        type: Number,
        require: true
    },
    registered: {
        type: Number,
        require: true,
        default: 0
    }
})

const Course = mongoose.model("Course", courseSchema);
module.exports = Course;