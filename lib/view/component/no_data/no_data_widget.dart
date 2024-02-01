import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sprotbuzz/core/utilis/dimansion.dart';
import 'package:sprotbuzz/core/utilis/my_images.dart';
import 'package:sprotbuzz/core/utilis/my_strings.dart';

import '../../../core/utilis/my_color.dart';
import '../../../core/utilis/style.dart';


class NoDataWidget extends StatelessWidget {
  final double topMargin;
  final double bottomMargin;
  final String? title;
  final double imageHeight;
  const NoDataWidget({Key? key,
    this.topMargin = 0,
    this.title ,
    this.imageHeight = 150,
    this.bottomMargin = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            MyImages.noDataImage,
            height: 100,
            width: 100,
            color: MyColor.getPrimaryColor()
          ),
          const SizedBox(height: Dimensions.space20),
          Text(
            title ??  MyStrings.writeSomething,
            textAlign: TextAlign.center,
            style: interRegularDefault.copyWith(color: MyColor.getTextColor().withOpacity(.6), fontSize: Dimensions.fontDefault),
          )
        ],
      ),
    );
  }
}
