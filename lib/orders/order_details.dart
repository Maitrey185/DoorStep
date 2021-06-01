import 'package:flutter/material.dart';
import '../cart/size_config.dart';
import 'package:shape_cam/cart/size_config.dart';
import 'single_order_controller.dart';

class OrderDetails extends StatefulWidget {
  final orderNumber;
  final orderDate;
  final totalQuantity;
  final totalPrice;
  final address;
  final payMethod;

  OrderDetails(this.orderNumber, this.orderDate, this.totalPrice,
      this.totalQuantity, this.address, this.payMethod);
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(20.0),
            horizontal: getProportionateScreenWidth(20)),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: 'Order: ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenHeight(20.0),
                            fontWeight: FontWeight.w700)),
                    TextSpan(
                      text: '#' + widget.orderNumber.toString().substring(0, 8),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: getProportionateScreenHeight(20.0),
                          fontWeight: FontWeight.w700),
                    ),
                  ]),
                ),
                Text(widget.orderDate.toString().substring(0, 10),
                    style: TextStyle(
                        fontSize: getProportionateScreenHeight(20.0),
                        color: Colors.grey))
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(15.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(widget.totalQuantity.toString(),
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(20.0),
                            fontWeight: FontWeight.w700)),
                    Padding(
                      padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(4.0)),
                      child: widget.totalQuantity.toString() == '1'
                          ? Text(
                              'Item',
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(20.0),
                                  fontWeight: FontWeight.w700),
                            )
                          : Text(
                              'Items',
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(20.0),
                                  fontWeight: FontWeight.w700),
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
                'Shipping Address:', widget.address.toString(), width),
            SizedBox(
              height: getProportionateScreenHeight(25.0),
            ),
            buildSummaryLine('Payment Methods:', widget.payMethod, width),
            SizedBox(
              height: getProportionateScreenHeight(25.0),
            ),
            buildSummaryLine(
                'Total Amount:', '₹' + widget.totalPrice.toString(), width),
            SizedBox(
              height: getProportionateScreenHeight(40.0),
            ),
            RaisedButton(
              disabledColor: Color(0xFFFF7675),
              padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(24.0),
                  right: getProportionateScreenWidth(24.0),
                  top: getProportionateScreenHeight(10.0),
                  bottom: getProportionateScreenHeight(10.0)),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(getProportionateScreenHeight(20.0)),
              ),
              child: Text('Feedback',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: getProportionateScreenHeight(20.0))),
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

Column buildSummaryLine(String label, String text, double width) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
            fontSize: getProportionateScreenHeight(20.0), color: Colors.grey),
      ),
      SizedBox(
        height: getProportionateScreenHeight(5.0),
      ),
      Text(text,
          style: TextStyle(
              fontSize: getProportionateScreenHeight(20.0),
              color: Colors.black))
    ],
  );
}
