// ignore_for_file: dead_code

import 'package:controller_vet/bloc/auth_bloc.dart';
import 'package:controller_vet/pages/register_page.dart';
import 'package:controller_vet/pages/sifremi_unuttum_page.dart';
import 'package:controller_vet/pages/sorgu_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _isObscure = true;
 

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>  IlIlceSecimi()));
          }
         else if (state is AuthError) {
           
           
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
             
              
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UnAuthenticated) {
              return Form(
                key: formKey,
                child: Container(
                  color: const Color(0xFFEDEAF1),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                     const Spacer(),
                      // Bilgi Yazı Kısmı buraya gelecek
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                      SizedBox(
                        height: 10.h,
                      ),
                      // SOCİAL GİRİŞ
                      socialGiris(),
                      SizedBox(
                        height: 10.h,
                      ),

                      // Divider kısmı ortasında yazı var
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15.w, right: 15.w),
                            child: Container(
                                height: 1,
                                decoration:const BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                      Colors.white,
                                      Colors.black,
                                    ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight)),
                                padding:
                                    EdgeInsets.only(left: 100.w, right: 15),
                                child: Divider(
                                  height: 1.h,
                                  color: Colors.black,
                                )),
                          ),
                         const Text('Veteriner Misin?'),
                          Padding(
                            padding: EdgeInsets.only(left: 15.w, right: 15.w),
                            child: Container(
                                height: 1,
                                decoration:const BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                      Colors.black,
                                      Colors.white,
                                    ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight)),
                                padding:
                                    EdgeInsets.only(left: 100.w, right: 15.w),
                                child: Divider(
                                  height: 1.h,
                                  color: Colors.black,
                                )),
                          ),
                        ],
                      ),

                      // divider bitti
                      kayitOl(),
                    ],

                    //
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Text companyNameText() {
    return const Text(
      'VetBul',
      style: TextStyle(
        color: Colors.black,
        fontSize: 40,
      ),
    );
  }

  Container logo() {
    return  Container(
      height: 70.h,
      width: 70.w,
      decoration:const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('lib/assets/vet.png'), fit: BoxFit.fill),
      ),
    );
  }

  Center kayitOl() {
    return Center(
      child: TextButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => RegisterPage()));
          },
          child:const Text(
            ' Kayıt Ol',
            style: TextStyle(color: Colors.blue, fontSize: 15),
          )),
    );
  }

  Row socialGiris() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.white,
          )),
          child: IconButton(
            onPressed: () {
              _authenticateWithGoogle(context);
            },
            icon: Image.asset('lib/assets/google.png'),
            color: Colors.orange,
            iconSize: 15,
          ),
        ),
      const  SizedBox(
          width: 10,
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.white)),
          child: IconButton(
            onPressed: () {},
            icon: Image.asset('lib/assets/facebook.png'),
            color: Colors.orange,
            iconSize: 15,
          ),
        ),
      const  SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Container girisYap() {
    return Container(
      height: 60.h,
      width: 320.w,
      decoration: BoxDecoration(
        color:const Color(0xFFF36969),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: () {
          _authenticateWithEmailAndPassword(context);
        },
        child:const Text(
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
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SifremiUnuttumPage(),
              ));
        },
        child:const Text(
          'Şifremi Unuttum',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Padding sifreText() {
    return Padding(
      padding: const EdgeInsets.only(left: 45, right: 45, top: 20),
      child: TextFormField(
        controller: passwordController,
        cursorColor: Colors.grey,
        keyboardType: TextInputType.text,
        autovalidateMode: AutovalidateMode.disabled,
        validator: (value) {
                                    return value != null && value.length < 6
                                        ? "Minimun 6 karakter"
                                        : null;
                                  },
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
            labelStyle:const TextStyle(color: Colors.grey),
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
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          return value != null && !EmailValidator.validate(value)
              ? 'Doğru bir mail adresi giriniz'
              : null;
        },
        controller: mailController,
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

  void _authenticateWithEmailAndPassword(context) {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(
            email: mailController.text, password: passwordController.text),
      );
    }
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }
}
