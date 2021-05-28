const mongoose = require('mongoose');

var date = getDate();

const orderSchema = mongoose.Schema({
    _id: mongoose.Schema.Types.ObjectId,
    userId: mongoose.Schema.Types.ObjectId,
    cart: Array,
    dateOrdered: {type: String, default: date},
    deliveryAddress: { type: String, required: true },
    paymentmethod: { type: String, required: true },
    cartTotal: { type: Number, required: true}
});


function getDate(){
  let date_ob = new Date();
  let date = ("0" + date_ob.getDate()).slice(-2);
  let month = ("0" + (date_ob.getMonth() + 1)).slice(-2);
  let year = date_ob.getFullYear();
  let hours = date_ob.getHours();
  let minutes = date_ob.getMinutes();
  date = year + "-" + month + "-" + date + " " + hours + ":" + minutes ;
  return date;
}


module.exports = mongoose.model('Order', orderSchema);