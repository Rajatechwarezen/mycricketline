import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../../core/utilis/dimansion.dart';
import '../../../../../core/utilis/my_color.dart';
import '../../../../../core/utilis/my_strings.dart';
import '../../../../../data/controller/language_controller.dart';
import '../../../../../data/controller/theme_controller.dart';
import '../../../../../data/controller/trendindList_controller/TrendindList_controller.dart';
import '../../../../component/appbar/custom_appbar.dart';
import '../../../../component/bottom_Nav/bottom_nav.dart';
import '../../../../component/card/card_with_round_icon.dart';

class FullTrendingScreen extends StatelessWidget {
  const FullTrendingScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrendingListController>(builder: (trendindController) {
      return Scaffold(
        backgroundColor: MyColor.getScreenBgColor(),
        appBar: CustomAppBar(
            title: MyStrings.more.tr,
            isShowBackBtn: false,
            isShowActionBtn: false,
            bgColor: MyColor.getAppbarBgColor()),
        body: SingleChildScrollView(
          padding: Dimensions.screenPaddingHV,
          child:  
                  ListView.builder(
          itemCount: trendindController.dataList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (c, i) {
            return   IntrinsicHeight(
              child:     Row(children: [
              Expanded(
                child: CardWithRoundIcon(
                  backgroundColor: MyColor.getCardBg(),
                  titleText: trendindController.dataList[i].series,
                  titleColor: MyColor.getTextColor(),
                  trailColor: MyColor.getPrimaryColor(),
                  trailText:  trendindController.dataList[i].seriesDate,
                  icon:  trendindController.dataList[i].image,
                  onPressed: () {},
                ),
              ),
            ]),
           
          
              
               );
          })
        
          
          ),
       
      );
    });
  }

}