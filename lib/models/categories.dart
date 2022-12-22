import 'package:flutter/material.dart';
import 'package:nov_02/ui/allproducts.dart';
import 'package:nov_02/ui/kids_products.dart';
import 'package:nov_02/ui/men_products.dart';
import 'package:nov_02/ui/women_products.dart';

class CatModel{

  int? id;
  String? name;
  IconData? icon;
  final Widget route;


  CatModel({this.id, this.icon, this.name, required this.route});

}
var catList = [

  CatModel(
      id:0,
      icon: Icons.man,
      name:'Men',
    route: MenProducts(),
  ),
  CatModel(
    id:1,
icon: Icons.woman,
    name:'Women',
    route: WomenProducts(),
  ),
  CatModel(
    id:2,
icon: Icons.child_care,
    name:'Kids',
    route: KidsProducts(),
  ),
  CatModel(
    id:3,
icon: Icons.apps,
    name:'More',
    route: AllProducts(),
  ),
];