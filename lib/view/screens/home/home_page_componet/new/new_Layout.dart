import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:html/parser.dart';
import 'package:sprotbuzz/core/utilis/boxSpace.dart';
import 'package:sprotbuzz/core/utilis/my_strings.dart';
import 'package:sprotbuzz/view/component/appbar/custom_appbar.dart';

import 'package:readmore/readmore.dart';

import '../../../../../core/utilis/borderbox.dart';
import '../../../../../core/utilis/dimansion.dart';
import '../../../../../core/utilis/globlemargin.dart';
import '../../../../../core/utilis/my_color.dart';
import '../../../../../core/utilis/style.dart';
import '../../../../component/divider/custom_divider.dart';
import '../../../../component/html/htmlComp.dart';
import '../../../../component/text/small_text.dart';

class NewsLaouts extends StatelessWidget {
  var newsData;
  bool skyNews = true;
  NewsLaouts({super.key, required this.newsData, required this.skyNews});

  @override
  Widget build(BuildContext context) {
    var document = extractTextFromHtml(newsData.toString());
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: MyStrings.latnews),
        body: Container(
            margin: GlobleglobleMargin.globleMargin,
            child: skyNews
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                        document,
                          style: interSemiBoldDefault.copyWith(
                              color: MyColor.getTextColor()),
                        ),
                      ],
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.space10,
                        horizontal: Dimensions.space15),
                    decoration: BoxDecoration(
                        color: MyColor.getCardBg(),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          width: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                'http://cricapi.mycricketline.com/uploads/blogimg/${newsData.blImg}',
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SmallText(
                                  text: newsData.blTitle,
                                  textStyle: interRegularExtraLarge.copyWith(
                                      color: MyColor.getTextColor1(),
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                        const CustomDivider(),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SmallText(
                                  text: "Published: ${newsData.createdOn}",
                                  textStyle: interRegularExtraSmall.copyWith(
                                      color: MyColor.getTextColor1(),
                                      fontWeight: FontWeight.w600)),
                              size10h,
                              SmallText(
                                  text: "Content:",
                                  textStyle: interRegularExtraSmall.copyWith(
                                      color: MyColor.getTextColor1(),
                                      fontWeight: FontWeight.w600)),
                              size10h,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ReadMoreText(
                                    '${newsData.blDesc}',
                                    trimLines: 2,
                                    style: interRegularExtraSmall.copyWith(
                                        color: MyColor.getTextColor(),
                                        fontWeight: FontWeight.w600),
                                    colorClickableText: Colors.pink,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: 'Show less',
                                    moreStyle: interBoldDefault.copyWith(
                                        color: MyColor.getTextColor()),
                                  )
                                ],
                              ),
                              const SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
      ),
    );
  }
}
