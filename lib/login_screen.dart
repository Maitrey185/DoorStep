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

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;

  String password;

  String errorMsg = "";

  @override
  Widget build(BuildContext context) {
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
              height: 50.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.acme(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 80.0),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 100.0,
                      child: Image.asset('images/a.PNG'),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  MyTextField(
                    hint: 'Enter your email',
                    isPassword: false,
                    keyBoardType: TextInputType.emailAddress,
                    textAction: TextInputAction.next,
                    handleChange: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  MyTextField(
                    hint: 'Enter your password',
                    isPassword: true,
                    handleChange: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    errorMsg,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 15.0),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  RoundButton(
                      colour: Colors.orangeAccent,
                      title: 'LogIn',
                      onPressed: () async {
                        print(FlutterConfig.get('SERVER_URL'));
                        var res = await http.post(
                          FlutterConfig.get('SERVER_URL') + 'user/login',
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode(
                              {'email': email, 'password': password}),
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
                          prefs.setString("email", email);
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
