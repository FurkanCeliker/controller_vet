import 'package:controller_vet/bloc/auth_bloc.dart';
import 'package:controller_vet/pages/hosgeldin_page.dart';
import 'package:controller_vet/pages/listview_vet.dart';
import 'package:controller_vet/pages/login_page.dart';
import 'package:controller_vet/pages/register_page.dart';
import 'package:controller_vet/pages/vet_detail.dart';
import 'package:controller_vet/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';

void main() async {
  // landscape mod kapatıldı

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool ac = true;
    return ScreenUtilInit(
        designSize: Size(412, 732),
        builder: () => RepositoryProvider(
              create: (context) => AuthRepository(),
              child: BlocProvider(
                create: (context) => AuthBloc(authRepository: RepositoryProvider.of(context)),
                child: MaterialApp(
                  title: 'Material App',
                  home:StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                // If the snapshot has user data, then they're already signed in. So Navigating to the Dashboard.
                if (snapshot.hasData) {
                  return const HosgeldinPage();
                }
                // Otherwise, they're not signed in. Show the sign in page.
                return LoginPage();
              }),
                  theme: ThemeData.light().copyWith(
                    textTheme: GoogleFonts.cantoraOneTextTheme(),
                  ),
                  debugShowCheckedModeBanner: false,
                ),
              ),
            ));
  }
}
