import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nov_02/models/product_model.dart';
import 'package:nov_02/styles/colors.dart';
import 'package:nov_02/ui/product.dart';
import 'package:nov_02/widgets/heading.dart';
import 'package:nov_02/widgets/price.dart';
import 'package:nov_02/widgets/priceblack.dart';
import 'package:nov_02/widgets/subblack.dart';
import 'package:nov_02/widgets/subheading.dart';

import '../models/categories.dart';
import '../widgets/headingblack.dart';

class KidsProducts extends StatelessWidget {
  const KidsProducts({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    CatModel catModel;
    ProModel proModel;
    var size = MediaQuery.of(context).size;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;


    final double itemHeight = (size.height - kToolbarHeight - 270) / 2;
    final double itemWidth =size.width/2;
    FirebaseFirestore firestore = FirebaseFirestore.instance;


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: headingblack(subtext: "Kids Collection",),
          centerTitle: true,
          backgroundColor: AppColors.textwhite,
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
              stream: firestore.collection("products").where('product_category', isEqualTo: 'Kids').snapshots(),
              builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [

                      SizedBox(height: 5,),
                      Container(
                        // color: Colors.black,
                        width: double.infinity,
                        height: height,
                        child:
                        GridView.count(
                            scrollDirection: Axis.vertical,
                            // physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            mainAxisSpacing: 3.0,
                            crossAxisSpacing: 3.0,
                            childAspectRatio: (itemWidth / itemHeight),
                            // childAspectRatio: 150/150,
                            children: List.generate(snapshot.data!.docs.length, (index) {
                              var result = snapshot.data!.docs[index];
                              return InkWell(
                                onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (_) {
                                  return ProductScreen(
                                    productName: result['product_name'],
                                    productDes: result['product_description'],
                                    proImg: result['product_image'],
                                    prostyle: result['product_material'],
                                    proPrice: result['product_price'],
                                    proCategory: result['product_category'],
                                    proID: result['product_id'],

                                  );
                                }));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Card(
                                    // fit: FlexFit.loose,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.grey.shade100,
                                            radius: 80,
                                            backgroundImage: NetworkImage("${result['product_image']}",

                                            ),
                                            // height: 130,
                                            //   width: 130,
                                            //   fit: BoxFit.cover,

                                          ),
                                          subhblack(subtext:  "${result['product_name']}"),
                                          priceblack(pricetext: "\$ ${result['product_price']}")

                                        ],
                                      ),
                                    ),

                                  ),
                                ),
                              );
                            }
                            )
                        ),
                      ),
                      SizedBox(height: 5,),


                    ],
                  );
                }else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
          ),
        ),
      ),
    );
  }
}
