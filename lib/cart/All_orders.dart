import 'package:flutter/material.dart';
import 'orders_controller.dart';
import 'package:get/get.dart';

class AllOrders extends StatelessWidget {
  // final id;
  // final token;
  //
  // AllOrders(this.id, this.token);

  @override
  Widget build(BuildContext context) {
    return GetX<OrdersController>(
        init: OrdersController(),
        builder: (controller) {
          return Column(
            children: controller.ls,
          );
        });
  }
}
