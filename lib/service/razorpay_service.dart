import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shape_cam/main_shopping_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';
import 'package:shape_cam/cart/cartItem.dart';

class RazorpayService {
  Logger logger = Logger();
  double totalAmt = 0.0;
  List<Map> ls = [];
  String address = "";
  String email = "";
  String number = "";
  String id = "";
  String token = "";
  String paymentMethod = "";

  pay(double amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id");
    token = prefs.getString("token");

    await getUserDetails(id: id, token: token);

    totalAmt = amount;
    final Razorpay _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);

    var options = {
      'key': FlutterConfig.get('KEY_ID'),
      'amount': amount,
      'prefill': {'contact': number, 'email': email},
      'theme': {
        'color': '#C0392B',
      }
    };

    _razorpay.open(options);
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    logger.i("Payment Successful");
    print("Payment ID: ${response.paymentId}");

    getAllCartProducts();

    http.Response r = await http.get(
        "https://${FlutterConfig.get('KEY_ID')}:${FlutterConfig.get('KEY_SECRET')}@api.razorpay.com/v1/payments/${response.paymentId}");
    if (r.statusCode == 200) {
      var data = jsonDecode(r.body);
      paymentMethod = data['method'];
    }

    http.Response res = await http.post(
      "${FlutterConfig.get('SERVER_URL')}orders",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({
        'userId': id,
        'cart': ls,
        'deliveryAddress': address,
        'paymentmethod': paymentMethod,
        'cartTotal': totalAmt / 100
      }),
    );
    print(res.statusCode);
    Get.to(MainShop(id, token));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    logger.e("Payment Failed: ${response.message}");
  }

  Future<void> getUserDetails({String id, String token}) async {
    http.Response response =
        await http.get(FlutterConfig.get('SERVER_URL') + 'user/$id', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      address = data['user']['deliveryAddress'][0];
      number = data['user']['contactNo'].toString();
      email = data['user']['email'];
    } else {
      print("${response.statusCode} ${response.body}");
    }
  }

  void getAllCartProducts() {
    var cartBox = Hive.box('cartBox$id');

    for (int i = 0; i < cartBox.length; i++) {
      var cartItem = cartBox.getAt(i) as CartItem;
      ls.add({
        "_id": cartItem.product.id,
        "name": cartItem.product.model,
        "price": cartItem.product.price,
        "productImage": cartItem.product.productImage,
        "quantity": cartItem.itemCount
      });
    }
    cartBox.clear();
  }
}
