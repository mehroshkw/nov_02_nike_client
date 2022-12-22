import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nov_02/models/cart_model.dart';
import 'package:nov_02/ui/cart.dart';
import 'package:nov_02/widgets/heading.dart';
import 'package:nov_02/widgets/headingblack.dart';
import 'package:nov_02/widgets/subblack.dart';
import 'package:nov_02/widgets/subheading.dart';

import '../sqflite_db/DBHelper.dart';

class ProductScreen extends StatefulWidget {
  String? productName,productDes, proImg, proCategory, proPrice, prostyle, proID;
  // QueryDocumentSnapshot proDetails;

  // ProductScreen({required this.proDetails});
  ProductScreen({
    required this.productName,
    required this.productDes,
    required this.proImg,
    required this.proCategory,
    required this.proPrice,
    required this.prostyle,
    required this.proID,
  });



  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  DBHelper? dbHelper;
  var cartProduct = '';

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    Future.delayed(const Duration(milliseconds: 0), () async {
      cartProduct = (await dbHelper?.getplantidCart(widget.proID))!;
      setState(() {});
    });
    print(widget.productName);
    print(widget.productDes);
    print(widget.proID);
    print(widget.proCategory);
    print(widget.proImg);
    print(widget.proPrice);
    print(widget.prostyle);
    // print(widget.productDes);
  }
  @override
  Widget build(BuildContext context) {
    // var pId = widget.proDetails;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Container(
                width: width,
                height: height / 2.7,
                // child: CircleAvatar(
                //   radius: 120,
                //   backgroundImage: NetworkImage(widget.image.toString(),),
                // ),
                child: Image.network(
                  "${widget.proImg}",
                  width: 600,
                  height: 600,
                  fit: BoxFit.cover,
                ),
                // child: Image.asset(
                //   "assets/images/pro1.png",
                //   fit: BoxFit.contain,
                //   alignment: Alignment.bottomCenter,
                // ),
                // color: Colors.black,
              ),
            ],
          ),
          Positioned(
            top: 350,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
                padding: EdgeInsets.all(16),
                width: width,
                height: height / 2.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.black,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        heading(headingtext: "${widget.productName}",),
                        heading(headingtext: "\$ ${widget.proPrice}",),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      flex:3,
                      child: Text(
                        "${widget.productDes}",
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.white,
                            letterSpacing: .5,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    subheading(subtext: "Category: ${widget.proCategory}",),
                    SizedBox(
                      height: 5,
                    ),
                    subheading(subtext: "Style: ${widget.prostyle}"),
                    SizedBox(
                      height: 5,
                    ),
                    subheading(
                        subtext:
                            "Free standard shipping on orders over \$1600 ."
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: width / 1.2,
                            height: 50,
                            child:cartProduct != widget.proID || cartProduct == ''? TextButton(
                              onPressed: () async{
                                dbHelper!.insert(CartModel(
                                  productId: widget.proID,
                                  productName: widget.productName,
                                  productPrice: widget.proPrice,
                                  productDescription: widget.productDes,
                                  productCategory: widget.proCategory,
                                  productStyle: widget.prostyle,
                                  productImage: widget.proImg,
                                ));
                                cartProduct = (await dbHelper!.getplantidCart(widget.proID));
                                setState(() {});
                                // Navigator.push(context, MaterialPageRoute(builder: (_) {
                                //   return Cart();
                                // }));
                                // Fluttertoast.showToast(
                                //     msg: "Added to Cart!",
                                //     toastLength: Toast.LENGTH_SHORT,
                                //     gravity: ToastGravity.BOTTOM,
                                //     timeInSecForIosWeb: 3,
                                //     backgroundColor: Colors.black,
                                //     textColor: Colors.white,
                                //     fontSize: 16.0
                                // );
                              },
                              child: subheading(
                                subtext: "Add To Cart",
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.black),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.white))),
                              ),
                            ):Center(child: Text('Product Added in your cart!',style: TextStyle(color: Colors.white),)),
                          ),
                          // Container(
                          //   width: width / 2.5,
                          //   height: 50,
                          //   child: TextButton(
                          //     onPressed: () {},
                          //     child: subhblack(
                          //       subtext: " Add to Favourites",
                          //     ),
                          //     style: ButtonStyle(
                          //       backgroundColor: MaterialStateProperty.all<Color>(
                          //           Colors.white),
                          //       shape: MaterialStateProperty.all<
                          //               RoundedRectangleBorder>(
                          //           RoundedRectangleBorder(
                          //               borderRadius: BorderRadius.circular(18.0),
                          //               side: BorderSide(color: Colors.black))),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
