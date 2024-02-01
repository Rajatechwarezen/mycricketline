import 'package:flutter/material.dart';
import 'package:sprotbuzz/core/utilis/style.dart';


class ExtraSmallText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextStyle textStyle;
   ExtraSmallText({
    Key? key,
    required this.text,
    this.textAlign,
    this.textStyle = interLightExtraSmall
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
