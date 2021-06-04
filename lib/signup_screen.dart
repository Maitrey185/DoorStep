import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shape_cam/login_screen.dart';
import 'main_shopping_page.dart';
import 'round_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shape_cam/cart/size_config.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String name = "";
  String email = "";
  var number = "";
  String password = "";
  PickedFile _imageFile;
  String emailError = "";
  String nameError = "";
  String passwordError = "";
  final ImagePicker _picker = ImagePicker();

  final TextEditingController nameFieldController = TextEditingController();
  final TextEditingController emailFieldController = TextEditingController();
  final TextEditingController numberFieldController = TextEditingController();
  final TextEditingController passwordFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/q.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(10.0),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(24.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "SignUp",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenHeight(50.0)),
                    ),
                  ),

                  SizedBox(
                    height: getProportionateScreenHeight(20.0),
                  ),
                  ImageProfile(),
                  SizedBox(
                    height: getProportionateScreenHeight(20.0),
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: nameFieldController,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      hintText: "Enter your name",
                      labelText: "Name",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 1, color: Colors.black)), //suffixIcon:
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.black)),
                    ),
                  ),

                  SizedBox(
                    height: getProportionateScreenHeight(5.0),
                  ),
                  Text(
                    nameError,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20.0),
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
                      focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 1, color: Colors.black)), //suffixIcon:
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.black)),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5.0),
                  ),
                  Text(
                    emailError,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20.0),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    controller: numberFieldController,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: "Enter your phone number",
                      labelText: "Phone number",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 1, color: Colors.black)), //suffixIcon:
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.black)),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(38.0),
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
                          borderSide: BorderSide(
                              width: 1, color: Colors.black)), //suffixIcon:
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.black)),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5.0),
                  ),
                  Text(
                    passwordError,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  RoundButton(
                    colour: Color(0xFFC0392B),
                    title: 'Sign Up',
                    onPressed: () {
                      postData(FlutterConfig.get('SERVER_URL') + 'user/signup');
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(LoginScreen());
                    },
                    child: Text(
                      "Already have an account? Log In",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ImageProfile() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 55.0,
            backgroundImage: _imageFile == null
                ? AssetImage('assets/images/default_profile_pic.jpg')
                : FileImage(File(_imageFile.path)),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomSheet()),
                );
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.black38,
                size: getProportionateScreenHeight(32.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: getProportionateScreenHeight(100.0),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: getProportionateScreenHeight(20.0),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ignore: deprecated_member_use
              FlatButton.icon(
                icon: Icon(Icons.camera_alt_outlined),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text("Camera"),
              ),
              // ignore: deprecated_member_use
              FlatButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text("Gallery"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
      print(_imageFile.path.split('/').last);
    });
  }

  Future<void> postData(String uri) async {
    var url = Uri.parse(uri);
    var request = new http.MultipartRequest("POST", url);

    if (nameFieldController.text.trim() == "") {
      setState(() {
        nameError = "Enter username!";
      });
    } else {
      request.fields['name'] = nameFieldController.text.trim();
    }

    if (emailFieldController.text.trim() == "") {
      setState(() {
        emailError = "Enter email address!";
      });
    } else {
      request.fields['email'] = emailFieldController.text.trim();
    }

    if (passwordFieldController.text.trim() == "") {
      setState(() {
        passwordError = "Enter password!";
      });
    } else {
      request.fields['password'] = passwordFieldController.text.trim();
    }

    if (numberFieldController.text.trim() != "") {
      request.fields['contactNo'] = numberFieldController.text.trim();
    }

    if (_imageFile != null) {
      http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath('profilePicture', _imageFile.path);
      request.files.add(multipartFile);
    }

    request.send().then((response) async {
      print(response.statusCode);
      if (response.statusCode == 201) {
        print("Uploaded!");
        setState(() {
          nameError = "";
          emailError = "";
          passwordError = "";
        });

        var res = await http.post(
          FlutterConfig.get('SERVER_URL') + 'user/login',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'email': emailFieldController.text.trim(),
            'password': passwordFieldController.text.trim()
          }),
        );
        if (res.statusCode == 404) {
          setState(() {
            print("No user found!");
          });
        } else if (res.statusCode == 200) {
          var data = jsonDecode(res.body);
          print(data["user"]["_id"]);

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("email", emailFieldController.text.trim());
          prefs.setString("id", data["user"]["_id"]);
          prefs.setString("token", data['token']);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) {
              return FutureBuilder(
                future: Hive.openBox('cartBox${data["user"]["_id"]}'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError)
                      return Text(snapshot.error.toString());
                    else
                      return MainShop(data["user"]["_id"], data['token']);
                  }
                  // Although opening a Box takes a very short time,
                  // we still need to return something before the Future completes.
                  else
                    return Scaffold();
                },
              );
            }),
            (route) => false,
          );
        }

        //Get.to(MainShop());
      }
    });
  }
}
