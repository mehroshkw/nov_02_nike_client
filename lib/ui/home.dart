import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nov_02/models/product_model.dart';
import 'package:nov_02/styles/colors.dart';
import 'package:nov_02/ui/allproducts.dart';
import 'package:nov_02/ui/product.dart';
import 'package:nov_02/widgets/buttonwhiteborder.dart';
import 'package:nov_02/widgets/heading.dart';
import 'package:nov_02/widgets/price.dart';
import 'package:nov_02/widgets/priceblack.dart';
import 'package:nov_02/widgets/reusable_button.dart';
import 'package:nov_02/widgets/subblack.dart';
import 'package:nov_02/widgets/subheading.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../models/categories.dart';
import '../widgets/whitebutton.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
     CatModel catModel;
     ProModel proModel;
    var size = MediaQuery.of(context).size;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;


    final double itemHeight = (size.height - kToolbarHeight - 240) / 2;
    final double itemWidth =size.width/2;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final List images=[
      "https://cdn.pixabay.com/photo/2017/12/17/12/45/football-3024154_1280.jpg",
      "https://cdn.pixabay.com/photo/2020/05/26/07/43/skateboard-5221914_1280.jpg",
      "https://cdn.pixabay.com/photo/2016/11/19/09/54/footwear-1838376_1280.jpg",
      "https://cdn.pixabay.com/photo/2022/01/05/11/16/shoes-6916897_1280.jpg",
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(items: images.map((e) =>
                Stack(
                  children: [
                    Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 150,
                      child:CachedNetworkImage(
                        imageUrl: e,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                colorFilter:
                                ColorFilter.mode(Colors.grey.withOpacity(0.3), BlendMode.colorBurn)),
                          ),
                        ),
                        placeholder: (context, url) => JumpingDotsProgressIndicator(
                          fontSize: 60.0,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
              ),
            ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.grey.withOpacity(0.3),
                            Colors.blueAccent.withOpacity(0.3)
                            ]
                          ),
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                    )
                  ],
                )
            ).toList(),
                options: CarouselOptions(height: 150,
                autoPlay: true
                )
            ),

            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            //   // child: Container(
            //   //   height: width / 1.85,
            //   //   width: width,
            //   //   decoration: BoxDecoration(
            //   //     borderRadius: BorderRadius.circular(20),
            //   //     color: Colors.black,
            //   //     image: DecorationImage(
            //   //         image: AssetImage(
            //   //           'assets/images/conbg2.png',
            //   //         ),
            //   //         fit: BoxFit.contain,
            //   //         alignment: Alignment.centerRight),
            //   //     boxShadow: [
            //   //       BoxShadow(
            //   //         color: Colors.grey.withOpacity(0.4),
            //   //         spreadRadius: 3,
            //   //         blurRadius: 4,
            //   //         offset: Offset(2, 0), // changes position of shadow
            //   //       ),
            //   //     ],
            //   //   ),
            //   //   child: Padding(
            //   //     padding: const EdgeInsets.symmetric(
            //   //         horizontal: 10.0, vertical: 8.0),
            //   //     child: Column(
            //   //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   //       crossAxisAlignment: CrossAxisAlignment.start,
            //   //       children: [
            //   //         price(pricetext: 'New Release'),
            //   //         Text(
            //   //           "Nike Air \nMax Plus",
            //   //           style: TextStyle(
            //   //               color: AppColors.textwhite,
            //   //               fontSize: 42,
            //   //               fontWeight: FontWeight.bold),
            //   //         ),
            //   //         price(pricetext: "Classy White"),
            //   //         Container(
            //   //           decoration: BoxDecoration(
            //   //               borderRadius: BorderRadius.circular(50),
            //   //               color: Colors.white),
            //   //           width: width / 4,
            //   //           height: 40,
            //   //           child: TextButton(
            //   //             onPressed: () {},
            //   //             child: Text(
            //   //               "Shop Now",
            //   //               style: TextStyle(color: AppColors.textblack),
            //   //             ),
            //   //             style: ButtonStyle(
            //   //               shape: MaterialStateProperty.all<
            //   //                       RoundedRectangleBorder>(
            //   //                   RoundedRectangleBorder(
            //   //                       borderRadius: BorderRadius.circular(18.0),
            //   //                       side: BorderSide(color: Colors.white))),
            //   //             ),
            //   //           ),
            //   //         )
            //   //       ],
            //   //     ),
            //   //   ),
            //   // ),
            // ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 8),
            //   width: width,
            //   height: 40,
            //   child: GridView(
            //     scrollDirection: Axis.horizontal,
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 1,
            //       childAspectRatio: 1.2 / 2.5,
            //     ),
            //     children: [
            //       TextButton(
            //         onPressed: () {},
            //         child: Text(
            //           "Popular",
            //           style: TextStyle(color: AppColors.textwhite),
            //         ),
            //         style: ButtonStyle(
            //           backgroundColor:
            //               MaterialStateProperty.all<Color>(Colors.black),
            //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //               RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(18.0),
            //                   side: BorderSide(color: Colors.black))),
            //         ),
            //       ),
            //       TextButton(
            //         onPressed: () {},
            //         child: Text(
            //           "Men",
            //           style: TextStyle(color: AppColors.textblack),
            //         ),
            //         style: ButtonStyle(
            //           backgroundColor:
            //               MaterialStateProperty.all<Color>(Colors.transparent),
            //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //               RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(18.0),
            //                   side: BorderSide(color: Colors.transparent))),
            //         ),
            //       ),
            //       TextButton(
            //         onPressed: () {},
            //         child: Text(
            //           "Women",
            //           style: TextStyle(color: AppColors.textblack),
            //         ),
            //         style: ButtonStyle(
            //           backgroundColor:
            //               MaterialStateProperty.all<Color>(Colors.transparent),
            //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //               RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(18.0),
            //                   side: BorderSide(color: Colors.transparent))),
            //         ),
            //       ),
            //       TextButton(
            //         onPressed: () {},
            //         child: Text(
            //           "Kids",
            //           style: TextStyle(color: AppColors.textblack),
            //         ),
            //         style: ButtonStyle(
            //           backgroundColor:
            //               MaterialStateProperty.all<Color>(Colors.transparent),
            //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //               RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(18.0),
            //                   side: BorderSide(color: Colors.transparent))),
            //         ),
            //       ),
            //       TextButton(
            //         onPressed: () {},
            //         child: Text(
            //           "NewRelease",
            //           style: TextStyle(color: AppColors.textblack),
            //         ),
            //         style: ButtonStyle(
            //           backgroundColor:
            //               MaterialStateProperty.all<Color>(Colors.transparent),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => ProductScreen()));
            //   },
            //   child: Container(
            //     margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
            //     width: width,
            //     height: height / 3,
            //     child: GridView(
            //       scrollDirection: Axis.horizontal,
            //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 1,
            //         childAspectRatio: 4 / 3.2,
            //       ),
            //       children: [
            //         Container(
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(20),
            //             color: Colors.black,
            //             boxShadow: [
            //               BoxShadow(
            //                 color: Colors.grey.withOpacity(0.4),
            //                 spreadRadius: 3,
            //                 blurRadius: 4,
            //                 offset: Offset(2, 0), // changes position of shadow
            //               ),
            //             ],
            //           ),
            //           margin: EdgeInsets.all(20),
            //           width: width / 2,
            //           height: 100,
            //           constraints: BoxConstraints.loose(Size.fromHeight(60.0)),
            //           child: Stack(
            //               alignment: Alignment.topCenter,
            //               clipBehavior: Clip.none,
            //               children: [
            //                 Positioned(
            //                   top: -20.0,
            //                   left: -15.0,
            //                   right: -15.0,
            //                   child: Column(
            //                     children: [
            //                       Hero(
            //                         transitionOnUserGestures: true,
            //                         tag: 'shoe1',
            //                         child: Image.asset(
            //                           "assets/images/pro1.png",
            //                           height: 150,
            //                           width: 150,
            //                         ),
            //                       ),
            //                       heading(
            //                         headingtext: 'Nike Air Max 270',
            //                       ),
            //                       subheading(
            //                         subtext: 'Women Wear',
            //                       ),
            //                       price(
            //                         pricetext: '\$190',
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ]),
            //         ),
            //         Container(
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(20),
            //             color: Colors.black,
            //             boxShadow: [
            //               BoxShadow(
            //                 color: Colors.grey.withOpacity(0.4),
            //                 spreadRadius: 3,
            //                 blurRadius: 4,
            //                 offset: Offset(2, 0), // changes position of shadow
            //               ),
            //             ],
            //           ),
            //           margin: EdgeInsets.all(20),
            //           width: width / 2,
            //           height: 100,
            //           constraints: BoxConstraints.loose(Size.fromHeight(60.0)),
            //           child: Stack(
            //               alignment: Alignment.topCenter,
            //               clipBehavior: Clip.none,
            //               children: [
            //                 Positioned(
            //                   top: -20.0,
            //                   left: -15.0,
            //                   right: -15.0,
            //                   child: Column(
            //                     children: [
            //                       Image.asset(
            //                         "assets/images/pro2.png",
            //                         height: 150,
            //                         width: 150,
            //                       ),
            //                       heading(
            //                         headingtext: 'Nike Air Max 270',
            //                       ),
            //                       subheading(
            //                         subtext: 'Men Wear',
            //                       ),
            //                       price(
            //                         pricetext: '\$180',
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ]),
            //         ),
            //         Container(
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(20),
            //             color: Colors.black,
            //             boxShadow: [
            //               BoxShadow(
            //                 color: Colors.grey.withOpacity(0.4),
            //                 spreadRadius: 3,
            //                 blurRadius: 4,
            //                 offset: Offset(2, 0), // changes position of shadow
            //               ),
            //             ],
            //           ),
            //           margin: EdgeInsets.all(20),
            //           width: width / 2,
            //           height: 100,
            //           constraints: BoxConstraints.loose(Size.fromHeight(60.0)),
            //           child: Stack(
            //               alignment: Alignment.topCenter,
            //               clipBehavior: Clip.none,
            //               children: [
            //                 Positioned(
            //                   top: -40.0,
            //                   left: -15.0,
            //                   right: -15.0,
            //                   child: Column(
            //                     children: [
            //                       Image.asset(
            //                         "assets/images/pro3.png",
            //                         height: 170,
            //                         width: 180,
            //                       ),
            //                       heading(
            //                         headingtext: 'Nike Air Max 600',
            //                       ),
            //                       subheading(
            //                         subtext: 'Men Wear',
            //                       ),
            //                       price(
            //                         pricetext: '\$280',
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ]),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

                Container(
                  // alignment: Alignment.topCenter,
                  color: Colors.black,
                  width: width,
                  height: 79,
                  child: GridView.count(
                    scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  children: List.generate(catList.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Center(
                    child: WhiteButton(
                      onTap: (){
                        Navigator.push(context,  MaterialPageRoute(builder: (context) => catList[index].route));
                      },
                      buttonText:
                      "${catList[index].name}",
                    )
                    ),
                  );
                  }
                  )
                  ),
                ),
            SizedBox(height: 5,),
            StreamBuilder<QuerySnapshot>(
                  stream: firestore.collection("products").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                  // color: Colors.black,
                        width: double.infinity,
                        height: height/1.9,
                        child: GridView.builder(
                            shrinkWrap: true,
                               gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 300,
                                // childAspectRatio: 3 / 2,
                                crossAxisSpacing: 20,
                                childAspectRatio: (itemWidth / itemHeight),
                                mainAxisSpacing: 20),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (c, i) {
                              var result = snapshot.data!.docs[i];
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
                                            radius: 80,
                                            backgroundImage: NetworkImage("${result['product_image']}",

                                            ),
                                            // height: 130,
                                            //   width: 130,
                                            //   fit: BoxFit.cover,

                                          ),
                                          subhblack(subtext:  "${result['product_name']}"),
                                          priceblack(pricetext: "${result['product_price']}")

                                        ],
                                      ),
                                    ),

                                  ),
                                ),
                              );
                              // return ClipRRect(
                              //           borderRadius: BorderRadius.circular(30),
                              //           child: Card(
                              //             // fit: FlexFit.loose,
                              //             elevation: 2.0,
                              //               child: Padding(
                              //                 padding: const EdgeInsets.all(8.0),
                              //                 child: Column(
                              //                   children: [
                              //                     CircleAvatar(
                              //                       backgroundColor: Colors.grey,
                              //                       radius: 80,
                              //                      backgroundImage: NetworkImage("${result['product_image']}",
                              //                      ),
                              //                       // height: 130,
                              //                       //   width: 130,
                              //                       //   fit: BoxFit.cover,
                              //                     ),
                              //                    subhblack(subtext:  "${result['product_name']}"),
                              //                   priceblack(pricetext: "${result['product_price']}")
                              //                   ],
                              //                 ),
                              //               ),
                              //           ),
                              //         );
                      }),
                  // GridView.count(
                  //     scrollDirection: Axis.vertical,
                  //     // physics: NeverScrollableScrollPhysics(),
                  //     crossAxisCount: 2,
                  //     shrinkWrap: true,
                  //     mainAxisSpacing: 3.0,
                  //     crossAxisSpacing: 3.0,
                  //     childAspectRatio: (itemWidth / itemHeight),
                  //
                  //     // childAspectRatio: 150/150,
                  //     children: List.generate(productList.length, (index) {
                  //       return ClipRRect(
                  //         borderRadius: BorderRadius.circular(30),
                  //         child: Card(
                  //           // fit: FlexFit.loose,
                  //             child: Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: Column(
                  //                 children: [
                  //                   CircleAvatar(
                  //                     radius: 80,
                  //                  backgroundImage: NetworkImage("${productList[index].imageUrl}",
                  //
                  //                  ),
                  //                     // height: 130,
                  //                     //   width: 130,
                  //                     //   fit: BoxFit.cover,
                  //
                  //                   ),
                  //                  subhblack(subtext:  "${productList[index].name}"),
                  //                 priceblack(pricetext: "${productList[index].price}")
                  //
                  //                 ],
                  //               ),
                  //             ),
                  //
                  //         ),
                  //       );
                  //     }
                  //     )
                  // ),
                    );
                  }else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    }
                  }),
            SizedBox(height: 5,),

            //     Center(
            //           child: Container(
            //             width: width / 2,
            //             height: 50,
            //             child: TextButton(
            //
            //               },
            //                     child: subheading(
            //                       subtext: "Show More",
            //                     ),
            //                     style: ButtonStyle(
            //                       backgroundColor:
            //                           MaterialStateProperty.all<Color>(Colors.black),
            //                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //                           RoundedRectangleBorder(
            //                               borderRadius: BorderRadius.circular(18.0),
            //                               side: BorderSide(color: Colors.black))),
            //                     ),
            //                   ),
            //                 ),
            // )
          ],
        ),
      ),
    );
  }
}
