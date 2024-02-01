import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprotbuzz/core/utilis/dimansion.dart';
import 'package:sprotbuzz/core/utilis/style.dart';


class DefaultText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextStyle textStyle;
  final int maxLines;
  final Color? textColor;
  final double fontSize;

   DefaultText({
    Key? key,
    required this.text,
    this.textAlign,
    this.textStyle = interRegularDefault,
    this.maxLines = 3,
    this.textColor,
    this.fontSize = Dimensions.fontDefault
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: textStyle.copyWith(color: textColor,fontSize: fontSize),
      maxLines: maxLines,
    );
  }
}