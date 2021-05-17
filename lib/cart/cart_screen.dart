import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'cartItem.dart';
import 'cart_card.dart';
import 'size_config.dart';
import 'check_out_card.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shape_cam/cart/cartItem.dart';

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
        child: ValueListenableBuilder(
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
      bottomNavigationBar: CheckoutCard(total: total),
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
