import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../main_shopping_page.dart';
import 'cartItem.dart';
import 'cart_card.dart';
import '../cart/size_config.dart';
import 'check_out_card.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shape_cam/cart/cartItem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class OrdersScreen1 extends StatefulWidget {
  @override
  _OrdersScreen1State createState() => _OrdersScreen1State();
}

class _OrdersScreen1State extends State<OrdersScreen1> {
  int cartLength = 0;
  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var cartBox = Hive.box('cartBox');
    cartLength = cartBox.length;
    double total = 0.0;
    for (int i = 0; i < cartBox.length; i++) {
      final cartItem = cartBox.getAt(i) as CartItem;
      total = total + cartItem.product.price * cartItem.itemCount;
    }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: cartLength == 0
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset("images/empty-cart.png"),
              ),
              TextButton(
                onPressed: () async {
                  SharedPreferences prefs =
                  await SharedPreferences.getInstance();
                  var id = prefs.getString("id");
                  var token = prefs.getString("token");
                  Get.to(MainShop(id, token));
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFFFF7675),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Your Cart is Empty! Continue Shopping",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )
              : ValueListenableBuilder(
              valueListenable: Hive.box('cartBox').listenable(),
              builder: (context, cartBox, widget) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return OpenFlutterOrderTile(
                        order: orders[index],
                        onClick: ((int orderId) => {
                          bloc..add(ProfileMyOrderDetailsEvent(orderId)),
                          widget.changeView(changeType: ViewChangeType.Exact, index: 7)
                        }),
                      );
                    });
              }),
        ),
        bottomNavigationBar:
        cartLength != 0 ? CheckoutCard(total: total) : null);
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFFF7675),
      leading: TextButton(
        child: Icon(
          Icons.chevron_left,
          size: 40.0,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Your Cart",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
