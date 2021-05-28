import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter_config/flutter_config.dart';
import 'order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OrdersController extends GetxController {

  var id;
  var token;

  //
  // OrdersController(this.id, this.token);

  var ls = new List<Orders_model>().obs;
  var orderNumber = "".obs;
  var orderDate= "".obs;
  var totalQuantity = "".obs;
  var totalPrice = "".obs;


  @override
  void onInit() {
    super.onInit();

    updateUI();

  }

  Future<void> updateUI() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();
    id = prefs.getString("id");
    token=prefs.getString("token");
    http.Response response = await http.get(
        FlutterConfig.get('SERVER_URL') + 'orders/user/${id}',
        headers: {
          'Authorization': 'Bearer $token',
        }
        );
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      for (int i = 0; i < data['count']; i++) {
        orderNumber.value = data['orders'][i]['_id'];
        orderDate.value = data['orders'][i]['dateOrdered'];
        totalQuantity.value = data['orders'][i]['cart'].length.toString();
        totalPrice.value = data['orders'][i]['cartTotal'].toString();


        ls.add(new Orders_model(orderNumber.value, orderDate.value, totalQuantity.value, totalPrice.value,));
      }
    } else {
      print(response.statusCode);
    }


  }
}
