import 'package:flutter/material.dart';
import 'package:shape_cam/cart/size_config.dart';
import 'package:get/get.dart';
import 'package:shape_cam/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'orders/orders_screen.dart';
import 'package:flutter_config/flutter_config.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    @required this.id,
    @required this.token,
    @required this.imgUrl,
    @required this.name,
  });

  final String id;
  final String token;
  final String name;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
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
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 60,
                      backgroundImage: NetworkImage(
                          FlutterConfig.get('SERVER_URL') + '$imgUrl'),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20.0)),
                  Text(
                    'Hello, $name!',
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
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16.0),
                  vertical: getProportionateScreenHeight(16.0)),
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
            ListTile(
              leading: Icon(
                Icons.list_alt_outlined,
                size: 30.0,
                color: Colors.black,
              ),
              title: Text('My Orders'),
              onTap: () {
                Get.to(OrdersScreen());
              },
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16.0),
                  vertical: getProportionateScreenHeight(16.0)),
              child: Text(
                'Logout',
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
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
    );
  }
}
