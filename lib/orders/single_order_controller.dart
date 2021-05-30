import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'order_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_config/flutter_config.dart';
import 'single_order_model.dart';
class AllItems extends StatefulWidget {
  var id;
  AllItems(this.id);

  @override
  _AllItemsState createState() => _AllItemsState();
}

class _AllItemsState extends State<AllItems> {

  var token;

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  List<ItemModel> ls = [];
  var name = "";
  var quantity = "";
  var price = "";
  var image = "";



  Future<void> updateUI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");

    http.Response response = await http
        .get(FlutterConfig.get('SERVER_URL') + 'orders/${widget.id}', headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      ls.clear();
      setState(() {
        for (int i = 0; i < data['cart'].length; i++) {
          name = data['cart'][i]['name'];
          quantity = data['cart'][i]['quantity'];
          price = data['cart'][i]['price'].toString();
          image = data['cart'][i]['productImage'];
          ls.add(new ItemModel(
              name, quantity, price, image));
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
