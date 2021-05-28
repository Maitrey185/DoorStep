const mongoose = require('mongoose');
const Order = require('../models/order');
const Product = require('../models/product');

exports.getAllOrders = (req, res, next) => {
    Order
        .find()
        .select('_id userId cart dateOrdered paymentmethod deliveryAddress cartTotal')
        .exec()
        .then(orders => {
            res.status(200).json({
                count: orders.length,
                orders: orders
            });
        })
        .catch(error => {
            next(error);
        })
};

exports.createOneOrder = (req, res, next) => {

    console.log("Creating Order...")
    return new Order({
        _id: mongoose.Types.ObjectId(),
        userId: req.body.userId,
        cart: req.body.cart,
        deliveryAddress: req.body.deliveryAddress,
        paymentmethod: req.body.paymentmethod,
        cartTotal: req.body.cartTotal
    })
    .save()
    .then(result => {
        res.status(200).json({
            order: result
        });
    })
    .catch(err => {
        res.status(500).json({
            error: err
        });
    });
    // Product
    //     .findById(req.body.productId)
    //     .exec()
    //     .then(product => {
    //         if (!product) {
    //             return res.status(404).json({
    //                 message: 'Product Not Found!'
    //             });
    //         }
    //         return createOrder(req);
    //     })
    //     .then(order => {
    //         return order.save();
    //     })
    //     .then(order => {
    //         return res.status(201).json({
    //             message: 'Order was created',
    //             order: {
    //                 _id: order._id,
    //                 product: order.product,
    //                 quantity: order.quantity
    //             }
    //         });
    //     })
    //     .catch(error => {
    //         next(error);
    //     });
};

exports.getOneOrder = (req, res, next) => {
    const orderId = req.params.orderId;
    Order
        .findById(orderId)
        .select('_id userId cart dateOrdered paymentmethod deliveryAddress cartTotal')
        .exec()
        .then(order => {
            return res.status(201).json(order);
        })
        .catch(error => {
            next(error);
        });
};

exports.getOrderByUserId = (req, res, next) => {
    const userId = req.params.userId;
    Order
        .find({userId: userId})
        .select('_id userId cart dateOrdered paymentmethod deliveryAddress cartTotal')
        .exec()
        .then(order => {
            return res.status(201).json({
              count: order.length,
              orders: order
            });
        })
        .catch(error => {
            next(error);
        });
};


exports.updateOneOrder = (req, res, next) => {
    const orderId = req.params.orderId;
    Order
        .update({ _id: orderId }, { $set: req.body })
        .exec()
        .then(result => {
            return res.status(200).json({
                message: 'Updated Order Successfully!',
                result: result
            });
        })
        .catch(error => {
            next(error);
        });
};

exports.deleteOneOrder = (req, res, next) => {
    const orderId = req.params.orderId;
    Order
        .remove({ _id: orderId })
        .exec()
        .then(result => {
            return res.status(200).json({
                message: 'Deleted order!',
                result: result
            });
        })
        .catch(error => {
            next(error);
        });
};

function createOrder(req) {
    return new Order({
        _id: mongoose.Types.ObjectId(),
        product: req.body.productId,
        customer: req.body.customer,
        quantity: req.body.quantity,
        deliveryAddress: req.body.deliveryAddress,
        status: req.body.status,
        paymentmethod: req.body.paymentmethod,
        shippingCharges: req.body.shippingCharges,
        tax: req.body.tax,
        cartTotal: req.body.cartTotal
    });
}