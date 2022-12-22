import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
   ReusableTextField({
    Key? key,
    required this.labelText,
    required this.controller,
     this.isPassword = false,
    this.icon,
      this.check = false,
  }) : super(key: key);

  final String labelText;
  final bool isPassword;
  Widget? icon;
  bool check;



   final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword == false ? false :isPassword ,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: icon,
        labelText: labelText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}