import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shape_cam/cart/cartItem.dart';
import 'package:shape_cam/cart/cart_screen.dart';
import 'package:shape_cam/constants.dart';
import '../product/detailed_product.dart';
import 'package:shape_cam/product/detailed_product.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:get/get.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({
    Key key,
    @required this.product,
  }) : super(key: key);

  final DetailedProduct product;

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  bool isProductInCrt = false;
  int index = -1;

  final cartBox = Hive.box('cartBox');

  @override
  void initState() {
    // code for checking if the product is there
    // in the box and if it's quantity is atleast 1
    for (int i = 0; i < cartBox.length; i++) {
      final cartItem = cartBox.getAt(i) as CartItem;
      if (widget.product.id == cartItem.product.id && cartItem.itemCount > 0) {
        isProductInCrt = true;
        index = i;
        break;
      }
    }
    super.initState();
  }

  int numOfItems = 1;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Color"),
                    Row(
                      children: <Widget>[
                        ColorDot(
                          color: Color(0xFF356C95),
                          isSelected: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: kTextColor),
                    children: [
                      TextSpan(text: "Dimensions\n"),
                      TextSpan(
                        text: "${widget.product.dimensions}",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: kDefaultPaddin / 2),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
            child: Text(
              widget.product.description,
              style: TextStyle(height: 1.5),
            ),
          ),
          SizedBox(height: kDefaultPaddin / 2),
          Row(
            children: <Widget>[
              buildOutlineButton(
                icon: Icons.remove,
                press: () {
                  if (numOfItems > 1) {
                    setState(() {
                      numOfItems--;
                    });
                  }
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPaddin / 2),
                child: Text(
                  // if our item is less  then 10 then  it shows 01 02 like that
                  numOfItems.toString().padLeft(2, "0"),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              buildOutlineButton(
                  icon: Icons.add,
                  press: () {
                    setState(() {
                      numOfItems++;
                    });
                  }),
              Container(
                padding: EdgeInsets.all(8),
                // height: 32,
                // width: 32,
                child: RatingBar.readOnly(
                  initialRating: widget.product.rating.toDouble(),
                  filledColor: Colors.orangeAccent,
                  halfFilledColor: Colors.orangeAccent,
                  emptyColor: Colors.orangeAccent,
                  isHalfAllowed: true,
                  halfFilledIcon: Icons.star_half,
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border,
                ),
                //child: SvgPicture.asset("assets/icons/heart.svg"),
              ),
            ],
          ),
          SizedBox(height: kDefaultPaddin / 2),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: kDefaultPaddin),
                  height: 50,
                  width: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.orangeAccent,
                    ),
                  ),
                  child: TextButton(
                    child: Icon(Icons.add_shopping_cart, color: Colors.black),
                    onPressed: () {
                      if (!isProductInCrt) {
                        final cartItem = CartItem(
                            product: widget.product, itemCount: numOfItems);
                        addToCart(cartItem);
                        return showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text("Added to Cart"),
                            content: Text(
                                "The product is successfully added to yor cart."),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Text("Continue"),
                              ),
                            ],
                          ),
                        );
                      } else {
                        final cartItem = cartBox.getAt(index) as CartItem;
                        setState(() {
                          cartItem.itemCount = cartItem.itemCount + numOfItems;
                        });
                        return showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text("Added to Cart"),
                            content: Text(
                                "The product was already in the cart. Changed it's quantity!"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Text("Continue"),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      color: Colors.orangeAccent,
                      onPressed: () {
                        if (!isProductInCrt) {
                          final cartItem = CartItem(
                              product: widget.product, itemCount: numOfItems);
                          addToCart(cartItem);
                          print("A");
                        } else {
                          final cartItem = cartBox.getAt(index) as CartItem;
                          setState(() {
                            cartItem.itemCount =
                                cartItem.itemCount + numOfItems;
                          });
                        }
                        Get.to(CartScreen());
                      },
                      child: Text(
                        "Buy  Now".toUpperCase(),
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }

  void addToCart(CartItem cartItem) {
    final cartBox = Hive.box('cartBox');
    cartBox.add(cartItem);
  }
}

class ColorDot extends StatelessWidget {
  final Color color;
  final bool isSelected;
  const ColorDot({
    Key key,
    this.color,
    // by default isSelected is false
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: kDefaultPaddin / 4,
        right: kDefaultPaddin / 2,
      ),
      padding: EdgeInsets.all(2.5),
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? color : Colors.transparent,
        ),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
