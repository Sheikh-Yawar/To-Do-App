import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_app/pages/home_page.dart';
import 'package:to_do_app/utils/pallete.dart';

class IntroAnimation extends StatefulWidget {
  const IntroAnimation({Key? key}) : super(key: key);

  @override
  State<IntroAnimation> createState() => _IntroAnimationState();
}

class _IntroAnimationState extends State<IntroAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _lottieController;
  late Image myImage;
  late final screenHeight;
  @override
  void initState() {
    _lottieController = AnimationController(vsync: this);
    myImage = Image.asset(
      "assets/images/todo.jpg",
      fit: BoxFit.contain,
    );
    super.initState();
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    screenHeight = MediaQuery.of(context).size.height;
    precacheImage(myImage.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                " Liste à Faire",
                style: GoogleFonts.montserrat(
                  fontSize: 60,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w900,
                  color: Palette.kToDark,
                ),
              ),
            ),
          ),
          Lottie.asset(
            "assets/images/introAnimation.json",
            controller: _lottieController,
            onLoaded: (composition) {
              _lottieController
                ..duration = composition.duration
                ..forward().whenComplete(
                  () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            HomePage(myImage: myImage),
                      ),
                    );
                  },
                );
            },
          ),
          const Text(
            "A Basic To-Do App",
            style: TextStyle(
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}
