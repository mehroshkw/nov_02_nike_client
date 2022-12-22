import 'package:flutter/material.dart';
import 'package:nov_02/ui/login.dart';
import 'dart:async';
import 'package:nov_02/ui/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/bottomnav.dart';

class Splash extends StatefulWidget {
  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<Splash> {

  @override
  void didChangeDependencies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var emails = prefs.getString("email");
    Timer(
        Duration(seconds: 3),
            () => Navigator.pushReplacement(
          // context, MaterialPageRoute(builder: (context) => HomeScreen())));
            context,
            // MaterialPageRoute(builder: (context) => Login()))
            MaterialPageRoute(builder: (context) => emails == null ? Login() : HomePage()))
    );
  }

  @override
  void initState()  {

    super.initState();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var emails = prefs.getString("email");
    // Timer(
    //     Duration(seconds: 3),
    //     () => Navigator.pushReplacement(
    //         // context, MaterialPageRoute(builder: (context) => HomeScreen())));
    //         context,
    //         // MaterialPageRoute(builder: (context) => Login()))
    //         MaterialPageRoute(builder: (context) => emails == null ? Register() : HomePage()))
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 300,
      color: Color(0xff88A9C7),
      child: FittedBox(
        fit: BoxFit.fill,
        child: Image.asset('assets/images/splash1.png'),
      ),
    );
  }
}
