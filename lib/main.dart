import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nov_02/ui/login.dart';
import 'package:nov_02/ui/register.dart';
import 'package:nov_02/ui/splash.dart';
import 'package:nov_02/widgets/bottomnav.dart';
import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       home: Splash(),
//     );
//   }
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var emails = prefs.getString("email");

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    // home: AddData()
    // home: ImageHome(),
    // home: Maps(),
    // home: SignUpScreen(),
    // home: MyPhone(),
    home: Splash(),
    // home: emails == null ? Register() : HomePage(),
    // home: Contacts(),
  ));
}
