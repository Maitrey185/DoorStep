import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:shape_cam/cart/size_config.dart';

class ThreeDScreen extends StatefulWidget {
  ThreeDScreen({this.id, this.name});
  final String id;
  final String name;

  @override
  _ThreeDScreenState createState() => _ThreeDScreenState();
}

class _ThreeDScreenState extends State<ThreeDScreen> {
  Object model;

  @override
  void initState() {
    model = Object(fileName: "assets/${widget.id}/model.obj");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFC0392B),
        title: Text(widget.name),
      ),
      body: Container(
        child: Cube(
          onSceneCreated: (Scene scene) {
            scene.world.add(model);
            scene.camera.zoom = getProportionateScreenWidth(10);
          },
        ),
      ),
    );
  }
}
