import 'package:flutter/cupertino.dart';

class Constants{
  Constants._();
  static double getSizeHeight(context){
    double yukseklik =MediaQuery.of(context).size.height;
    return yukseklik;
  }
  static double getSizeWidth(context){
    double genislik =MediaQuery.of(context).size.width;
    return genislik;
  }
}