import 'package:flutter/material.dart';
import '../../../core/utilis/dimansion.dart';
import '../../../core/utilis/my_color.dart';
import '../../../core/utilis/style.dart';

class RoundedBorderContainer extends StatelessWidget {

  const RoundedBorderContainer({Key? key,
    required this.text,
    this.borderColor= MyColor.myprimaryColor,
    this.bgColor= MyColor.myprimaryColor,
    this.horizontalPadding=12,
    this.verticalPadding=5,
    this.textColor= MyColor.myprimaryColor}) : super(key: key);

  final Color bgColor,textColor,borderColor;
  final double horizontalPadding,verticalPadding;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
        border:Border.all(color: borderColor,width: 1.5)
      ),
      child: Text(
        text,
        style: interBoldDefault.copyWith(color:textColor,fontSize: Dimensions.fontSmall)
      ),
    );
  }
}
