import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shape_cam/cart/cartItem.dart';
import 'package:shape_cam/cart/cart_screen.dart';
import 'package:shape_cam/cart/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool isProductInCart = false;
  int index = -1;

  var cartBox;

  @override
  void initState() {
    super.initState();
    getBox();
  }

  Future<void> getBox() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("id");
    setState(() {
      cartBox = Hive.box('cartBox$id');
      for (int i = 0; i < cartBox.length; i++) {
        final cartItem = cartBox.getAt(i) as CartItem;
        if (widget.product.id == cartItem.product.id &&
            cartItem.itemCount > 0) {
          isProductInCart = true;
          index = i;
          break;
        }
      }
    });
  }

  int numOfItems = 1;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: [
                Text("Color"),
                ColorDot(
                  color: Color(0xFF356C95),
                  isSelected: true,
                ),
              ],
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Color(0xFF535353)),
                children: [
                  TextSpan(text: "Dimensions\n"),
                  TextSpan(
                    text: "${widget.product.dimensions}",
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenHeight(30.0)),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: getProportionateScreenHeight(5.0)),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(10.0)),
          child: Text(
            widget.product.description,
            style: TextStyle(height: getProportionateScreenHeight(1.5)),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(5.0)),
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
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(5.0)),
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
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(8.0),
                  horizontal: getProportionateScreenWidth(8.0)),
              // height: 32,
              // width: 32,
              child: RatingBar.readOnly(
                size: getProportionateScreenHeight(40),
                initialRating: widget.product.rating.toDouble(),
                filledColor: Color(0xFFFF7675),
                halfFilledColor: Color(0xFFFF7675),
                emptyColor: Color(0xFFFF7675),
                isHalfAllowed: true,
                halfFilledIcon: Icons.star_half,
                filledIcon: Icons.star,
                emptyIcon: Icons.star_border,
              ),
              //child: SvgPicture.asset("assets/icons/heart.svg"),
            ),
          ],
        ),
        SizedBox(height: getProportionateScreenHeight(5.0)),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(10.0)),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  margin:
                      EdgeInsets.only(right: getProportionateScreenWidth(10.0)),
                  height: getProportionateScreenHeight(50.0),
                  width: getProportionateScreenWidth(58.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Color(0xFFFF7675),
                    ),
                  ),
                  child: TextButton(
                    child: Icon(Icons.add_shopping_cart, color: Colors.black),
                    onPressed: () {
                      if (!isProductInCart) {
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
                        print("AA");
                        setState(() {
                          cartItem.itemCount = cartItem.itemCount + numOfItems;
                        });
                        return showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text("Added to Cart"),
                            content: Text(
                                "The product was already in the cart. Changed its quantity!"),
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
              ),
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: getProportionateScreenHeight(50.0),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    color: Color(0xFFFF7675),
                    onPressed: () {
                      if (!isProductInCart) {
                        final cartItem = CartItem(
                            product: widget.product, itemCount: numOfItems);
                        addToCart(cartItem);
                        print("A");
                      } else {
                        final cartItem = cartBox.getAt(index) as CartItem;
                        setState(() {
                          cartItem.itemCount = cartItem.itemCount + numOfItems;
                        });
                      }
                      Get.to(CartScreen());
                    },
                    child: Text(
                      "Buy  Now".toUpperCase(),
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(17.0),
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
    );
  }

  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: getProportionateScreenWidth(40.0),
      height: getProportionateScreenHeight(32.0),
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
        top: getProportionateScreenHeight(2.5),
        right: getProportionateScreenWidth(5.0),
      ),
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(2.5),
          horizontal: getProportionateScreenHeight(2.5)),
      height: getProportionateScreenHeight(24.0),
      width: getProportionateScreenWidth(24.0),
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
