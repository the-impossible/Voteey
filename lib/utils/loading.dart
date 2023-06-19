import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:voteey/utils/constant.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SpinKitFadingCircle(
          color: Constants.primaryColor,
          size: 50.0,
        ),
      ),
    );
  }
}
