import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final bool isPassword;
  final TextInputType keyBoardType;
  final TextInputAction textAction;
  final Function handleChange;

  MyTextField(
      {this.hint,
      this.isPassword,
      this.keyBoardType,
      this.textAction,
      this.handleChange});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: textAction,
      keyboardType: keyBoardType,
      obscureText: isPassword,
      textAlign: TextAlign.center,
      onChanged: handleChange,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
      ),
    );
  }
}
