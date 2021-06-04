import 'package:flutter/material.dart';
import 'package:shape_cam/cart/size_config.dart';
import 'package:get/get.dart';
import 'package:shape_cam/category_page.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard(
      {this.imgUrl, this.category, this.btnTitle, this.id, this.token});

  final String imgUrl;
  final String category;
  final String btnTitle;
  final String id;
  final String token;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0)),
          height: getProportionateScreenHeight(150.0),
          padding: EdgeInsets.only(
              top: getProportionateScreenHeight(3.0),
              bottom: getProportionateScreenHeight(3.0)),
          child: GridTile(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Image.network(
                imgUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
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
            btnTitle,
            style: TextStyle(
                color: Color(0xFFC0392B), fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
