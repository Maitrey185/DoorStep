const mongoose = require('mongoose');

const userSchema = mongoose.Schema({
    _id: mongoose.Schema.Types.ObjectId,
    email: {
        type: String,
        required: true,
        unique: true,
        match: /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/
    },
    password: { type: String, required: true },
    name: { type: String },
    gender: { type: String },
    deliveryAddress: { type: Array, default: [] },
    contactNo: { type: Number, default: 123 },
    isAdmin: { type: Boolean, default: false },
    profilePicture: { type: String, default: "" },
    coupons: Array
});

module.exports = mongoose.model('User', userSchema);
