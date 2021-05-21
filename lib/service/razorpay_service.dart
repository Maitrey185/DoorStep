import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../main_shopping_page.dart';

class RazorpayService {
  Logger logger = Logger();
  var cartBox = Hive.box('cartBox');

  pay(double amount) {
    final Razorpay _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);

    var options = {'key': 'rzp_test_HER5y9cOw04ojM', 'amount': amount};

    _razorpay.open(options);
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    logger.i("Payment Successful");
    //cartController.clear();
    cartBox.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("id");
    var token = prefs.getString("token");
    Get.to(MainShop(id, token));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    logger.e("Payment Failed: ${response.message}");
  }
}
