import 'package:flutter/material.dart';

import 'cart/size_config.dart';
import 'category_card.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    @required this.id,
    @required this.token,
  });

  final String id;
  final String token;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      children: [
        CategoryCard(
          id: id,
          token: token,
          btnTitle: "Furniture",
          imgUrl:
              "https://images.unsplash.com/photo-1556228453-efd6c1ff04f6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
          category: "furniture",
        ),
        CategoryCard(
          id: id,
          token: token,
          btnTitle: "Sports",
          imgUrl:
              "https://images.unsplash.com/photo-1587280501635-68a0e82cd5ff?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
          category: "sports",
        ),
        CategoryCard(
          id: id,
          token: token,
          btnTitle: "Musical Instruments",
          imgUrl:
              "https://images.unsplash.com/photo-1496293455970-f8581aae0e3b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=701&q=80",
          category: "music",
        ),
        CategoryCard(
          id: id,
          token: token,
          btnTitle: "Tools",
          imgUrl:
              "https://images.unsplash.com/photo-1508873535684-277a3cbcc4e8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
          category: "tools",
        ),
        CategoryCard(
          id: id,
          token: token,
          btnTitle: "Computer and Electronics",
          imgUrl:
              "https://images.unsplash.com/photo-1588459460688-561668329db5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1096&q=80",
          category: "comp_ele",
        ),
        CategoryCard(
          id: id,
          token: token,
          btnTitle: "Apparel",
          imgUrl:
              "https://images.unsplash.com/photo-1445205170230-053b83016050?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=751&q=80",
          category: "apparel",
        ),
      ],
    );
  }
}
