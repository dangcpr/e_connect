const mongoose = require('mongoose');

const List_StudentSchema = mongoose.Schema({
    course: {
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
})

const List_Student = mongoose("List_Student", List_StudentSchema);
module.exports = List_Student;