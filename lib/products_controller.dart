import 'package:shape_cam/products.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter_config/flutter_config.dart';

final url = FlutterConfig.get('SERVER_URL') + "products";

class ProductsController extends GetxController {
  var ls = new List<Products>().obs;
  var id1 = "".obs;
  var id2 = "".obs;
  var name1 = "".obs;
  var picture1 = "".obs;
  var price1 = "".obs;
  var name2 = "".obs;
  var picture2 = "".obs;
  var price2 = "".obs;

  @override
  void onInit() {
    super.onInit();
    updateUI();
  }

  Future<void> updateUI() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (int i = 0; i < data['count']; i = i + 2) {
        id1.value = data['products'][i]['_id'];
        name1.value = data['products'][i]['model'];
        price1.value = data['products'][i]['price'].toString();
        String s1 =
            data['products'][i]['productImage'].toString().split('\\')[0];
        String s2 =
            data['products'][i]['productImage'].toString().split('\\')[1];
        picture1.value = '$s1/$s2';

        id2.value = data['products'][i + 1]['_id'];
        name2.value = data['products'][i + 1]['model'];
        price2.value = data['products'][i + 1]['price'].toString();
        String s3 =
            data['products'][i + 1]['productImage'].toString().split('\\')[0];
        String s4 =
            data['products'][i + 1]['productImage'].toString().split('\\')[1];
        picture2.value = '$s3/$s4';

        ls.add(new Products(id1.value, id2.value, name1.value, name2.value,
            picture1.value, picture2.value, price1.value, price2.value));
      }
    } else {
      print(response.statusCode);
    }
  }
}
