import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class ThreeDScreen extends StatefulWidget {
  ThreeDScreen({this.id, this.name});
  final String id;
  final String name;

  @override
  _ThreeDScreenState createState() => _ThreeDScreenState();
}

class _ThreeDScreenState extends State<ThreeDScreen> {
  Object jet;

  @override
  void initState() {
    jet = Object(fileName: "assets/${widget.id}/model.obj");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFC0392B),
        title: Text(widget.name),
      ),
      body: Container(
        child: Cube(
          onSceneCreated: (Scene scene) {
            scene.world.add(jet);
            scene.camera.zoom = 10;
          },
        ),
      ),
    );
  }
}
