import 'package:flutter/material.dart';
import '../cart/size_config.dart';
import 'order_controller.dart';
import 'package:shape_cam/cart/size_config.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(20.0),
            horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: AllOrders(),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFFF7675),
      leading: TextButton(
        child: Icon(
          Icons.chevron_left,
          size: 40.0,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Your Orders",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
