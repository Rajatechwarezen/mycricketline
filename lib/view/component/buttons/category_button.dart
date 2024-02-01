import 'package:flutter/material.dart';

import '../../../core/utilis/dimansion.dart';
import '../../../core/utilis/my_color.dart';
import '../../../core/utilis/style.dart';

class CategoryButton extends StatelessWidget {

  final String text;
  final VoidCallback press;
  final Color color, textColor;
  final double horizontalPadding;
  final double verticalPadding;
  final double textSize;

  const CategoryButton({
    Key? key,
    required this.text,
    this.horizontalPadding=3,
    this.verticalPadding=3,
    this.textSize=Dimensions.fontExtraSmall,
    required this.press,
    this.color = MyColor.myprimaryColor,
    this.textColor = Colors.white,
  }):super(key: key) ;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(4),
      child:  Container(
        alignment: Alignment.center,
        padding:  EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: MyColor.getScreenBgColor().withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0,0),
            ),
          ]
        ),
        child: Text(
          text,
          style: interSemiBoldDefault.copyWith(color: textColor),
        ),
      ),
    );
  }



}