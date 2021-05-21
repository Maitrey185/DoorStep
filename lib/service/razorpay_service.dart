import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
//import '../controller/cart_controller.dart';

class RazorpayService {
  Logger logger = Logger();
  //CartController cartController = Get.find();
  var cartBox = Hive.box('cartBox');

  pay(double amount) {
    final Razorpay _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);

    var options = {'key': 'rzp_test_HER5y9cOw04ojM', 'amount': amount};

    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    logger.i("Payment Successful");
    //cartController.clear();
    cartBox.clear();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    logger.e("Payment Failed: ${response.message}");
  }
}
