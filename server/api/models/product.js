const mongoose = require('mongoose');

var date = getDate();
const productSchema = mongoose.Schema({

    _id: mongoose.Schema.Types.ObjectId,
    model: { type: String, required: true },
    price: { type: Number, required: true },
    productImage: { type: String, required: true },
    avgRating: {type: Number, default: 0 },
    reviews: {type: Array},
    date: {type: String, default: date},
    category: { type: String, required: true },

});

function getDate(){
  let date_ob = new Date();
  let date = ("0" + date_ob.getDate()).slice(-2);
  let month = ("0" + (date_ob.getMonth() + 1)).slice(-2);
  let year = date_ob.getFullYear();
  let hours = date_ob.getHours();
  let minutes = date_ob.getMinutes();
  date= year + "-" + month + "-" + date + " " + hours + ":" + minutes ;
  return date;
}

module.exports = mongoose.model('Product', productSchema);
