import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/pages/home_page.dart';
import 'package:to_do_app/pages/intro_animation.dart';
import 'package:to_do_app/pages/main_page.dart';
import 'package:to_do_app/utils/pallete.dart';
import 'package:to_do_app/utils/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late Image myImage;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Palette.kToDark,
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const IntroAnimation(),
        "/homePage": (context) => HomePage(myImage: myImage),
        "/mainPage": (context) => const MainPage(),
      },
    );
  }
}
