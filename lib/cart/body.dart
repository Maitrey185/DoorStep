import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shape_cam/cart/cartItem.dart';
import 'size_config.dart';
import 'cart_card.dart';
import 'package:uuid/uuid.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      setState(() {
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
    );
  }
}
