const mongoose = require('mongoose');

const homeworkSchema = mongoose.Schema({
    courseID: {
        require: true,
        type: String
    },
    homeworkID: {
        require: true,
        type: String
    },
    nameHomework: {
        require: true,
        type: String
    },
    description: {
        require: true,
        type: String,
    },
    createAt: {
        require: true,
        type: Date,
        default: new Date(),
    },
    start: {
        require: true,
        type: Date
    },
    end: {
        require: true,
        type: Date
    },
    submitted: {
        type: Number,
        require: true,
        default: 0
    },
    active: {
        type: Boolean,
        require: true,
        default: true
    }
})

const Homework = mongoose.model("Homework", homeworkSchema);
module.exports = Homework;