import 'package:flutter/material.dart';
import 'default_button.dart';
import 'size_config.dart';
import '../service/razorpay_service.dart';

class CheckoutCard extends StatelessWidget {
  CheckoutCard({this.total});
  final double total;

  @override
  Widget build(BuildContext context) {
    RazorpayService _razorpayService = new RazorpayService();

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: "₹${total.toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Check Out",
                    press: () {
                      _razorpayService.pay(total.floorToDouble() * 100);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
