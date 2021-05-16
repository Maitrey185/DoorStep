import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shape_cam/product/detailed_product.dart';
import 'package:shape_cam/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cart/cartItem.dart';
import 'main_shopping_page.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(CartItemAdapter());
  Hive.registerAdapter(DetailedProductAdapter());
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

class MyApp extends StatefulWidget {
  final id;
  final token;
  final bool isLoggedIn;

  MyApp(this.isLoggedIn, this.id, this.token);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: widget.isLoggedIn
          ? FutureBuilder(
              future: Hive.openBox('cartBox'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError)
                    return Text(snapshot.error.toString());
                  else
                    return MainShop(widget.id, widget.token);
                }
                // Although opening a Box takes a very short time,
                // we still need to return something before the Future completes.
                else
                  return Scaffold();
              },
            )
          : WelcomeScreen(),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
