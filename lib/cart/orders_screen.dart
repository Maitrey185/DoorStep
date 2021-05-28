import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../main_shopping_page.dart';
import 'cartItem.dart';
import 'cart_card.dart';
import 'size_config.dart';
import 'check_out_card.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shape_cam/cart/cartItem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'All_orders.dart';

class OrdersScreen extends StatefulWidget {

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // var id;
  // var token;
  var ls =[];
  var uuid = Uuid();
 @override
  void initState() {

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(child: AllOrders()),
            ],

          )

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
        "Your Cart",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
