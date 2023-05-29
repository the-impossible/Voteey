import 'package:flutter/material.dart';
import 'package:voteey/components/delegatedText.dart';
import 'package:voteey/utils/constant.dart';

class DelegatedAppBar extends StatelessWidget {
  const DelegatedAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/comlogo.png",
            width: 50,
            height: 40,
          ),
          const SizedBox(width: 5),
          DelegatedText(
            text: "Voteey",
            fontSize: 28,
            fontName: "InterBold",
            color: Constants.primaryColor,
          ),
          const Spacer(),
          Image.asset(
            "assets/comlogo.png",
            width: 50,
            height: 40,
          ),
        ],
      ),
    );
  }
}