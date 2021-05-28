import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'order_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_config/flutter_config.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({Key key}) : super(key: key);

  @override
  _AllOrdersState createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  var id;
  var token;

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  List<OrdersModel> ls = [];
  var orderNumber = "";
  var orderDate = "";
  var totalQuantity = "";
  var totalPrice = "";

  Future<void> updateUI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id");
    token = prefs.getString("token");

    http.Response response = await http
        .get(FlutterConfig.get('SERVER_URL') + 'orders/user/${id}', headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      ls.clear();
      setState(() {
        for (int i = 0; i < data['count']; i++) {
          orderNumber = data['orders'][i]['_id'];
          orderDate = data['orders'][i]['dateOrdered'];
          totalQuantity = data['orders'][i]['cart'].length.toString();
          totalPrice = data['orders'][i]['cartTotal'].toString();

          ls.add(new OrdersModel(
              orderNumber, orderDate, totalQuantity, totalPrice));
        }
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ls,
    );
  }
}
