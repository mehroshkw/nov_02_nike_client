import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nov_02/models/categories.dart';
import 'package:nov_02/styles/colors.dart';
import 'package:nov_02/widgets/heading.dart';
import 'package:nov_02/widgets/headingblack.dart';
import 'package:nov_02/widgets/price.dart';
import 'package:nov_02/widgets/subblack.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../models/cart_model.dart';
import '../models/productModel.dart';
import '../sqflite_db/DBHelper.dart';
import '../widgets/subheading.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  DBHelper? dbHelper;
  var uid = '';
  var uemail = '';
  var emailFromFs = '';
  var phoneFromFs = '';
  var nameFromFs = '';
  var addressFromFs = '';
  var profileImage = '';
  var _totalPrice = 0.0;
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
  late  Future<List<CartModel>> cartList;
  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    getUserId();
    getCart();
    totalamount();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 8,
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: FutureBuilder(
                    future: cartList,
                      builder: (context,AsyncSnapshot<List<CartModel>> snapshot){
                      if(snapshot.hasData){
                        if(snapshot.data!.isNotEmpty){
                          return ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index){
                                return   Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onLongPress: (){
                                      showDialog(context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Confirm"),
                                            content:
                                            const Text("Are you sure you want to delete?"),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                onPressed: ()
                                                {
                                                  Navigator.of(context).pop(true);
                                                  dbHelper!.deleteProduct(snapshot.data![index].productId!);
                                                  setState(() {
                                                    getCart();
                                                  });
                                                },


                                                child: const Text("DELETE"),
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.black
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(false),
                                                child: const Text("CANCEL"),
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.black
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: ListTile(
                                        tileColor: AppColors.textblack,
                                        leading: Image.network(snapshot.data![index].productImage!,fit: BoxFit.fill,),
                                        title: subheading(subtext: snapshot.data![index].productName!),
                                        trailing: price(
                                          pricetext: '\$${snapshot.data![index].productPrice!}',
                                        )),
                                  ),
                                );
                              }
                          );
                        }else if(snapshot.data!.isEmpty){
                          return const Center(
                            child: Text('No Products in the Cart!',style: TextStyle(color: Colors.black),),
                          );
                        }
                      }
                      return const Center(child: CircularProgressIndicator());

                      }

                  ),
                )
            ),
            Expanded(
                flex: 1,
                child: SizedBox(
                  child: subhblack(subtext: "Total Payable: ${_totalPrice.toStringAsFixed(2)}",),
                )),
            Expanded(
              flex: 1,
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () async{
                        _uploadToCart(await cartList);
                        Fluttertoast.showToast(
                            msg: "Your order has been placed!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      },
                      child: subheading(
                        subtext: "Proceed to Checkout",
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
                )
            )
          ],
        ),
      )
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: ListView(
      //     children: [
      //       ListTile(
      //           tileColor: AppColors.textblack,
      //           leading: Image.asset("assets/images/pro1.png"),
      //           title: subheading(subtext: "Nike Air Max 270"),
      //           subtitle: price(pricetext: "Discount: 10%"),
      //           trailing: price(
      //             pricetext: "\$180",
      //           )),
      //       SizedBox(
      //         height: 5,
      //       ),
      //       ListTile(
      //           tileColor: AppColors.textblack,
      //           leading: Image.asset("assets/images/pro1.png"),
      //           title: subheading(subtext: "Nike Air Max 270"),
      //           subtitle: price(pricetext: "Discount: 10%"),
      //           trailing: price(
      //             pricetext: "\$180",
      //           )),
      //       SizedBox(
      //         height: 40,
      //       ),
      //       ListTile(
      //         title: Container(
      //           width: 100,
      //           height: 40,
      //           child: TextButton(
      //             onPressed: () {},
      //             child: subheading(
      //               subtext: "Proceed to Checkout",
      //             ),
      //             style: ButtonStyle(
      //               backgroundColor:
      //                   MaterialStateProperty.all<Color>(Colors.black),
      //               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      //                   RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(18.0),
      //                       side: BorderSide(color: Colors.black))),
      //             ),
      //           ),
      //         ),
      //         // trailing: headingblack(subtext: "Total : \$360"),
      //       )
      //     ],
      //   ),
      // ),
    );
  }

  void getCart()async {
    cartList = dbHelper!.getCart();
  }

  void _uploadToCart(List<CartModel> cartList)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid')!;
    var uuid = const Uuid();
    String id = uuid.v4();
    for(CartModel cartItem in cartList) {
      await FirebaseFirestore.instance.collection('orders').doc(id).collection('cart').doc()
          .set(cartItem.toJson()).then((value) {
         FirebaseFirestore.instance.collection('orders').doc(id)
         .set({
           "userId":uid,
           "orderId":id,
           "email":emailFromFs,
           "phone":phoneFromFs,
           "address": addressFromFs,
           "name":nameFromFs,
           "total":_totalPrice.toString()
         });
      });
      // await FirebaseFirestore.instance.collection('orders').doc(uid).collection(id).doc()
      //     .set(cartItem.toJson()).then((value) {
      //       FirebaseFirestore.instance.collection('orders').doc(uid)
      //           .set({
      //         id.toString():{
      //           "id":uid,
      //           "orderId":id,
      //           "name": nameFromFs,
      //           "email": emailFromFs,
      //           "address": addressFromFs,
      //           "phone":phoneFromFs,
      //           "profileImage":profileImage,
      //           "totalAmount":_totalPrice.toStringAsFixed(2),
      //         }
      //
      //       },SetOptions(merge: true));
      //
      //   });
      }
    dbHelper!.deleteTableContent();
    getCart();
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
        print(uid);
        setState(() {});

      });
    });

    setState(() {});
  }
  void totalamount() async{
    _totalPrice = (await dbHelper!.getTotal())!;
    print(_totalPrice);
    setState(() {});
  }
}


