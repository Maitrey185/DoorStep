import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../main_shopping_page.dart';
import 'cartItem.dart';
import 'cart_card.dart';
import 'size_config.dart';
import 'check_out_card.dart';
import 'package:shape_cam/cart/cartItem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int cartLength = 0;
  var uuid = Uuid();
  double total = 0.0;
  String id = "";

  @override
  void initState() {
    super.initState();
    getBox();
  }

  Future<void> getBox() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString("id");
      var cartBox = Hive.box('cartBox$id');
      cartLength = cartBox.length;
      for (int i = 0; i < cartBox.length; i++) {
        final cartItem = cartBox.getAt(i) as CartItem;
        total = total + cartItem.product.price * cartItem.itemCount;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

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
                  valueListenable: Hive.box('cartBox$id').listenable(),
                  builder: (context, cartBox, widget) {
                    return ListView.builder(
                      itemCount: cartBox.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartBox.getAt(index) as CartItem;
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(10)),
                          child: Dismissible(
                            key: Key(uuid.v1().toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              setState(() {
                                total = total - cartItem.product.price;
                                cartBox.deleteAt(index);
                                //getBox();
                              });
                            },
                            background: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenHeight(20)),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFBBA3),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [Spacer(), Icon(Icons.delete)],
                              ),
                            ),
                            child: CartCard(cart: cartItem),
                          ),
                        );
                      },
                    );
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
