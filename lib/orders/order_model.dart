import 'package:flutter/material.dart';
import 'theme.dart';
import 'package:shape_cam/cart/size_config.dart';
class OrdersModel extends StatelessWidget {
  final orderNumber;
  final orderDate;
  final totalQuantity;
  final totalPrice;

  OrdersModel(
      this.orderNumber, this.orderDate, this.totalQuantity, this.totalPrice);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var _theme = Theme.of(context);
    return Container(
        padding: EdgeInsets.all(getProportionateScreenHeight(8.0)),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xFFFFBBA3).withOpacity(0.8),
                blurRadius: getProportionateScreenHeight(8.0),
              )
            ],
            borderRadius: BorderRadius.circular(getProportionateScreenHeight(8.0)),
            color: AppColors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(getProportionateScreenHeight(15.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: 'Order: ',
                        style: _theme.textTheme.display1.copyWith(
                            color: Color(0xFFFF7675),
                            fontSize: getProportionateScreenHeight(20.0),
                            fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text: '#' + orderNumber.toString().substring(1,8),
                        style: _theme.textTheme.display1
                            .copyWith(color: Color(0xFFFF7675),fontSize: getProportionateScreenHeight(20.0),
                            fontWeight: FontWeight.w700),
                      ),
                    ])),
                    Text(orderDate.toString().substring(0,10),
                        style: _theme.textTheme.display3
                            .copyWith(fontSize: getProportionateScreenHeight(20.0),color: Color(0xFFFFBBA3)))
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(4.0),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: getProportionateScreenHeight(15.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Quantity: ',
                              style: _theme.textTheme.display1
                                  .copyWith(fontSize: getProportionateScreenHeight(17.0),color: Color(0xFFFFBBA3)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: getProportionateScreenWidth(4.0)),
                              child: Text(
                                totalQuantity.toString(),
                                style: _theme.textTheme.display1
                                      .copyWith(color: Color(0xFFFF7675),fontSize: getProportionateScreenHeight(17.0))
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: getProportionateScreenWidth(8.0)),
                          child: Row(

                            children: <Widget>[
                              Text(
                                'Total Amount: ',
                                style: _theme.textTheme.display1
                                    .copyWith(fontSize: getProportionateScreenHeight(17.0),color: Color(0xFFFFBBA3)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: getProportionateScreenHeight(2.0)),
                                child: Text(
                                  '\$' + totalPrice.toString(),
                                  //total amount
                                  style: _theme.textTheme.display1.copyWith(color: Color(0xFFFF7675),
                                                                          fontSize: getProportionateScreenHeight(17.0))
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(4.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      disabledColor: Colors.white,
                      padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(24.0), right: getProportionateScreenWidth(24.0), top: getProportionateScreenHeight(10.0), bottom: getProportionateScreenHeight(10.0)),

                      // onPressed: () {
                      //   onClick(order.id);
                      // },
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(getProportionateScreenHeight(20.0)),
                          side: BorderSide(color: AppColors.black, width: getProportionateScreenWidth(2))),
                      child: Text(
                        'Details',
                        style: _theme.textTheme.display1.copyWith(color: Color(0xFFFF7675),fontSize: getProportionateScreenHeight(20.0))
                      ),
                    ),
                    Text("delivered",
                        style: _theme.textTheme.display1
                            .copyWith(fontSize: getProportionateScreenHeight(20.0),color: AppColors.green)),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
