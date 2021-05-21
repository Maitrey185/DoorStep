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
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF2EAEB)
            // image: DecorationImage(
            //   //image: NetworkImage("https://images.unsplash.com/photo-1558066858-246fbbf9446f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=282&q=80"),
            //   fit: BoxFit.cover,
            // ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new ClipPath(
                clipper: MyClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    image: new DecorationImage(
                      image: NetworkImage("https://images.unsplash.com/photo-1607457471980-84e5d89de2fb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1050&q=80"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 150.0, bottom: 100.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "ShapeCam",
                        style: GoogleFonts.raleway(textStyle: TextStyle(
                            fontSize: 60.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        ),),

                      SizedBox(
                        height: 40
                      )
                    ],
                  ),
                ),
              ),


              SizedBox(
                height: 80.0,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: RoundButton(
                        colour: Color(0xFFFF7675),
                        title: 'Sign Up',
                        onPressed: () {
                          Get.to(SignUp());
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: RoundButton(
                        colour: Color(0xFFFFBBA3),
                        title: 'Login',
                        onPressed: () {
                          Get.to(LoginScreen());
                        }),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
//
// class WelcomeScreen extends StatelessWidget {
//
//   final Color primaryColor = Colors.white;
//   final Color backgroundColor = Colors.white;
//
//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//       height: MediaQuery.of(context).size.height,
//       decoration: BoxDecoration(
//         color: this.backgroundColor,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.max,
//         children: <Widget>[
//           new ClipPath(
//             clipper: MyClipper(),
//             child: Container(
//               decoration: BoxDecoration(
//                 image: new DecorationImage(
//                   image: NetworkImage("https://raw.githubusercontent.com/samarthagarwal/FlutterScreens/master/assets/images/full-bloom.png"),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               alignment: Alignment.center,
//               padding: EdgeInsets.only(top: 150.0, bottom: 100.0),
//               child: Column(
//                 children: <Widget>[
//                   Text(
//                     "DEMO",
//                     style: TextStyle(
//                         fontSize: 50.0,
//                         fontWeight: FontWeight.bold,
//                         color: this.primaryColor),
//                   ),
//                   Text(
//                     "Login Screen 1",
//                     style: TextStyle(
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.bold,
//                         color: this.primaryColor),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           Container(
//             margin: const EdgeInsets.only(top: 20.0),
//             padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//             child: new Row(
//               children: <Widget>[
//                 new Expanded(
//                   child: FlatButton(
//                     shape: new RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(30.0)),
//                     splashColor: this.primaryColor,
//                     color: this.primaryColor,
//                     child: new Row(
//                       children: <Widget>[
//                         new Padding(
//                           padding: const EdgeInsets.only(left: 20.0),
//                           child: Text(
//                             "LOGIN",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                         new Expanded(
//                           child: Container(),
//                         ),
//                         new Transform.translate(
//                           offset: Offset(15.0, 0.0),
//                           child: new Container(
//                             padding: const EdgeInsets.all(5.0),
//                             child: FlatButton(
//                               shape: new RoundedRectangleBorder(
//                                   borderRadius:
//                                   new BorderRadius.circular(28.0)),
//                               splashColor: Colors.white,
//                               color: Colors.white,
//                               child: Icon(
//                                 Icons.arrow_forward,
//                                 color: this.primaryColor,
//                               ),
//                               onPressed: () => {},
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                     onPressed: () => {},
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 10.0),
//             padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//             child: new Row(
//               children: <Widget>[
//                 new Expanded(
//                   child: FlatButton(
//                     shape: new RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(30.0)),
//                     splashColor: Color(0xFF3B5998),
//                     color: Color(0xff3B5998),
//                     child: new Row(
//                       children: <Widget>[
//                         new Padding(
//                           padding: const EdgeInsets.only(left: 20.0),
//                           child: Text(
//                             "LOGIN WITH FACEBOOK",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                         new Expanded(
//                           child: Container(),
//                         ),
//                         new Transform.translate(
//                           offset: Offset(15.0, 0.0),
//                           child: new Container(
//                             padding: const EdgeInsets.all(5.0),
//                             child: FlatButton(
//                               shape: new RoundedRectangleBorder(
//                                   borderRadius:
//                                   new BorderRadius.circular(28.0)),
//                               splashColor: Colors.white,
//                               color: Colors.white,
//                               child: Icon(
//                                 const IconData(0xea90, fontFamily: 'icomoon'),
//                                 color: Color(0xff3b5998),
//                               ),
//                               onPressed: () => {},
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                     onPressed: () => {},
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 20.0),
//             padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//             child: new Row(
//               children: <Widget>[
//                 new Expanded(
//                   child: FlatButton(
//                     shape: new RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(30.0)),
//                     color: Colors.transparent,
//                     child: Container(
//                       padding: const EdgeInsets.only(left: 20.0),
//                       alignment: Alignment.center,
//                       child: Text(
//                         "DON'T HAVE AN ACCOUNT?",
//                         style: TextStyle(color: this.primaryColor),
//                       ),
//                     ),
//                     onPressed: () => {},
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//
//         ],
//       ),
//     );
//   }
// }
//
class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height * 0.85);
    p.arcToPoint(
      Offset(0.0, size.height * 0.85),
      radius: const Radius.elliptical(50.0, 10.0),
      rotation: 0.0,
    );
    p.lineTo(0.0, 0.0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}