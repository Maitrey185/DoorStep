import 'package:flutter/material.dart';
import '../cart/size_config.dart';
import 'order_controller.dart';
import 'package:shape_cam/cart/size_config.dart';
import 'theme.dart';
import 'single_order_controller.dart';

class OrderDetails extends StatefulWidget {
  final orderNumber;
  final orderDate;
  final totalQuantity;
  final totalPrice;
  final address;
  final payMethod;
  OrderDetails(
      this.orderNumber, this.orderDate,  this.totalPrice, this.totalQuantity, this.address, this.payMethod);
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = MediaQuery.of(context).size.width;
    var _theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Padding(
        padding:
        EdgeInsets.symmetric(vertical: getProportionateScreenHeight(20.0), horizontal: getProportionateScreenWidth(20)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: 'Order: ',

                        style: _theme.textTheme.display1.copyWith(fontSize: getProportionateScreenHeight(20.0))
                      ),
                      TextSpan(
                        text:
                        '#' + widget.orderNumber.toString().substring(0,8),
                        style: _theme.textTheme.display1
                            .copyWith(fontSize: getProportionateScreenHeight(20.0),fontWeight: FontWeight.w700),
                      ),
                    ])),
                Text(
                    widget.orderDate.toString().substring(0,10),
                    style: _theme.textTheme.display3
                        .copyWith(fontSize: getProportionateScreenHeight(20.0),color: Colors.grey))
              ],
            ),

            SizedBox(
              height: AppSizes.sidePadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      widget.totalQuantity.toString(),
                      style: _theme.textTheme.display1.copyWith(fontSize: getProportionateScreenHeight(20.0),fontWeight: FontWeight.w700)
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: AppSizes.linePadding),
                      child: Text(
                        'items',
                        style: _theme.textTheme.display1.copyWith(fontSize: getProportionateScreenHeight(20.0),fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(15.0),
            ),
            Container(
              child: AllItems(widget.orderNumber),
            ),
            SizedBox(
              height: getProportionateScreenHeight(30.0),
            ),
            buildSummaryLine(
                'Shipping Address:',
                widget.address.toString(),
                _theme,
                width),
            SizedBox(
              height: getProportionateScreenHeight(25.0),
            ),
            buildSummaryLine('Payment Methods:',
                widget.payMethod, _theme, width),
            SizedBox(
              height: getProportionateScreenHeight(25.0),
            ),
            buildSummaryLine(
                'Total Amount:',
                '\$' + widget.totalPrice.toString(),
                _theme,
                width),
            SizedBox(
              height: getProportionateScreenHeight(25.0),
            ),
            Expanded(

              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                Expanded(
                  child: RaisedButton(
                    
                    disabledColor: Colors.white,
                    padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(24.0), right: getProportionateScreenWidth(24.0), top: getProportionateScreenHeight(10.0), bottom: getProportionateScreenHeight(10.0)),

                    // onPressed: () {
                    //   Get.to(OrderDetails(orderNumber, orderDate, totalPrice, totalQuantity,address, payMethod), arguments: [orderNumber, orderDate, totalPrice, totalQuantity,address, payMethod]);
                    // },
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(getProportionateScreenHeight(20.0)),
                        side: BorderSide(color: Colors.black, width: getProportionateScreenWidth(2))),
                    child: Text(
                        'Reorder',
                        style: _theme.textTheme.display1.copyWith(color: Colors.black,fontSize: getProportionateScreenHeight(20.0))
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: getProportionateScreenWidth(15.0)),
                ),
                
                Expanded(
                  child: RaisedButton(
                    disabledColor: Colors.white,
                    padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(24.0), right: getProportionateScreenWidth(24.0), top: getProportionateScreenHeight(10.0), bottom: getProportionateScreenHeight(10.0)),

                    // onPressed: () {
                    //   Get.to(OrderDetails(orderNumber, orderDate, totalPrice, totalQuantity,address, payMethod), arguments: [orderNumber, orderDate, totalPrice, totalQuantity,address, payMethod]);
                    // },
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(getProportionateScreenHeight(20.0)),
                        side: BorderSide(color: Colors.black, width: getProportionateScreenWidth(2))),
                    child: Text(
                        'Feedback',
                        style: _theme.textTheme.display1.copyWith(color: Colors.black,fontSize: getProportionateScreenHeight(20.0))
                    ),
                  ),
                ),
              ]),
            )
          ],
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
        "Order Details",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

Row buildSummaryLine(
    String label, String text, ThemeData _theme, double width) {
  print(label + ' ' + text);
  return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          label,
          style: _theme.textTheme.display1
              .copyWith(fontSize: getProportionateScreenHeight(20.0),color: Colors.grey),
        ),
        Container(
          width: getProportionateScreenWidth(150.0),
          child: Text(
            text,
            style: _theme.textTheme.display1.copyWith(fontSize: getProportionateScreenHeight(20.0),color: Colors.black)
          ),
        )
      ]);
  }
