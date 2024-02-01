import 'package:flutter/material.dart';
import 'package:sprotbuzz/core/utilis/style.dart';

class SmallText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextStyle textStyle;
  const SmallText({
    Key? key,
    required this.text,
    this.textAlign,
    this.textStyle = interRegularSmall
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      
      textAlign: textAlign,
      style: textStyle,
      overflow: TextOverflow.ellipsis,
    );
  }
}
class SmallTextTowLine extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextStyle textStyle;
  const SmallTextTowLine({
    Key? key,
    required this.text,
    this.textAlign,
    this.textStyle = interRegularSmall
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines:2,
      textAlign: textAlign,
      style: textStyle,
      
      overflow: TextOverflow.ellipsis,
    );
  }
}
