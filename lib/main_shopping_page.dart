import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:shape_cam/cart/size_config.dart';
import 'package:shape_cam/side_bar.dart';
import 'package:shape_cam/top_product_cards.dart';
import 'package:shape_cam/user_data.dart';
import 'package:get/get.dart';
import 'package:shape_cam/cart/cart_screen.dart';
import 'category_list.dart';

class MainShop extends StatelessWidget {
  final id;
  final token;

  MainShop(this.id, this.token);

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
              backgroundColor: Color(0xFFC0392B),
              title: Text('@DoorStep'),
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
                  child: Carousel(
                    boxFit: BoxFit.cover,
                    images: [
                      Image.network(
                          "https://images.unsplash.com/photo-1508873535684-277a3cbcc4e8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80"),
                      Image.network(
                          "https://images.unsplash.com/photo-1587280501635-68a0e82cd5ff?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80"),
                      Image.network(
                          "https://images.unsplash.com/photo-1445205170230-053b83016050?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=751&q=80"),
                      Image.network(
                          "https://images.unsplash.com/photo-1496293455970-f8581aae0e3b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=701&q=80"),
                      Image.network(
                          "https://images.unsplash.com/photo-1556228453-efd6c1ff04f6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80"),
                      Image.network(
                          "https://images.unsplash.com/photo-1588459460688-561668329db5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1096&q=80"),
                    ],
                    autoplay: true,
                    animationCurve: Curves.decelerate,
                    animationDuration: Duration(milliseconds: 1000),
                    dotSize: 4.0,
                    indicatorBgPadding: 2.0,
                  ),
                ),
                // Container(child: AllProducts()),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(10.0),
                              vertical: getProportionateScreenHeight(10.0)),
                          child: Text(
                            "Browse Category Wise",
                            style: TextStyle(
                                color: Color(0xFFC0392B),
                                fontSize: getProportionateScreenHeight(25.0),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(12.0),
                          child: Divider(
                            color: Colors.black,
                            indent: getProportionateScreenWidth(15.0),
                            endIndent: getProportionateScreenWidth(15.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: CategoryList(id: id, token: token),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TopProductCards(id: id, token: token),
                ),
                //AllProducts()
              ],
            ),
          ),
        );
      },
    );
  }
}
