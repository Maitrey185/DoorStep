import 'package:flutter/material.dart';
import 'package:shape_cam/cart/size_config.dart';
import 'package:shape_cam/product/detailed_product.dart';
import 'product_title_with_image.dart';
import 'product_info.dart';

class Body extends StatelessWidget {
  final DetailedProduct product;

  const Body({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: size.height * 0.4),
                padding: EdgeInsets.only(
                  top: size.height * 0.12,
                  left: getProportionateScreenWidth(10.0),
                  right: getProportionateScreenWidth(10.0),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: ProductInfo(product: product),
              ),
              ProductTitleWithImage(product: product)
            ],
          )
        ],
      ),
    );
  }
}
