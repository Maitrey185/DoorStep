import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:shape_cam/cart/size_config.dart';
import 'product/all_products.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:shape_cam/user_data.dart';
import 'package:get/get.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shape_cam/cart/cart_screen.dart';

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
              drawer: SafeArea(
                child: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 42, bottom: 16.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 55,
                              backgroundColor: Colors.orangeAccent,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(
                                    FlutterConfig.get('SERVER_URL') +
                                        '${controller.imgUrl}'),
                              ),
                            ),
                            SizedBox(height: getProportionateScreenHeight(20.0)),
                            Text(
                              'Hello, ${controller.name}!',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:getProportionateScreenWidth(16.0) ,vertical: getProportionateScreenHeight(16.0)),
                        child: Text(
                          'Check and Update your Profile',
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.account_circle_outlined,
                          size: 30.0,
                          color: Colors.black,
                        ),
                        title: Text('My Profile'),
                        onTap: () {
                          Get.to(ProfileScreen(), arguments: [id, token]);
                        },
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:getProportionateScreenWidth(16.0) ,vertical: getProportionateScreenHeight(16.0)),
                        child: Text(
                          'Logout',
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('Logout'),
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.remove("email");
                          prefs.remove("id");
                          prefs.remove("token");
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => LoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
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
                  Container(child: AllProducts()),
                ],
              ),
            ),
          );
        });
  }
}
