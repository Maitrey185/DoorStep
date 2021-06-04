import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shape_cam/cart/size_config.dart';
import 'package:shape_cam/product/products.dart';
import 'package:flutter_config/flutter_config.dart';

class AllProducts extends StatefulWidget {
  AllProducts({this.category});
  final String category;

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  List<Products> ls = [];
  var id1 = "";
  var id2 = "";
  var name1 = "";
  var picture1 = "";
  var price1 = "";
  var name2 = "";
  var picture2 = "";
  var price2 = "";
  bool sort = false;

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  Future<void> updateUI() async {
    http.Response response;
    if (sort) {
      response = await http.get(
          "${FlutterConfig.get('SERVER_URL')}products/category/sort/${widget.category}");
    } else {
      response = await http.get(
          "${FlutterConfig.get('SERVER_URL')}products/category/${widget.category}");
    }

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        ls.clear();
        for (int i = 0; i < data.length; i = i + 2) {
          id1 = data[i]['_id'];
          name1 = data[i]['model'];
          price1 = data[i]['price'].toString();
          String s1 = data[i]['productImage'].toString().split('\\')[0];
          String s2 = data[i]['productImage'].toString().split('\\')[1];
          picture1 = '$s1/$s2';

          id2 = data[i + 1]['_id'];
          name2 = data[i + 1]['model'];
          price2 = data[i + 1]['price'].toString();
          String s3 = data[i + 1]['productImage'].toString().split('\\')[0];
          String s4 = data[i + 1]['productImage'].toString().split('\\')[1];
          picture2 = '$s3/$s4';

          ls.add(
            new Products(
                id1, id2, name1, name2, picture1, picture2, price1, price2),
          );
        }
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: getProportionateScreenHeight(8.0)),
      child: Column(
        children: [
          SizedBox(
            height: getProportionateScreenHeight(40.0),
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          sort = true;
                        });
                        updateUI();
                      },
                      child: Text(
                        "Sort by Price",
                        style: TextStyle(
                          color: Color(0xFFC0392B),
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(18.0),
                        ),
                      )),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        sort = false;
                      });
                      updateUI();
                    },
                    child: Text(
                      "Clear",
                      style: TextStyle(
                        color: Color(0xFFC0392B),
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenWidth(18.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: ls,
          ),
        ],
      ),
    );
  }
}
