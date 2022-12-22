import 'package:flutter/material.dart';

class ReusablePasswordField extends StatelessWidget {
  ReusablePasswordField({
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
      obscureText: true ,
      controller: controller,
      validator: (val) {
        if(val!.isEmpty){
          return "Please Enter Password";
        }
      },
      // onSaved: (val) => _password = val,
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