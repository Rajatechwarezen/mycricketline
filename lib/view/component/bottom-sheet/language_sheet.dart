import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sprotbuzz/core/utilis/my_strings.dart';
import 'package:sprotbuzz/data/controller/language_controller.dart';
import 'package:sprotbuzz/data/model/language_models.dart';
import 'package:sprotbuzz/view/component/text/header_text.dart';

import '../../../core/utilis/my_color.dart';
import '../../../core/utilis/style.dart';



class   LangBottomSheet {
  static Future<dynamic> buildBottomSheet(BuildContext context) {
    return Get.bottomSheet(
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),),
      Container(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: GetBuilder<LocalizationController>(builder: (localizationController)
          {
            return Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('select', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 15,
                ),
                ListView.builder(
                    itemCount:  localizationController.languages.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        LanguageWidget(
                          languageModel: localizationController.languages[index],
                          localizationController: localizationController, index: index,
                        )
                ),
              ],
            );
            },
          ),
        ),
      ),
    );
  }
}



class LanguageWidget extends StatelessWidget {
final LanguageModel languageModel;
final LocalizationController localizationController;
final int index;
LanguageWidget({required this.languageModel, required this.localizationController,
required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        localizationController.setLanguage(Locale(
          MyStrings.languages[index].languageCode,
          MyStrings.languages[index].countryCode,   
        ));
        localizationController.setSelectedIndex(index);
      },
      child: Container(
        padding: const EdgeInsets.all(7),
        child:
            Center(child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    HeaderText(text: languageModel.imageUrl, textStyle: interSemiBoldDefault.copyWith(color: MyColor.getTextColor()),
    ),
                    const SizedBox(width: 8,),
                    HeaderText(text:languageModel.languageName, textStyle: TextStyle(fontSize: 15,
                        color:  localizationController.selectedIndex == index ? MyColor.myprimaryColor : MyColor.mycolorWhite),),
                  ],
                ),
              ],
            ),),


      )
    );
  }
}