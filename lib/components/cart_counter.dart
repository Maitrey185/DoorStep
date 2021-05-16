import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shape_cam/constants.dart';
import '../detailed_product.dart';
import 'package:shape_cam/detailed_product.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:shape_cam/constants.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


class CartCounter extends StatefulWidget {
  const CartCounter({
    Key key,
    @required this.product,
  }) : super(key: key);
  final DetailedProduct product;

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {


  Box box;
  @override
  void initState(){
    super.initState();
    openBox();
  }

  Future openBox() async{
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('cartBox');
    return;
  }
  int numOfItems = 1;
  @override
  Widget build(BuildContext context) {
    return
      Expanded(
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
                          // ColorDot(color: Color(0xFFF8C078)),
                          // ColorDot(color: Color(0xFFA29B9B)),
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
                  padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin / 2),
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
                              child: FlatButton(
                                child: Icon(Icons.add_shopping_cart),
                                onPressed: () {
                                  box.put('id', widget.product.id);
                                  box.put('count', numOfItems);
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
                                  onPressed: () {},
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