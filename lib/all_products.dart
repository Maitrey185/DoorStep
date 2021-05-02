import 'package:flutter/material.dart';
import 'package:shape_cam/products_controller.dart';
import 'package:get/get.dart';

class AllProducts extends StatelessWidget {
  final dataController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return GetX<ProductsController>(
        init: ProductsController(),
        builder: (controller) {
          return Column(
            children: controller.ls,
          );
        });
  }
}
