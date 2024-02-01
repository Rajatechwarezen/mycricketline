import 'package:flutter/material.dart';
import 'package:sprotbuzz/core/utilis/borderbox.dart';
import 'package:sprotbuzz/core/utilis/dimansion.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/core/utilis/style.dart';
import 'package:sprotbuzz/view/component/text/small_text.dart';

import '../../../core/utilis/my_images.dart';

class CardWithRoundIcon extends StatelessWidget {

  final VoidCallback? onPressed;
  final String icon;
  final String titleText;
  final String trailText;
  final Color? backgroundColor;
  final Color titleColor;
  final Color trailColor;

  const CardWithRoundIcon({
    Key? key,
    this.onPressed,
    required this.titleText,
    required this.trailText,
    required this.icon,
    this.backgroundColor,
    this.titleColor = MyColor.mycolorWhite,
    this.trailColor = MyColor.myprimaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
        decoration: BoxDecoration(
            color: backgroundColor,
            
            borderRadius: BorderRadius.circular(15),
            border:border
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 40, width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: MyColor.mycolorGrey.withOpacity(0.1),
                  shape: BoxShape.rectangle),
                child: 
                
                    FadeInImage.assetNetwork(
          image: icon,
          fit: BoxFit.cover,
          width: 38,
          height: 38,
          imageErrorBuilder: (ctx,object,trx){
            return Image.asset(
                 MyImages.placeHolderImage,
              fit: BoxFit.cover,
              width: 38,
              height: 38,
            );
          }, placeholder: MyImages.placeHolderImage,
        ),
 
                
               
            ),
            const SizedBox(width: 20),
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              titleText,
              style:interBoldDefault .copyWith(color: MyColor.getTextColor()),
            ),
            const SizedBox(height: Dimensions.space5),
                 SmallText(text:trailText, textStyle: interRegularSmall.copyWith(color: MyColor.getTextColor().withOpacity(.6)))
                 
         ],)
          ],
        ),
      ),
    );
  }
}
