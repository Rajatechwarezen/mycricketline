import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/core/utilis/my_strings.dart';
import 'package:sprotbuzz/core/utilis/style.dart';
import 'package:sprotbuzz/view/component/html/htmlComp.dart';
import 'package:sprotbuzz/view/component/text/small_text.dart';

import '../../../../../core/utilis/borderbox.dart';
import '../../../../../core/utilis/boxSpace.dart';
import '../../../../../core/utilis/dimansion.dart';
import '../../screens/home/home_page_componet/carousel/widget/Widget.dart';

class NewsCard extends StatelessWidget {
  const NewsCard(
      {Key? key,
      required this.newTitle,
      required this.dateTime,
      required this.status,
      required this.img,
      this.height = 150})
      : super(key: key);

  final String newTitle;
  final String dateTime;
  final String status;

  final double? height;
  final String? img;
  @override
  Widget build(BuildContext context) {
    var document =  extractTextFromHtml(newTitle);
    return Container(
      height: height! * 1.8,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.space10, horizontal: Dimensions.space15),
      decoration: BoxDecoration(
          color: MyColor.getCardBg(), borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            alignment: Alignment.center,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: boRadiusAll,
              image: DecorationImage(
                image: NetworkImage(
                  img!,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          size10h,
          Text(
            truncateText(document.toString(), 100),
            style: interSemiBoldDefault.copyWith(color: MyColor.getTextColor()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmallText(
                  text: status,
                  textStyle: interRegularExtraSmall.copyWith(
                      color: MyColor.getTextColor1(),
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: Dimensions.space5),
              SmallText(
                  text: dateTime,
                  textStyle: interRegularExtraSmall.copyWith(
                      color: MyColor.getTextColor()))
            ],
          ),
          const SizedBox(height: Dimensions.space5)
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////
class NewsCardRow extends StatelessWidget {
  const NewsCardRow(
      {Key? key,
      required this.newTitle,
      required this.dateTime,
      required this.status,
      required this.img,
      this.height = 150})
      : super(key: key);

  final String newTitle;
  final String dateTime;
  final String status;

  final double? height;
  final String? img;
  @override
  Widget build(BuildContext context) {
    var document = extractTextFromHtml(newTitle); 
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.space10, horizontal: Dimensions.space15),
      decoration: BoxDecoration(
          color: MyColor.getCardBg(), borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: boRadiusAll,
              image: DecorationImage(
                image: NetworkImage(
                  img!,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          size10w,
          SizedBox(
            width: 219,
            child: Column(
              children: [
                Text(
                  "$document",
                  style: interSemiBoldSmall.copyWith(
                    color: MyColor.getTextColor(),
                  ),
                ),
                size10h,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallText(
                        text: status,
                        textStyle: interRegularExtraSmall.copyWith(
                            color: MyColor.getTextColor1(),
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: Dimensions.space5),
                    SmallText(
                        text: dateTime,
                        textStyle: interRegularExtraSmall.copyWith(
                            color: MyColor.getTextColor()))
                  ],
                ),
              ],
            ),
          ),
          size10h,
          const SizedBox(width: Dimensions.space5)
        ],
      ),
    );
  }
}
