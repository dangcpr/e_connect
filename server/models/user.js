const mongoose = require('mongoose');

const userSchema = mongoose.Schema({
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re =
                /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
              return value.match(re);
            },
            message: "Please enter a valid email address"
        }
    },
    password: {
        type: String,
    },
    method: {
        required: true,
        type: String,
    },
    role: {
        required: true,
        type: String,
        trim: true
    },
    verified: {
        required: true,
        type: Boolean,
        default: 0
    },
    avatar: {
        type: String
    },
    lastLogin: {
        type: Date,
    }
})

const User = mongoose.model("User", userSchema);
module.exports = User;