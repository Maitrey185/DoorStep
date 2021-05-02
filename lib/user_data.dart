import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter_config/flutter_config.dart';

class UserData extends GetxController {
  var name = "".obs;
  var email = "".obs;
  var contactNum = "".obs;
  var address = "".obs;
  var imgUrl = "".obs;
  var addresses = [].obs;
  final id;
  final token;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  UserData({this.id, this.token});

  Future<void> updateUserData(uName, uEmail, uContactNum, uAddress) async {
    if (uName != "") {
      name.value = uName;
    }
    if (uEmail != "") {
      email.value = uEmail;
    }
    if (uContactNum != "") {
      contactNum.value = uContactNum;
    }
    if (uAddress != "") {
      address.value = uAddress;
    }

    http.Response response = await http
        .patch(FlutterConfig.get('SERVER_URL') + 'user/$id', headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "name": name.value,
      "email": email.value,
      "contactNo": contactNum.value,
      "deliveryAddress": address.value,
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
    } else {
      print("${response.statusCode} ${response.body}");
    }

    getData();
  }

  Future<void> getData() async {
    http.Response response =
        await http.get(FlutterConfig.get('SERVER_URL') + 'user/$id', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      name.value = data['user']['name'];
      email.value = data['user']['email'];
      contactNum.value = data['user']['contactNo'].toString();
      var s = data['user']['profilePicture'].split('\\');
      String s1 = s[0];
      String s2 = s[1];
      String s3 = s[2];
      imgUrl.value = '$s1/$s2/$s3';
      if (data['user']['deliveryAddress'].length == 0)
        address.value = "Dummy Address";
      else
        address.value = data['user']['deliveryAddress'][0];
    } else {
      print("${response.statusCode} ${response.body}");
    }
  }
}
