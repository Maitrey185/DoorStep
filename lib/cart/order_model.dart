import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'theme.dart';

class Orders_model extends StatelessWidget {
  final orderNumber;
  final orderDate;
  final totalQuantity;
  final totalPrice;


  Orders_model(this.orderNumber, this.orderDate, this.totalQuantity, this.totalPrice);

  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    return Container(
        padding: EdgeInsets.all(AppSizes.imageRadius),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: _theme.primaryColor.withOpacity(0.3),
                blurRadius: AppSizes.imageRadius,
              )
            ],
            borderRadius: BorderRadius.circular(AppSizes.imageRadius),
            color: AppColors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(AppSizes.sidePadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RichText(
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: 'Order: ',
                            style: _theme.textTheme.display1.copyWith(
                                color: _theme.primaryColorLight,
                                fontWeight: FontWeight.normal),
                          ),
                          TextSpan(
                            text: '#' + orderNumber.toString(),
                            style: _theme.textTheme.display1
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                        ])),
                    Text(orderDate.toString(),
                        style: _theme.textTheme.display3
                            .copyWith(color: AppColors.red))
                  ],
                ),
                SizedBox(
                  height: AppSizes.linePadding,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: AppSizes.sidePadding,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Quantity: ',
                              style: _theme.textTheme.display1
                                  .copyWith(color: _theme.primaryColorLight),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: AppSizes.linePadding),
                              child: Text(
                                totalQuantity.toString(),
                                style: _theme.textTheme.display1,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Totat Amount: ',
                              style: _theme.textTheme.display1
                                  .copyWith(color: _theme.primaryColorLight),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: AppSizes.sidePadding),
                              child: Text(
                                '\$' + totalPrice.toString(),
                                //total amount
                                style: _theme.textTheme.display1,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: AppSizes.linePadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      padding: EdgeInsets.only(
                          left: 24, right: 24, top: 10, bottom: 10),
                      color: AppColors.white,
                      // onPressed: () {
                      //   onClick(order.id);
                      // },
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(AppSizes.imageRadius),
                          side: BorderSide(color: AppColors.black, width: 2)),
                      child: Text(
                        'Details',
                        style: _theme.textTheme.display1,
                      ),
                    ),
                    Text("delivered",
                        style: _theme.textTheme.display1
                            .copyWith(color: AppColors.green)),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
