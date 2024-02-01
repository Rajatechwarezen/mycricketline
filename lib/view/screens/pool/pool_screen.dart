
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:sprotbuzz/core/utilis/borderbox.dart';
import 'package:sprotbuzz/core/utilis/boxSpace.dart';
import 'package:sprotbuzz/view/component/text/small_text.dart';

import '../../../core/utilis/dimansion.dart';
import '../../../core/utilis/my_color.dart';
import '../../../core/utilis/my_strings.dart';
import '../../component/appbar/custom_appbar.dart';
import '../../component/bottom_Nav/bottom_nav.dart';
import '../../component/circle_image/circle_image_button.dart';
import '../../component/custom_loader/custom_loader.dart';

class PoolScreen extends StatefulWidget {
  const PoolScreen({Key? key}) : super(key: key);

  @override
  State<PoolScreen> createState() => _PoolScreenState();
}

class _PoolScreenState extends State<PoolScreen> {
  int selectedIdx = -1; // -1 indicates no selection

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return 
  Scaffold(
      backgroundColor: MyColor.getScreenBgColor(),
      body: SingleChildScrollView(
        padding: Dimensions.screenPaddingHV,
        physics: const BouncingScrollPhysics(),
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 1, //"controller.faqList.length"
          separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(top: 10),
              
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: MyColor.getCardBg(),
                border: border,
                borderRadius: boRadiusAll,
            
              ),
              child: Column(
                children: [
                  SmallText(
                    text: "Who will win?",
                    textStyle: TextStyle(fontSize: 20, color: MyColor.getTextColor()),
                  ),
                  size20h,
                  Column(
                    children: [
                      buildSelectableContainer(index, " Hi this is a match of India or Pakistan"),
                      size20h,
                      buildSelectableContainer(index + 1, " Hi this is another match description"),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
          bottomNavigationBar: const CustomBottomNav(currentIndex: 3),
    );  }


    
  Widget buildSelectableContainer(int index, String text) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedIdx = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        alignment: Alignment.topLeft,
          width: 400,
        decoration: BoxDecoration(
          color: selectedIdx == index ? MyColor.greenP.withOpacity(0.1) : MyColor.getCardBg(),
          border: border,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            const CircleImageWidget(
              height: 40.0,
              width: 40.0,
              imagePath: 'assets/toss.png',
              isAsset: true,
            ),
            size10w,
            SmallText(text: text),
          ],
        ),
      ),
    );
  }

}
