import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shape_cam/cart/cartItem.dart';
import 'package:shape_cam/main_shopping_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';

class RazorpayService {
  Logger logger = Logger();
  var cartBox = Hive.box('cartBox');
  double totalAmt = 0.0;
  List<Map> ls = [];

  pay(double amount) {
    totalAmt = amount;
    final Razorpay _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);

    var options = {'key': 'rzp_test_7HLvjnxBauxwCo', 'amount': amount};

    _razorpay.open(options);
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    logger.i("Payment Successful");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("id");
    var token = prefs.getString("token");

    // getAllCartProducts();

    // http.Response res = await http.post(
    //   "${FlutterConfig.get('SERVER_URL')}orders",
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //     'Accept': 'application/json',
    //     'Authorization': 'Bearer $token'
    //   },
    //   body: jsonEncode({
    //     'userId': id,
    //     'cart': ls,
    //     'deliveryAddress' : ,
    //     'paymentmethod': ,
    //     'cartTotal': totalAmt
    //   }),
    // );
    // print(res.statusCode);

    cartBox.clear();
    Get.to(MainShop(id, token));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    logger.e("Payment Failed: ${response.message}");
  }

  // void getAllCartProducts() {
  //   for (int i = 0; i < cartBox.length; i++) {
  //     var cartItem = cartBox.getAt(i) as CartItem;
  //     ls.add({
  //       "_id": cartItem.product.id,
  //       "name": cartItem.product.model,
  //       "price": cartItem.product.price,
  //       "productImage": cartItem.product.productImage,
  //       "quantity": cartItem.itemCount
  //     });
  //   }
  // }
}
