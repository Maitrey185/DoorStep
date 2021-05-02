const mongoose = require('mongoose');

const orderSchema = mongoose.Schema({
    _id: mongoose.Schema.Types.ObjectId,
    userId: mongoose.Schema.Types.ObjectId,
    //product: { type: mongoose.Schema.Types.ObjectId, ref: 'Product', required: true },
    //quantity: { type: Number, default: 1 },
    cart: Array,
    dateOrdered: Date,
    expectedDelivery: Date,
    dateDelivered: Date,
    customer: { type: Map, of: String},
    deliveryAddress: { type: Array, default: [] },
    status: { type: String, required: true },
    paymentmethod: { type: String, required: true },
    shippingCharges: { type: Number, required: true},
    tax: { type: Number, required: true},
    cartTotal: { type: Number, required: true}
});


module.exports = mongoose.model('Order', orderSchema);
