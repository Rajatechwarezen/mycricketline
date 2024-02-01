import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:sprotbuzz/view/component/circle_image/circle_image_button.dart';

import '../../../../core/utilis/boxSpace.dart';
import '../../../../core/utilis/my_color.dart';
import '../../../../core/utilis/style.dart';
import 'package:flutter/material.dart';
import 'package:sprotbuzz/core/utilis/my_images.dart';
import 'package:sprotbuzz/view/component/text/small_text.dart';

/////////////////////////////////////
scoreShow(
    {teamAOver,
    teamBOver,
    teamBScore,
    teamAScore,
    teamAImg,
    teamBImg,
    teamName,
    teamName2,
    teamScore,
    teamScore2,
    teamOver,
    teamOver2,
    teamType,
    matchTime,
    matchType}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleImageWidget(
              height: 40.0,
              width: 40.0,
              imagePath: teamAImg.toString(),
              isAsset: false),
          size10w,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(teamName.toString(),
                  style: interRegularExtraSmall.copyWith(
                      color: MyColor.getTextColor())),
              matchType == "Test"
                  ? Column(
                      children: [
                        SmallText(
                          text: "$teamAScore",
                          textStyle: interRegularExtraSmall.copyWith(
                              color: MyColor.getTextColor()),
                        ),
                        SmallText(
                          text: "$teamAOver  (Over)",
                          textStyle: interRegularExtraSmall.copyWith(
                              color: MyColor.getTextColor()),
                        ),
                      ],
                    )
                  : SmallText(
                      text: "$teamScore-${teamOver.toString()}",
                      textStyle: interRegularExtraSmall.copyWith(
                          color: MyColor.getTextColor())),
            ],
          ),
        ],
      ),
      CircleImageWidget(
          height: 20.0,
          width: 20.0,
          imagePath: MyImages.vs.toString(),
          isAsset: true),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SmallText(
                  text: teamName2.toString(),
                  textStyle: interRegularExtraSmall.copyWith(
                      color: MyColor.getTextColor())),
              matchType == "Test"
                  ? Column(
                      children: [
                        SmallText(
                            text: "$teamBScore",
                            textStyle: interRegularExtraSmall.copyWith(
                                color: MyColor.getTextColor())),
                        SmallText(
                            text: "$teamBOver (Over)",
                            textStyle: interRegularExtraSmall.copyWith(
                                color: MyColor.getTextColor())),
                      ],
                    )
                  : SmallText(
                      text: "$teamScore2/${teamOver2.toString()}",
                      textStyle: interRegularExtraSmall.copyWith(
                          color: MyColor.getTextColor())),
            ],
          ),
          size10w,
          CircleImageWidget(
              height: 40.0,
              width: 40.0,
              imagePath: teamBImg.toString(),
              isAsset: false),
        ],
      ),
    ],
  );
}
