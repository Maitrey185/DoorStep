import 'package:flutter/material.dart';
import 'single_prod.dart';

class Products extends StatelessWidget {
  final id1;
  final id2;
  final name1;
  final name2;
  final picture1;
  final picture2;
  final price1;
  final price2;

  Products(this.id1, this.id2, this.name1, this.name2, this.picture1,
      this.picture2, this.price1, this.price2);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleProd(
              prodId: id1,
              prodName: name1,
              prodPrice: price1,
              prodPicture: picture1),
        ),
        Expanded(
          child: SingleProd(
              prodId: id2,
              prodName: name2,
              prodPrice: price2,
              prodPicture: picture2),
        ),
      ],
    );
  }
}
