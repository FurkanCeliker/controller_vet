// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xFFEDEAF1),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            // Bilgi Yazı Kısmı buraya gelecek
            Row(children: [
              // LOGO
              logo(),
              // Controller Vet text
              companyNameText(),
            ]),

            //Kullanıcı adı şifre kısmı buraya gelecek
            mailText(),
            sifreText(),
            sifremiUnuttum(),
            // Giriş yap butonu
            girisYap(),
          // SOCİAL GİRİŞ
            socialGiris(),

            // Divider kısmı ortasında yazı var
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 50, right: 15),
                    child: Container(
                        height: 1,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                              Colors.white,
                              Colors.black,
                            ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight)),
                        padding: EdgeInsets.only(left: 70, right: 15),
                        child: Divider(
                          height: 30.h,
                          color: Colors.black,
                        )),
                  ),
                  Text('Veteriner Misin?'),
                  Padding(
                      padding: EdgeInsets.only(left: 15, right: 50),
                      child: Container(
                          height: 1.h,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.white, Colors.black],
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft)),
                          padding: EdgeInsets.only(right: 70, left: 15),
                          child: Divider(
                            height: 30.h,
                            color: Colors.black,
                          ))),
                ],
              ),
            ),
            // divider bitti
            kayitOl(),
          ],

          //
        ),
      ),
    );
  }

  Padding companyNameText() {
    return Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Text(
                'VetBul',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
            );
  }

  Padding logo() {
    return Padding(
              padding: const EdgeInsets.only(left: 120, top: 60),
              child: Container(
                height: 60.h,
                width: 50.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('lib/assets/vet.png'),
                      fit: BoxFit.cover),
                ),
              ),
            );
  }

  Padding kayitOl() {
    return Padding(
            padding: const EdgeInsets.only(left: 100, right: 125, top: 10),
            child: TextButton(
                onPressed: () {},
                child: Text(
                  ' Kayıt Ol',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                )),
          );
  }

  Padding socialGiris() {
    return Padding(
            padding: const EdgeInsets.only(top: 10, left: 140),
            child: Row(
              children: [
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white,)),
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset('lib/assets/google.png'),
                    color: Colors.orange,
                    iconSize: 15,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset('lib/assets/facebook.png'),
                    color: Colors.orange,
                    iconSize: 15,
                    
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          );
  }

  Container girisYap() {
    return Container(
            height: 60.h,
            width: 320.w,
            decoration: BoxDecoration(
              color: Color(0xFFF36969),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Giriş Yap',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
  }

  Padding sifremiUnuttum() {
    return Padding(
            padding: const EdgeInsets.only(top: 10, left: 200),
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Şifremi Unuttum',
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
  }

  Padding sifreText() {
    return Padding(
            padding: const EdgeInsets.only(left: 45, right: 45, top: 20),
            child: TextField(
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                  filled: true,
                  labelStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.white,
                  labelText: 'Şifre',
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12))),
              obscureText: _isObscure,
            ),
          );
  }

  Padding mailText() {
    return Padding(
            padding: const EdgeInsets.only(left: 45, right: 45, top: 100),
            child: TextField(
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.grey),
                  labelText: 'Mail Adresi',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none)),
              obscureText: false,
            ),
          );
  }
}
