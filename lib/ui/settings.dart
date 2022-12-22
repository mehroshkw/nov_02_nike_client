import 'package:flutter/material.dart';
import 'package:nov_02/ui/aboutus.dart';
import 'package:nov_02/ui/contactus.dart';
import 'package:nov_02/ui/notifications.dart';
import 'package:nov_02/ui/privacy.dart';
import 'package:nov_02/ui/termncond.dart';
import 'package:nov_02/widgets/subblack.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.circle_notifications_outlined, color: Colors.black, size: 30,),
              title: subhblack(subtext: "Notifications"),
              trailing: Icon(Icons.arrow_forward_ios, size: 20,),
              tileColor: Colors.white,
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Notifications()));
            }
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.dataset_outlined, color: Colors.black, size: 30,),
              title: subhblack(subtext: "About Us"),
              trailing: Icon(Icons.arrow_forward_ios, size: 20,),
              tileColor: Colors.white,
            ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => About()));
              }
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.phonelink_outlined, color: Colors.black, size: 30,),
              title: subhblack(subtext: "Contact Us"),
              trailing: Icon(Icons.arrow_forward_ios, size: 20,),
              tileColor: Colors.white,
            ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Contact()));
              }
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.lock_clock_outlined, color: Colors.black, size: 30,),
              title: subhblack(subtext: "Privacy Policy"),
              trailing: Icon(Icons.arrow_forward_ios, size: 20,),
              tileColor: Colors.white,
            ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicy()));
              }
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.texture_outlined, color: Colors.black, size: 30,),
              title: subhblack(subtext: "Terms & Conditions"),
              trailing: Icon(Icons.arrow_forward_ios, size: 20,),
              tileColor: Colors.white,
            ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => TermsConditions()));
              }
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}