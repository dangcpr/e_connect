const express = require('express');
const mongoose = require('mongoose');

const http = require('http').createServer(express);
const io = require('socket.io')(http);

const authRouter = require('./routes/auth');
const courseRouter = require('./routes/course');
const PORT = 3000;
const app = express();
const DB = 'mongodb+srv://dangcpr:s8Uz0ibzs31WnSJr@cluster0.ifpa25l.mongodb.net/?retryWrites=true&w=majority';

// app.get('/hello-world', (req, res) => {
//     res.json({name: "Hải Đăng"});
// })

//Middleware
app.use(express.json());
app.use(authRouter);
app.use(courseRouter);

mongoose.connect(DB).then(() => {
    console.log("Connection Sucessseful");
}).catch((e) => {
    console.log(e);
})

app.listen(PORT, "0.0.0.0", () => {
    console.log('connected at port ' + PORT + " hello world");
    //console.log("IP's Client" + getClientIP);
})