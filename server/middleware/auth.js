const jwt = require('jsonwebtoken');

const auth = async (req, res, next) => {
    try {
        const token = req.header('x-auth-token');


        if(!token) {
            return res.staus(401).json({ msg: 'Không thể xác thực, vui lòng đăng xuất và đăng nhập lại'})
        }
        
        const verified = await jwt.verify(token, "t5K9wFYVDcnLaxQp3qbx4PYt");

        if(!verified) {
            return res.status(401).json({ msg: 'Lỗi xác thực, vui lòng đăng xuất và đăng nhập lại'})
        }

        req.user = verified.id // tạo thêm 1 value "User" để lưu "id" của người dùng.
        req.token = token // tạo value "token" để lưu "token" của người dùng
        next();
    } catch(e) {
        return res.status(500).json({ msg: e.message });
    }
}

module.exports = auth;