import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nov_02/models/auth_controller.dart';
import 'package:nov_02/ui/home.dart';
import 'package:nov_02/ui/login.dart';
import 'package:nov_02/ui/register.dart';
import 'package:nov_02/widgets/bottomnav.dart';
import 'package:nov_02/widgets/reusable_button.dart';
import 'package:nov_02/widgets/reusable_textfield.dart';

import '../widgets/subheading.dart';
import 'forgot_password.dart';

class Register extends StatefulWidget {
   Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();

  AuthController authController = AuthController();
  String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  Future<void> validate(String email, String password) async {
    if (formKey.currentState!.validate()) {
      // authController.emailController.toString();
      authController.createAccount();
      Fluttertoast.showToast(
          msg: "Creating Your Account...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
      print("Success");
    }
  }


  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final  height = MediaQuery.of(context).size.height;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height/9,),
              Container(
                width: width,
                height: height/8,
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 200,
                  height: 200,
                ),
              ),
              SizedBox(height: height/20,),
              Text("Welcome!"
                ,style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(16.0),
                // margin: EdgeInsets.all(4.0),
                height: height/1.8,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      // ReusableTextField(
                      //   labelText: 'Email',
                      //   controller: authController.emailController,
                      // ),
                      TextFormField(
                        // obscureText: isPassword == false ? false :isPassword ,
                        controller: authController.emailController,
                        validator: (v) {
                          if (authController.emailController.text.isEmpty) {
                            return "Please Enter the Email";
                          }
                          else if (!authController.emailController.text.isEmail){
                            return "Please Enter a Valid Email";
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          errorBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          focusedErrorBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      // ReusableTextField(
                      //   labelText: 'Password',
                      //   controller: authController.passwordController,
                      // ),
                      TextFormField(
                        obscureText: true,
                        controller: authController.passwordController,
                        validator: (v) {
                          if (authController.passwordController.text.isEmpty) {
                            return "Please Enter the Password";
                          } else if(authController.passwordController.text.length < 6){
                            return "Please Enter the Password";
                          }else if(!RegExp(pattern).hasMatch(authController.passwordController.text)){
                            return"Password Must contain 1 Uppercase, 1 symbol and length must be 8";
                          }

                        },

                        decoration: InputDecoration(
                          labelText: "Password",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedErrorBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          errorBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      // custom button and converting into  component
                      ReusablePrimaryButton(
                        onTap: () {
                          // authController.loginUser();
                          validate(authController.emailController.text, authController.passwordController.text);
                          // Fluttertoast.showToast(
                          //     msg: "Creating Account",
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.BOTTOM,
                          //     timeInSecForIosWeb: 3,
                          //     backgroundColor: Colors.black,
                          //     textColor: Colors.white,
                          //     fontSize: 16.0
                          // );
                        },
                        buttonText: 'Create An Account',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account?'),
                          TextButton(
                            onPressed: () {
                              Get.to(Login());
                            },
                            child: Text('Login'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Forgot Password?'),
                          TextButton(
                            onPressed: () {
                              Get.to(ForgotPass());
                            },
                            child: Text('Reset Password'),
                          ),
                        ],
                      ),

                      // ReusablePrimaryButton(buttonText: 'LOGIN', onTap: () {
                      //   Get.to(UserRoles());
                      // },
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // return Scaffold(
    //   body: SingleChildScrollView(
    //     child: Container(
    //       padding: EdgeInsets.all(16.0),
    //       width: width,
    //       height: height,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           SizedBox(height: height/9,),
    //           Container(
    //             width: width,
    //             height: height/8,
    //             child: Image.asset(
    //               "assets/images/logo.png",
    //               width: 200,
    //               height: 200,
    //             ),
    //           ),
    //           SizedBox(height: 20,),
    //           Container(
    //             padding: EdgeInsets.all(16.0),
    //             // margin: EdgeInsets.all(4.0),
    //             height: height/1.8,
    //             width: width,
    //             decoration: BoxDecoration(
    //               color: Colors.white,
    //               borderRadius: BorderRadius.circular(20.0),
    //               boxShadow: [
    //                 BoxShadow(
    //                   color: Colors.grey.withOpacity(0.5),
    //                   spreadRadius: 3,
    //                   blurRadius: 7,
    //                   offset: Offset(0, 5), // changes position of shadow
    //                 ),
    //               ],
    //             ),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 SizedBox(
    //                   height: 20,
    //                 ),
    //                 ReusableTextField(
    //                   labelText: 'Email',
    //                   controller: authController.emailController,
    //                 ),
    //                 SizedBox(
    //                   height: 20,
    //                 ),
    //                 ReusableTextField(
    //                   labelText: 'Password',
    //                   controller: authController.passwordController,
    //                 ),
    //                 const SizedBox(height: 20,),
    //             ReusablePrimaryButton(
    //               onTap: () {
    //                 authController.createAccount();
    //                 Fluttertoast.showToast(
    //                     msg: "Creating Your Account. Please Wait.....",
    //                     toastLength: Toast.LENGTH_SHORT,
    //                     gravity: ToastGravity.BOTTOM,
    //                     timeInSecForIosWeb: 3,
    //                     backgroundColor: Colors.black,
    //                     textColor: Colors.white,
    //                     fontSize: 16.0
    //                 );
    //               },
    //
    //               buttonText: 'Sign Up',
    //             ),
    //             SizedBox(
    //               height: 20,
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Text('Already have an account?'),
    //                 TextButton(
    //                   onPressed: () {
    //                     Get.to(Login());
    //                   },
    //                   child: Text('Login'),
    //                 ),
    //               ],
    //             ),
    //          ] ),
    //     )],
    //       ),
    //     ),
    //   ),
    // );
  }
}
