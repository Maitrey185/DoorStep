import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shape_cam/cart/size_config.dart';
import 'order_details.dart';

class OrdersModel extends StatelessWidget {
  final orderNumber;
  final orderDate;
  final totalQuantity;
  final totalPrice;
  final address;
  final payMethod;
  OrdersModel(this.orderNumber, this.orderDate, this.totalQuantity,
      this.totalPrice, this.address, this.payMethod);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.all(getProportionateScreenHeight(8.0)),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: getProportionateScreenHeight(8.0),
                offset: Offset(0.0, getProportionateScreenHeight(8.0)))
          ],
          borderRadius:
              BorderRadius.circular(getProportionateScreenHeight(8.0)),
          color: Colors.white,
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
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Order: ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: getProportionateScreenHeight(18.0),
                              fontWeight: FontWeight.w700),
                        ),
                        TextSpan(
                          text: '#' + orderNumber.toString().substring(1, 8),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: getProportionateScreenHeight(18.0),
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    orderDate.toString().substring(0, 10),
                    style: TextStyle(
                        fontSize: getProportionateScreenHeight(16.0),
                        color: Colors.grey),
                  )
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(8.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Quantity: ',
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(16.0),
                            color: Colors.grey),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(4.0),
                        ),
                        child: Text(
                          totalQuantity.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenHeight(16.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: getProportionateScreenWidth(8.0)),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Total: ',
                          style: TextStyle(
                              fontSize: getProportionateScreenHeight(16.0),
                              color: Colors.grey),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: getProportionateScreenHeight(2.0)),
                          child: Text('₹' + totalPrice.toString(),
                              //total amount
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      getProportionateScreenHeight(16.0))),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(8.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    color: Color(0xFFC0392B),
                    padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(24.0),
                        right: getProportionateScreenWidth(24.0),
                        top: getProportionateScreenHeight(10.0),
                        bottom: getProportionateScreenHeight(10.0)),
                    onPressed: () {
                      Get.to(
                        OrderDetails(orderNumber, orderDate, totalPrice,
                            totalQuantity, address, payMethod),
                        arguments: [
                          orderNumber,
                          orderDate,
                          totalPrice,
                          totalQuantity,
                          address,
                          payMethod
                        ],
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenHeight(20.0),
                      ),
                    ),
                    child: Text(
                      'Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: getProportionateScreenHeight(16.0),
                      ),
                    ),
                  ),
                  Text(
                    getStatus(orderDate.toString()),
                    style: TextStyle(
                        fontSize: getProportionateScreenHeight(16.0),
                        color: getStatus(orderDate.toString()) == "Delivered"
                            ? Colors.green
                            : Colors.red),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  String getStatus(String orderedDate) {
    int year = int.parse(orderedDate.substring(0, 4));
    int month = int.parse(orderedDate.substring(5, 7));
    int day = int.parse(orderedDate.substring(8, 10));

    final dateOfOrder = DateTime(year, month, day);
    final currDate = DateTime.now();
    if (daysBetween(dateOfOrder, currDate) < 4)
      return "Processing";
    else
      return "Delivered";
  }
}
