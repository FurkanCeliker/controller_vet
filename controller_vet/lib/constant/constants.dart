import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  static ThemeData getThemeData(context){
      ThemeData _theme =ThemeData.light().copyWith(
                    textTheme: GoogleFonts.cantoraOneTextTheme(),
                  );

                  return _theme;
  }
}