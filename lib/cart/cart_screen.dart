import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../main_shopping_page.dart';
import 'cartItem.dart';
import 'cart_card.dart';
import 'size_config.dart';
import 'check_out_card.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shape_cam/cart/cartItem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
      appBar: buildAppBar(context),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: cartLength == 0
            ? Container(
                child: Center(
                  child: Image.network(
                      "https://sethisbakery.com/assets/website/images/empty-cart.png"),
                ),
              )
            : ValueListenableBuilder(
                valueListenable: Hive.box('cartBox').listenable(),
                builder: (context, cartBox, widget) {
                  return ListView.builder(
                    itemCount: cartBox.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartBox.getAt(index) as CartItem;
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Dismissible(
                          key: Key(uuid.v1().toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            final cartItem = cartBox.getAt(index) as CartItem;
                            setState(() {
                              total = total - cartItem.product.price;
                              cartBox.deleteAt(index);
                            });
                          },
                          background: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFE6E6),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Spacer(),
                                SvgPicture.asset("assets/icons/Trash.svg"),
                              ],
                            ),
                          ),
                          child: CartCard(cart: cartItem),
                        ),
                      );
                    },
                  );
                }),
      ),
      bottomNavigationBar: cartLength != 0
          ? CheckoutCard(total: total)
          : Padding(
              padding:
                  const EdgeInsets.only(bottom: 300.0, left: 80.0, right: 80.0),
              child: TextButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  var id = prefs.getString("id");
                  var token = prefs.getString("token");
                  Get.to(MainShop(id, token));
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
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
            ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.orangeAccent,
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
