import 'dart:convert';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shape_cam/main_shopping_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shape_cam/signup_screen.dart';
import 'my_text_field.dart';
import 'round_button.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shape_cam/cart/size_config.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;

  String password;

  String errorMsg = "";
  final TextEditingController passwordFieldController = TextEditingController();
  final TextEditingController emailFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/q.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(60.0),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(24.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: getProportionateScreenHeight(65.0)),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20.0),
                  ),
                  Text(
                    "Sign in with your email and password",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: getProportionateScreenHeight(15.0)),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(60.0),
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: emailFieldController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: "Enter your email",
                      labelText: "Email",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      //suffixIcon:
                      focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.black)),
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.black)),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(30.0),
                  ),
                  TextFormField(
                    controller: passwordFieldController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: "Enter your password",
                      labelText: "Password",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.black)),
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.black)),
                      //suffixIcon: "assets/icons/Lock.svg",
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(12.0),
                  ),
                  Text(
                    errorMsg,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: getProportionateScreenHeight(15.0)),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(12.0),
                  ),
                  RoundButton(
                      colour: Color(0xFFFF7675),
                      title: 'LogIn',
                      onPressed: () async {
                        print(FlutterConfig.get('SERVER_URL'));
                        var res = await http.post(
                          FlutterConfig.get('SERVER_URL') + 'user/login',
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode({
                            'email': emailFieldController.text.trim(),
                            'password': passwordFieldController.text.trim(),
                          }),
                        );
                        if (res.statusCode == 404) {
                          setState(() {
                            errorMsg = "No user found!";
                          });
                        } else if (res.statusCode == 200) {
                          var data = jsonDecode(res.body);
                          print(data["user"]["_id"]);
                          String s1 = data['user']['profilePicture']
                              .toString()
                              .split('\\')[0];
                          String s2 = data['user']['profilePicture']
                              .toString()
                              .split('\\')[1];
                          String s3 = data['user']['profilePicture']
                              .toString()
                              .split('\\')[2];
                          String imgUrl = '$s1/$s2/$s3';
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString(
                              "email", emailFieldController.text.trim());
                          prefs.setString("id", data["user"]["_id"]);
                          prefs.setString("token", data['token']);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MainShop(data["user"]["_id"], data['token']),
                            ),
                            (route) => false,
                          );
                        } else {
                          setState(() {
                            errorMsg = "Invalid Email or Password!";
                          });
                        }
                      }),
                  FlatButton(
                    onPressed: () {
                      Get.to(SignUp());
                    },
                    child: Text("New User? Create an Account"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
