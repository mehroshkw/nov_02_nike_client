import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nov_02/styles/colors.dart';
import 'package:nov_02/ui/aboutus.dart';
import 'package:nov_02/ui/cart.dart';
import 'package:nov_02/ui/contactus.dart';
import 'package:nov_02/ui/home.dart';
import 'package:nov_02/ui/notifications.dart';
import 'package:nov_02/ui/privacy.dart';
import 'package:nov_02/ui/profile.dart';
import 'package:nov_02/ui/settings.dart';
import 'package:nov_02/ui/termncond.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // final FirebaseAuth auth = FirebaseAuth.instance;
  // getCurrentUser() async {
  //   final User user = await auth.currentUser!;
  //   final uid = user.uid;
  //   // Similarly we can get email as well
  //   //final uemail = user.email;
  //   print(uid);
  //   //print(uemail);
  // }
  int pageIndex = 0;

  final pages = [
    const HomeScreen(),
    const Cart(),
    const Profile(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Image.asset(
          "assets/images/logo.png",
          width: 80,
          height: 80,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    // context, MaterialPageRoute(builder: (context) => HomeScreen())));
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Notifications()));
              },
              icon: Icon(
                Icons.notifications_active_outlined,
                color: AppColors.textblack,
              ))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Container(
                height: 120,
                width: 120,
                padding: const EdgeInsets.all(40),
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.notification_add_outlined, color: Colors.black,),
              title: const Text('Notifications'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Notifications()));


              },
            ),
            ListTile(
              leading: Icon(Icons.connect_without_contact_outlined, color: Colors.black,),
              title: const Text('Contact Us'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Contact()));

              },
            ),
            ListTile(
              leading: Icon(Icons.add_business_outlined, color: Colors.black,),
              title: const Text('About Us'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => About()));

              },
            ),

            ListTile(
              leading: Icon(Icons.note_alt_outlined, color: Colors.black,),
              title: const Text('Terms & Conditions'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => TermsConditions()));

              },
            ),

            ListTile(
              leading: Icon(Icons.lock_outline, color: Colors.black,),
              title: const Text('Privacy Policy'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicy()));

              },
            ),
          ],
        ),
      ),
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 25,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 25,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 25,
                  )
                : const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: 25,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              // getCurrentUser();
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
                    Icons.person_sharp,
                    color: Colors.white,
                    size: 25,
                  )
                : const Icon(
                    Icons.person_outline_sharp,
                    color: Colors.white,
                    size: 25,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 3;
              });
            },
            icon: pageIndex == 3
                ? const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 25,
                  )
                : const Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                    size: 25,
                  ),
          ),
        ],
      ),
    );
  }
}
