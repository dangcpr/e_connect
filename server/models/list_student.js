const mongoose = require('mongoose');

const List_StudentSchema = mongoose.Schema({
    courseID: {
        required: true,
        type: String,
    },
    student: {
        required: true,
        type: String,
    },
    dateJoin: {
        required: true,
        type: Date,
        default: mongoose.now
    },
    score: {
        type: Number
    }
})

const List_Student = mongoose.model("List_Student", List_StudentSchema);
module.exports = List_Student;