import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:shape_cam/cart/size_config.dart';
import 'package:shape_cam/side_bar.dart';
import 'package:flutter_config/flutter_config.dart';
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
              backgroundColor: Color(0xFFFF7675),
              title: Text('ShapeCam'),
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
                      Image.network(FlutterConfig.get('SERVER_URL') +
                          'uploads/carousel_imgs/c1.jpg'),
                      Image.network(FlutterConfig.get('SERVER_URL') +
                          'uploads/carousel_imgs/c2.jpg'),
                      Image.network(FlutterConfig.get('SERVER_URL') +
                          'uploads/carousel_imgs/c3.jpg'),
                      Image.network(FlutterConfig.get('SERVER_URL') +
                          'uploads/carousel_imgs/c4.jpg'),
                      Image.network(FlutterConfig.get('SERVER_URL') +
                          'uploads/carousel_imgs/c5.jpg'),
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
                                color: Color(0xFFFF7675),
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
