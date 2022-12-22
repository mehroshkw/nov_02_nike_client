import 'package:flutter/material.dart';


class WhiteButton extends StatelessWidget {
  WhiteButton({
    Key? key, required this.buttonText,
    required this.onTap,
  }) : super(key: key);
  final String buttonText;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35,
        width: MediaQuery.of(context).size.width/1.3,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white)
        ),
        child: Center(child: Text(buttonText,style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),),),
      ),
    );
  }
}