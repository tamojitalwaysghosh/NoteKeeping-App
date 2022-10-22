import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:noter/page/note_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedSplashScreen(
      splashIconSize: 1000,
      splash: Image.asset('assets/images/sp.png'),
      duration: 1010,

      nextScreen: NotesPage(),
      //backgroundColor: Colors.black,
      splashTransition: SplashTransition.fadeTransition,
    ));
  }
}
