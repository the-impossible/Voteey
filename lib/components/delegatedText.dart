import 'package:flutter/material.dart';
import 'package:voteey/utils/constant.dart';

class DelegatedText extends StatelessWidget {
  final String text;
  final double fontSize;
  String? fontName = 'InterBold';
  Color? color = Constants.tertiaryColor;
  TextAlign? align;

  DelegatedText({
    required this.text,
    required this.fontSize,
    this.fontName,
    this.color,
    this.align,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        letterSpacing: 1,
        fontFamily: fontName,
      ),
      textAlign: align,
      overflow: TextOverflow.ellipsis,
    );
  }
}
