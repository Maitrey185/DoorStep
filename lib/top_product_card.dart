import 'package:flutter/material.dart';
import 'package:shape_cam/cart/size_config.dart';
import 'package:get/get.dart';
import 'category_page.dart';

class TopProductCard extends StatelessWidget {
  TopProductCard(
      {this.img1,
      this.img2,
      this.category,
      this.id,
      this.token,
      this.imgUrl,
      this.btnTitle});

  final String img1;
  final String img2;
  final String category;
  final String id;
  final String token;
  final String imgUrl;
  final String btnTitle;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(
      children: [
        ListTile(
          title: Text(btnTitle),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50.0)),
                  height: getProportionateScreenHeight(150.0),
                  padding: EdgeInsets.only(
                      top: getProportionateScreenHeight(3.0),
                      bottom: getProportionateScreenHeight(3.0)),
                  child: GridTile(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image.network(
                        img1,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50.0)),
                  height: getProportionateScreenHeight(150.0),
                  padding: EdgeInsets.only(
                      top: getProportionateScreenHeight(3.0),
                      bottom: getProportionateScreenHeight(3.0)),
                  child: GridTile(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image.network(
                        img2,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                Get.to(CategoryPage(
                    id: id,
                    token: token,
                    imgUrl: imgUrl,
                    title: btnTitle,
                    category: category));
              },
              child: Text(
                'Explore More',
                style: TextStyle(
                    color: Color(0xFFC0392B), fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
