import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:voteey/components/delegatedText.dart';
import 'package:voteey/utils/constant.dart';
import 'package:voteey/views/wrapper.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedSplashScreen(
        splashIconSize: 300,
        centered: true,
        duration: 1000,
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.fade,
        animationDuration: const Duration(
          seconds: 1,
        ),
        nextScreen: const Wrapper(),
        backgroundColor: Constants.primaryColor,
        splash: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/logo.png",
                width: 200,
                height: 150,
              ),
              const SizedBox(height: 20),
              DelegatedText(
                text: 'Voteey',
                fontSize: 40,
                fontName: 'InterBold',
                color: Constants.basicColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
