import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shape_cam/cart/cartItem.dart';
import 'package:shape_cam/cart/cart_screen.dart';
import 'package:shape_cam/cart/size_config.dart';
import 'package:shape_cam/components/product_reviews.dart';
import 'package:shape_cam/components/review_sheet.dart';
import 'package:shape_cam/three_D_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../product/detailed_product.dart';
import 'package:shape_cam/product/detailed_product.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:get/get.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

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
  List<ProductReviews> ls = [];
  List<Map> currReviews = [];
  var cartBox;
  String id;
  String token;
  bool noReviews = true;
  String name = "";

  @override
  void initState() {
    super.initState();
    getBox();
    getReviews();
  }

  void getReviews() async {
    ls.clear();
    currReviews.clear();
    int n = widget.product.reviews.length - 1;

    if (n + 1 != 0) {
      noReviews = false;
    }
    if (n > 2) {
      n = 3;
    }

    for (int i = n; i >= 0; i--) {
      setState(() {
        ls.add(new ProductReviews(
            userId: widget.product.reviews[i]['userId'],
            userName: widget.product.reviews[i]['userName'],
            rating:
                double.parse(widget.product.reviews[i]['rating'].toString()),
            review: widget.product.reviews[i]['review'],
            date: widget.product.reviews[i]['date']));

        currReviews.add({
          'userId': widget.product.reviews[i]['userId'],
          'userName': widget.product.reviews[i]['userName'],
          'rating':
              double.parse(widget.product.reviews[i]['rating'].toString()),
          'review': widget.product.reviews[i]['review'],
          'date': widget.product.reviews[i]['date']
        });
      });
    }
  }

  Future<void> getBox() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id");
    token = prefs.getString("token");
    http.Response response =
        await http.get(FlutterConfig.get('SERVER_URL') + 'user/$id', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      name = data['user']['name'];
    }

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
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: TextStyle(color: Color(0xFF535353)),
                children: [
                  TextSpan(text: "Price\n"),
                  TextSpan(
                    text: "₹${widget.product.price}",
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenHeight(30.0)),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(6.0)),
              child: TextButton(
                onPressed: () {
                  Get.to(
                    ThreeDScreen(
                        id: widget.product.id, name: widget.product.model),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFFC0392B),
                  padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(24.0),
                      right: getProportionateScreenWidth(24.0),
                      top: getProportionateScreenHeight(10.0),
                      bottom: getProportionateScreenHeight(10.0)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        getProportionateScreenHeight(20.0)),
                  ),
                ),
                child: Text(
                  'Explore in 3D',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: getProportionateScreenHeight(20.0)),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: getProportionateScreenHeight(5.0)),
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
                filledColor: Color(0xFFC0392B),
                halfFilledColor: Color(0xFFC0392B),
                emptyColor: Color(0xFFC0392B),
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
                      color: Color(0xFFC0392B),
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
                    color: Color(0xFFC0392B),
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
        SizedBox(
          height: getProportionateScreenHeight(45.0),
          child: Divider(
            thickness: 1.0,
            color: Color(0xFFC0392B),
            indent: getProportionateScreenWidth(5.0),
            endIndent: getProportionateScreenWidth(5.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10.0),
          ),
          child: Text(
            "Top Reviews",
            style: TextStyle(
                color: Color(0xFFC0392B),
                fontSize: getProportionateScreenHeight(25.0),
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(15.0),
        ),
        noReviews
            ? Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10.0),
                ),
                child: Text(
                  "No Reviews Yet",
                  style: TextStyle(
                      color: Color(0xFFC0392B),
                      fontSize: getProportionateScreenHeight(15.0)),
                ),
              )
            : SizedBox(height: 0.0),
        Column(
          children: ls,
        ),
        Padding(
          padding: EdgeInsets.only(
              top: getProportionateScreenHeight(14.0),
              bottom: getProportionateScreenHeight(14.0),
              left: getProportionateScreenWidth(10.0)),
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              backgroundColor: Color(0xFFC0392B),
            ),
            onPressed: () {
              Scaffold.of(context).showBottomSheet(
                (context) {
                  return ReviewSheet(
                    ls: currReviews,
                    userName: name,
                    userId: id,
                    token: token,
                    productId: widget.product.id,
                  );
                },
                elevation: 20.0,
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(8.0),
                  horizontal: getProportionateScreenWidth(8.0)),
              child: Text(
                "Write a Review",
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(15.0),
                  color: Colors.white,
                ),
              ),
            ),
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
