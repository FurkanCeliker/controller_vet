import 'package:controller_vet/pages/hosgeldin_page.dart';
import 'package:controller_vet/pages/listview_vet.dart';
import 'package:controller_vet/pages/login_page.dart';
import 'package:controller_vet/pages/register_page.dart';
import 'package:controller_vet/pages/vet_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {// landscape mod kapatıldı
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool ac = true;
    return  ScreenUtilInit(
      designSize: Size(412,732),
      builder: ()=>MaterialApp(
      title: 'Material App',
      home:  HosgeldinPage(),
      theme: ThemeData.light().copyWith(
          textTheme: GoogleFonts.cantoraOneTextTheme(),
        ),
      debugShowCheckedModeBanner: false,
    ));
  }
}