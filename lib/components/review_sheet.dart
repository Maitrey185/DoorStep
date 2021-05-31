import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:intl/intl.dart';
import 'package:shape_cam/cart/size_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rating_bar/rating_bar.dart';
import 'package:shape_cam/main_shopping_page.dart';

// ignore: must_be_immutable
class ReviewSheet extends StatelessWidget {
  ReviewSheet(
      {this.userName, this.userId, this.token, this.productId, this.ls});

  String userName;
  String review = "";
  String userId;
  String token;
  String productId;
  List<Map> ls;
  var rating;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(12.0)),
            child: Text(
              "Rate this Product",
              style: TextStyle(
                  color: Color(0xFFFF7675),
                  fontSize: getProportionateScreenHeight(15.0)),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(5.0),
          ),
          RatingBar(
            onRatingChanged: (val) {
              rating = val;
            },
            size: getProportionateScreenHeight(35),
            filledColor: Color(0xFFFF7675),
            halfFilledColor: Color(0xFFFF7675),
            emptyColor: Color(0xFFFF7675),
            isHalfAllowed: true,
            halfFilledIcon: Icons.star_half,
            filledIcon: Icons.star,
            emptyIcon: Icons.star_border,
          ),
          Divider(
            thickness: 1.0,
            color: Colors.black38,
            indent: getProportionateScreenWidth(20.0),
            endIndent: getProportionateScreenWidth(20.0),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20.0)),
              child: TextField(
                onChanged: (rev) {
                  review = rev;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Write here'),
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(40.0),
            width: getProportionateScreenWidth(240.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Color(0xFFFF7675)),
              onPressed: () async {
                var dt = DateTime.now();
                var newFormat = DateFormat("yyyy-MM-dd");
                String updatedDt = newFormat.format(dt);
                if (review != "") {
                  ls.add({
                    "userId": userId,
                    "userName": userName,
                    "rating": rating,
                    "review": review,
                    "date": updatedDt
                  });
                  http.Response response = await http.patch(
                    '${FlutterConfig.get('SERVER_URL')}products/$productId',
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                      'Accept': 'application/json',
                      'Authorization': 'Bearer $token'
                    },
                    body: jsonEncode({"reviews": ls}),
                  );
                  if (response.statusCode == 200) {
                    return showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text("Success"),
                        content: Text(
                            "Review added successfully! Thank you for submitting the review."),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MainShop(userId, token),
                                ),
                              );
                            },
                            child: Text("Continue"),
                          ),
                        ],
                      ),
                    );
                  } else {
                    print("${response.statusCode} ${response.body}");
                  }
                }
              },
              child: Text(
                "Submit",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: getProportionateScreenHeight(18.0)),
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(40.0),
          )
        ],
      ),
    );
  }
}
