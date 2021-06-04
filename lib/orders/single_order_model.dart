import 'package:flutter/material.dart';
import 'package:shape_cam/cart/size_config.dart';
import 'package:flutter_config/flutter_config.dart';

class ItemModel extends StatelessWidget {
  final name;
  final quantity;
  final price;
  final image;

  ItemModel(this.name, this.quantity, this.price, this.image);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
        padding: EdgeInsets.only(bottom: getProportionateScreenHeight(15.0)),
        child: Container(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(4.0) * 2),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(getProportionateScreenHeight(8.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: getProportionateScreenHeight(8.0),
                      offset: Offset(0.0, getProportionateScreenHeight(8.0)))
                ],
                color: Colors.white),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(8.0)),
                  child: Container(
                    width: getProportionateScreenWidth(100),
                    child: Image.network(
                      FlutterConfig.get('SERVER_URL') + image,
                      fit: BoxFit.cover,
                      height: getProportionateScreenHeight(100),
                      width: getProportionateScreenWidth(100),
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(15.0)),
                    width: getProportionateScreenWidth(200),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(name,
                              style:
                                  TextStyle(
                                      fontSize:
                                          getProportionateScreenHeight(
                                              20.0),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      getProportionateScreenHeight(4) * 2)),
                          Row(children: <Widget>[
                            Expanded(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Row(children: <Widget>[
                                    Text('Units: ',
                                        style: TextStyle(
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    20.0)),),
                                    Text(quantity.toString(),
                                        style: TextStyle(
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    20.0),
                                            color: Colors.black)),
                                  ]),),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text('₹' + (price).toString(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize:
                                          getProportionateScreenWidth(18.0),),),
                            ),
                          ],),
                        ],),),
              ],
            ),),);
  }
}
