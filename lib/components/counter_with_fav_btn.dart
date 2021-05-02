import 'package:flutter/material.dart';
import '../detailed_product.dart';
import 'cart_counter.dart';
import 'package:rating_bar/rating_bar.dart';

class CounterWithFavBtn extends StatelessWidget {
  const CounterWithFavBtn({
    Key key,
    @required this.product,
  }) : super(key: key);

  final DetailedProduct product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CartCounter(),
        Container(
          padding: EdgeInsets.all(8),
          // height: 32,
          // width: 32,
          child: RatingBar.readOnly(
            initialRating: product.rating.toDouble(),
            filledColor: Colors.orangeAccent,
            halfFilledColor: Colors.orangeAccent,
            emptyColor: Colors.orangeAccent,
            isHalfAllowed: true,
            halfFilledIcon: Icons.star_half,
            filledIcon: Icons.star,
            emptyIcon: Icons.star_border,
          ),
          //child: SvgPicture.asset("assets/icons/heart.svg"),
        ),
      ],
    );
  }
}
