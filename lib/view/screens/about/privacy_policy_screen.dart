import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

import '../../../core/utilis/animated_widget/expanded_widget.dart';
import '../../../core/utilis/dimansion.dart';
import '../../../core/utilis/my_color.dart';
import '../../../core/utilis/my_strings.dart';
import '../../../core/utilis/style.dart';
import '../../../data/controller/privacy/privacy_controller.dart';
import '../../../data/repo/privacy_repo/privacy_repo.dart';
import '../../../data/servies/api_service.dart';
import '../../component/appbar/custom_appbar.dart';
import '../../component/buttons/category_button.dart';
import '../../component/custom_loader/custom_loader.dart';
import '../../component/html/htmlComp.dart';


class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(PrivacyRepo(apiClient: Get.find()));
    final controller = Get.put(PrivacyController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        backgroundColor: MyColor.getScreenBgColor(),
        appBar: CustomAppBar(
          title: MyStrings.policies.tr,
          bgColor: MyColor.getAppbarBgColor(),
          isShowActionBtn: false,
        ),
        body: GetBuilder<PrivacyController>(
          builder: (controller){
             var document = 
      extractTextFromHtml(controller.selectedHtml);
          return   SizedBox(
            width: MediaQuery.of(context).size.width,
            child: controller.isLoading
                ? SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const CustomLoader())
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: Dimensions.space15, right: Dimensions.space15, top: Dimensions.space20),
                  child: SizedBox(
                    height: 30,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          controller.policyList.length,
                              (index) => Row(
                            children: [
                              CategoryButton(
                                  color: controller.selectedIndex == index
                                      ? MyColor.getPrimaryColor()
                                      : MyColor.greenP.withOpacity(0.5),
                                  horizontalPadding: 8,
                                  verticalPadding: 7,
                                  textSize: Dimensions.fontDefault,
                                  text: controller.policyList[index].dataValues?.title ?? '',
                                  press: () {
                                    controller.changeIndex(index);
                                  }),
                              const SizedBox(width: Dimensions.space10)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: Dimensions.space10),
                Expanded(
                    child:  SingleChildScrollView(child:ExpandedSection(
                    expand: true,
                    child:  Container(
                        padding: const EdgeInsets.all(Dimensions.space15),
                        width: double.infinity,
                        child: Text(
                           document.toString(),
                          style: interRegularDefault.copyWith(color: MyColor.getTextColor()),
                           
                        )
                    )
                  )
                ))
              ],
            ),
          );
        }
        )
    );
  }
}
