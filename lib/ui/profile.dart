import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nov_02/models/productModel.dart';
import 'package:nov_02/ui/edit_profile.dart';
import 'package:nov_02/widgets/profilename.dart';
import 'package:nov_02/widgets/subblack.dart';
import 'package:nov_02/widgets/subheading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_controller.dart';
import '../widgets/reusable_button.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var uid = '';
  var uemail = '';
  var emailFromFs = '';
  var phoneFromFs = '';
  var nameFromFs = '';
  var addressFromFs = '';
  var profileImage = '';
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  getCurrentUser() async {
    firestore.collection("users").snapshots();
    final User user = await auth.currentUser!;
    final uid = user.uid;
    // Similarly we can get email as well
    final uemail = user.email;
    print(uid);
    //print(uemail);
  }
  @override
  Widget build(BuildContext context) {
    AuthController authController = AuthController();

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection("users").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasData){
            // var result = snapshot.data!.docs[i];
          return Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
              height: 50,
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child:  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 100,
                    backgroundImage: NetworkImage(
                      "${profileImage}",
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              ProfileName(subtext: nameFromFs),
              SizedBox(
                height: 30,
              ),
             Container(
               width: double.infinity,
               height: 200,
               child: ListView(
                 children: [
                   ListTile(
                     leading: Icon(Icons.mail_outline, color: Colors.black,),
                     title: subhblack(subtext: emailFromFs),
                     // trailing: Icon(Icons.check),
                     tileColor: Colors.white,
                   ),
                   SizedBox(
                     height: 5,
                   ),
                   ListTile(
                     leading: Icon(Icons.phone_android_outlined, color: Colors.black,),
                     title: subhblack(subtext: phoneFromFs),
                     // trailing: Icon(Icons.check),
                     tileColor: Colors.white,
                   ),
                   SizedBox(
                     height: 5,
                   ),
                   ListTile(
                     leading: Icon(Icons.location_on_outlined, color: Colors.black,),
                     title: subhblack(subtext:addressFromFs),
                     // trailing: Icon(Icons.check),
                     tileColor: Colors.white,
                   ),
                 ],
               ),
             ),
              Container(
                width: width / 1.2,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Get.to(EditProfile());
                  },
                  child: subheading(
                    subtext: "Edit Profile",
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black))),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: ReusablePrimaryButton(
                  buttonText: 'Logout',
                  onTap: () {
                    authController.logoutUser();
                    Fluttertoast.showToast(
                        msg: "Logging Out.....",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
// ========for loggin out from google account=======
                    // GoogleSignIn().signOut().whenComplete(() {
                    //   print("logout");
                    //   Get.off(LoginScreen);
                    // });
                  },
                ),
              ),


            ],
          );}
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        }
      ),
    );
  }
  void getUserId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid')!;
    uemail = prefs.getString('email')!;
    Future.delayed(const Duration(milliseconds: 0),(){
      FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
        ProfileModel profileModel = ProfileModel.fromMap(value.data());
        print(profileModel.email);
        emailFromFs = profileModel.email.toString();
        phoneFromFs = profileModel.phone.toString();
        nameFromFs = profileModel.name.toString();
        addressFromFs = profileModel.address.toString();
        profileImage = profileModel.profileImage.toString();
        setState(() {});

      });
    });

    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    getUserId();
  }
}