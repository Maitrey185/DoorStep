import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'cartItem.dart';
import 'constants.dart';
import 'size_config.dart';

class CartCard extends StatelessWidget {
  const CartCard({this.cart});

  final CartItem cart;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(4)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(
                FlutterConfig.get('SERVER_URL') + cart.product.productImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.product.model,
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "₹${cart.product.price}",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Color(0xFFC0392B)),
                children: [
                  TextSpan(
                      text: " x${cart.itemCount}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
