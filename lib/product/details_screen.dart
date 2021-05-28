import 'package:flutter/material.dart';
import 'package:shape_cam/cart/size_config.dart';
import 'package:shape_cam/product/detailed_product.dart';
import '../components/details_body.dart';
import 'package:get/get.dart';
import 'package:shape_cam/cart/cart_screen.dart';

class DetailsScreen extends StatelessWidget {
  final DetailedProduct product;

  const DetailsScreen({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Color(0xFFFF7675),
      appBar: buildAppBar(context),
      body: Body(product: product),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFFF7675),
      elevation: 0,
      leading: TextButton(
        child: Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: 40.0,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        FlatButton(
          child: Icon(
            Icons.shopping_cart,
            size: 30.0,
          ),
          onPressed: () {
            Get.to(CartScreen());
          },
        ),
        SizedBox(width: getProportionateScreenWidth(5.0))
      ],
    );
  }
}
