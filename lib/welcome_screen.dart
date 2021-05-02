import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shape_cam/round_button.dart';
import 'package:shape_cam/signup_screen.dart';
import 'login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 150.0,
                  child: Image.asset("images/a.PNG"),
                ),
              ),
            ),
            Text(
              'ShapeCam',
              textAlign: TextAlign.center,
              style: GoogleFonts.acme(
                textStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 70.0),
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: RoundButton(
                  colour: Colors.orangeAccent,
                  title: 'Sign Up',
                  onPressed: () {
                    Get.to(SignUp());
                  }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: RoundButton(
                  colour: Colors.orangeAccent,
                  title: 'Login',
                  onPressed: () {
                    Get.to(LoginScreen());
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
