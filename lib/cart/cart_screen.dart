import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'size_config.dart';
import 'body.dart';
import 'check_out_card.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int cartLength = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var cartBox = Hive.box('cartBox');
    cartLength = cartBox.length;
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.orangeAccent,
      leading: TextButton(
        child: Icon(
          Icons.chevron_left,
          size: 40.0,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Your Cart",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
