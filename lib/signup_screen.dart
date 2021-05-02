import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shape_cam/login_screen.dart';
import 'main_shopping_page.dart';
import 'my_text_field.dart';
import 'round_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "SignUp",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.acme(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 70.0),
                    ),
                  ),
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 50.0,
                      child: Image.asset('images/a.PNG'),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ImageProfile(),
                  SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    hint: 'Enter your name',
                    isPassword: false,
                    textAction: TextInputAction.next,
                    handleChange: (value) {
                      name = value;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    nameError,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    height: 20.0,
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
                    height: 5,
                  ),
                  Text(
                    emailError,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  MyTextField(
                    hint: 'Enter your contact number',
                    isPassword: false,
                    keyBoardType: TextInputType.phone,
                    textAction: TextInputAction.next,
                    handleChange: (value) {
                      number = value;
                    },
                  ),
                  SizedBox(
                    height: 38.0,
                  ),
                  MyTextField(
                    hint: 'Enter your password',
                    isPassword: true,
                    handleChange: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    passwordError,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  RoundButton(
                    colour: Colors.orangeAccent,
                    title: 'Sign Up',
                    onPressed: () {
                      postData(FlutterConfig.get('SERVER_URL') + 'user/signup');
                    },
                  ),
                  FlatButton(
                    onPressed: () {
                      Get.to(LoginScreen());
                    },
                    child: Text("Already have an account? Log In"),
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
            radius: 70.0,
            backgroundImage: _imageFile == null
                ? AssetImage('images/default_profile_pic.jpg')
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
                size: 32.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
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
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
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

    if (name == "") {
      setState(() {
        nameError = "Enter username!";
      });
    } else {
      request.fields['name'] = name;
    }

    if (email == "") {
      setState(() {
        emailError = "Enter email address!";
      });
    } else {
      request.fields['email'] = email;
    }

    if (password == "") {
      setState(() {
        passwordError = "Enter password!";
      });
    } else {
      request.fields['password'] = password;
    }

    if (number != "") {
      request.fields['contactNo'] = number;
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
          body: jsonEncode({'email': email, 'password': password}),
        );
        if (res.statusCode == 404) {
          setState(() {
            print("No user found!");
          });
        } else if (res.statusCode == 200) {
          var data = jsonDecode(res.body);
          print(data["user"]["_id"]);
          String s1 = data['user']['profilePicture'].toString().split('\\')[0];
          String s2 = data['user']['profilePicture'].toString().split('\\')[1];
          String s3 = data['user']['profilePicture'].toString().split('\\')[2];
          String imgUrl = '$s1/$s2/$s3';
          SharedPreferences prefs = await SharedPreferences.getInstance();
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
        }

        //Get.to(MainShop());
      }
    });
  }
}
