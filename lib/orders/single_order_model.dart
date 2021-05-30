import 'package:flutter/material.dart';
import 'theme.dart';
import 'package:get/get.dart';
import 'package:shape_cam/cart/size_config.dart';
import 'order_details.dart';
class ItemModel extends StatelessWidget {
  final name;
  final quantity;
  final price;
  final image;

  ItemModel(
      this.name, this.quantity, this.price, this.image);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var _theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;
    return Padding(
        padding: EdgeInsets.only(bottom: AppSizes.sidePadding),
        child: Container(
            padding: EdgeInsets.symmetric(vertical: AppSizes.linePadding * 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.imageRadius),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.lightGray.withOpacity(0.3),
                      blurRadius: AppSizes.imageRadius,
                      offset: Offset(0.0, AppSizes.imageRadius))
                ],
                color: AppColors.white),
            child: Stack(children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                      width: 104,
                      child: Image.asset(image)),
                  Container(
                      padding: EdgeInsets.only(left: AppSizes.sidePadding),
                      width: width - 134,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: width - 173,
                                    child: Text(name,
                                        style: _theme.textTheme.display1
                                            .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: _theme.primaryColor)),
                                  ),
                                ]),
                            Padding(
                                padding: EdgeInsets.only(
                                    bottom: AppSizes.linePadding * 2)),

                            Row(children: <Widget>[

                              Container(
                                  alignment: Alignment.center,

                                  width: 110,
                                  child: Row(children: <Widget>[
                                    Text('Units: ',
                                        style: _theme.textTheme.body1),
                                    Text(quantity.toString(),
                                        style: _theme.textTheme.body1
                                            .copyWith(
                                            color:
                                            _theme.primaryColor)),
                                  ])),
                              Container(
                                width: width - 280,
                                alignment: Alignment.centerRight,
                                child: Text(
                                    '\$' +
                                        (price).toString(),
                                    style: _theme.textTheme.display1),
                              )
                            ])
                          ]))
                ],
              ),

            ])));
  }
}
