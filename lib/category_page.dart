import 'package:flutter/material.dart';
import 'package:shape_cam/cart/size_config.dart';
import 'package:shape_cam/side_bar.dart';
import 'product/product_controller.dart';
import 'package:shape_cam/user_data.dart';
import 'package:get/get.dart';
import 'package:shape_cam/cart/cart_screen.dart';

class CategoryPage extends StatelessWidget {
  final id;
  final token;
  final imgUrl;
  final category;
  final title;

  CategoryPage({this.id, this.token, this.imgUrl, this.category, this.title});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetX<UserData>(
        init: UserData(id: id, token: token),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Color(0xFFF2EAEB),
              appBar: new AppBar(
                elevation: 0.1,
                backgroundColor: Color(0xFFFF7675),
                title: Text(title),
                actions: <Widget>[
                  new IconButton(
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.to(CartScreen());
                      })
                ],
              ),
              drawer: SideBar(
                  id: id,
                  token: token,
                  name: controller.name.value,
                  imgUrl: controller.imgUrl.value),
              body: ListView(
                children: [
                  Container(
                      color: Colors.white,
                      // padding: EdgeInsets.all(5.0),
                      height: getProportionateScreenHeight(250.0),
                      child: Image.network(
                        imgUrl,
                        fit: BoxFit.cover,
                      )),
                  Container(child: AllProducts(category: category)),
                ],
              ),
            ),
          );
        });
  }
}
