const express = require('express');
const router = express.Router();
const multer = require('multer');

const checkAuth = require('../middleware/check-auth');

const UserController = require('../controllers/user');

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'uploads/profile_pictures');
    },
    filename: function (req, file, cb) {
        cb(null, Date.now() + file.originalname);
    }
});

const upload = multer({
    storage: storage,
    limits: {
        fileSize: 1024 * 1024 * 5
    }
    // fileFilter: fileFilter
});

router.post('/signup', upload.single('profilePicture'), UserController.signUp);

router.post('/login', UserController.logIn);

router.get('/:userId', checkAuth, UserController.getOneUser);

router.patch('/:userId', checkAuth, UserController.editUser);

router.delete('/:userId', checkAuth, UserController.deleteUser);

module.exports = router;
