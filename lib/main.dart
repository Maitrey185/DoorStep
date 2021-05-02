import 'package:flutter/material.dart';
import 'package:shape_cam/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_shopping_page.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString("email");
  var id = prefs.getString("id");
  var token = prefs.getString("token");
  isLoggedInAndAuth(email, id, token);
}

Future<void> isLoggedInAndAuth(var email, var id, var token) async {
  http.Response response =
      await http.get(FlutterConfig.get('SERVER_URL') + 'user/$id', headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });
  if (response.statusCode == 200 && email != null) {
    runApp(MyApp(true, id, token));
  } else {
    runApp(MyApp(false, id, token));
  }
}

class MyApp extends StatelessWidget {
  final id;
  final token;
  final bool isLoggedIn;

  MyApp(this.isLoggedIn, this.id, this.token);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: isLoggedIn ? MainShop(id, token) : WelcomeScreen(),
    );
  }
}
