import 'package:flutter/material.dart';
import 'package:shape_cam/cart/size_config.dart';

class RoundButton extends StatelessWidget {
  final Color colour;
  final Function onPressed;
  final String title;

  RoundButton({
    this.colour,
    this.title,
    @required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(16.0)),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: getProportionateScreenWidth(200.0),
          height: getProportionateScreenHeight(52.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: getProportionateScreenWidth(16.0),
            ),
          ),
        ),
      ),
    );
  }
}
