import 'package:flutter/material.dart';

import '../../../core/utilis/my_color.dart';
class ShapeIcon extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final String? icon;
final double? height;
  final double? width ;

   const ShapeIcon({
    Key? key,
    this.backgroundColor = MyColor.mytransparentColor,
    this.borderColor = MyColor.myprimaryColor,
    this.iconColor = MyColor.mycolorWhite,

    this.height  = 30.00,
     this.width  = 30.00,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.rectangle,

      ),
      child: Image.asset(icon.toString(), color: iconColor, height:  height  , width:width,fit: BoxFit.fill, ),
    );
  }
}
