import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nov_02/ui/login.dart';
import 'package:nov_02/widgets/bottomnav.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthController extends GetxController {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // final TextEditingController loginEmailController = TextEditingController();
  // final TextEditingController loginPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> createAccount() async {
    final user = await _auth.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text).then((value) {
      var firestore = FirebaseFirestore.instance;
      firestore.collection('users').doc(value.user!.uid).set(
      {
        "email": emailController.text,
        "name": nameController.text,
        "address": addressController.text,
        "phone": phoneController.text,
        // "email": emailController.text,
        // "email": emailController.text,
        // "password": passwordController.text
      }
      );
      if (value.user != null) {
      Get.to(Login());
      } else {
      print('error');
      }
      });

        // email: emailController.text, password: passwordController.text).whenComplete(() => Get.to(Login()));
    // final firestore = FirebaseFirestore.instance;
    // firestore.collection('users').doc(user.user!.uid).set(
    //     {"email": emailController.text, "password": passwordController.text});
    // if (user != null) {
    //   Get.to(Login());
    // } else {
    //   print('error');
    // }
  }

  Future<String?> loginUser() async {
    final user = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text);
    if (user != null) {
      user.user!.uid;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("email",emailController.text );
      prefs.setString("uid",user.user!.uid.toString());
      print(user.user!.uid);
      Fluttertoast.showToast(
          msg: "Logging You In....",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Get.to(HomePage());
    } else {
      print('error');
    }

  }


  Future<void> logoutUser() async {
    await _auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.offAll(Login());
  }



  Future<void> sendpasswordresetemail(String email) async{
    await _auth.sendPasswordResetEmail(email: email).then((value) {
      Get.offAll(Login());
      Get.snackbar("Password Reset email link is been sent", "Success");
    }).catchError((onError)=> Get.snackbar("Error In Email Reset", onError.message) );
  }

  //
  //   Future<OAuthCredential> signInWithGoogle() async {
  //   // FirebaseAuth.instance.signOut();
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn()
  //       .signIn()
  //       .whenComplete(() => Get.to(() => HomePage()));
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;
  //
  //   // Create a new credential
  //   return GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  // }

//
// Future<UserCredential?> signInWithFacebook() async {
//   final LoginResult result = await FacebookAuth.instance.login();
//   if(result.status == LoginStatus.success){
//     // Create a credential from the access token
//     final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
//     // Once signed in, return the UserCredential
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }
//   return null;
// }
}