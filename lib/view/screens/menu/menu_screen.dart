import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sprotbuzz/core/routes/routes.dart';
import 'package:sprotbuzz/core/utilis/dimansion.dart';
import 'package:sprotbuzz/core/utilis/my_images.dart';
import 'package:sprotbuzz/core/utilis/my_strings.dart';
import 'package:sprotbuzz/core/utilis/utilis.dart';
import 'package:sprotbuzz/data/controller/language_controller.dart';
import 'package:sprotbuzz/data/controller/theme_controller.dart';
import 'package:sprotbuzz/data/servies/api_service.dart';
import 'package:sprotbuzz/view/component/appbar/custom_appbar.dart';
import 'package:sprotbuzz/view/component/bottom-sheet/custom_bottom_sheet.dart';
import 'package:sprotbuzz/view/component/bottom_Nav/bottom_nav.dart';
import 'package:sprotbuzz/view/screens/menu/MenuRowWidget.dart';

import '../../../core/utilis/my_color.dart';
import '../../../core/utilis/style.dart';
import '../../component/bottom-sheet/language_sheet.dart';
import '../../component/divider/custom_divider.dart';
import '../../component/switch_button/custom_switch_button.dart';
import '../../component/text/default_text.dart';
import '../../component/text/header_text.dart';
import 'vsit_links/shrear_links/shear_links.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));

    ThemeController themeController =
        Get.put(ThemeController(sharedPreferences: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    MyUtils.allScreensUtils(themeController.darkTheme);
    super.initState();
  }

  @override
  void dispose() {
    ThemeController themeController =
        Get.put(ThemeController(sharedPreferences: Get.find()));
    MyUtils.allScreensUtils(themeController.darkTheme);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (theme) {
      return GetBuilder<LocalizationController>(
          builder: (localizationController) {
        return Scaffold(
          backgroundColor: MyColor.getScreenBgColor(),
          appBar: CustomAppBar(
              title: MyStrings.more.tr,
              isShowBackBtn: false,
              isShowActionBtn: false,
              bgColor: MyColor.getAppbarBgColor()),
          body: SingleChildScrollView(
            padding: Dimensions.screenPaddingHV,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(Dimensions.space15),
                  decoration: BoxDecoration(
                      color: MyColor.getCardBg(),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultText(
                          text: MyStrings.browserCricket,
                          textStyle: interRegularDefault.copyWith(
                              color: MyColor.mycolorGrey)),
                      const SizedBox(height: Dimensions.space15),
                      MenuRowWidget(
                        iconData: Icons.abc,
                        label: MyStrings.browserS.tr,
                        onPressed: () {
                          //  Get.toNamed(RouteHelper.referralScreen);
                        },
                      ),
                      Visibility(
                          visible: true,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomDivider(space: Dimensions.space15),
                              MenuRowWidget(
                                iconData: Icons.money,
                                label: MyStrings.premium,
                                onPressed: () {},
                              ),
                            ],
                          )),
                      const CustomDivider(space: Dimensions.space15),
                      MenuRowWidget(
                        label: MyStrings.latestStories.tr,
                        onPressed: () {},
                        iconData: Icons.wallet,
                      ),
                      const CustomDivider(space: Dimensions.space15),
                      MenuRowWidget(
                        label: MyStrings.rateus.tr,
                        onPressed: () {},
                        iconData: Icons.widgets,
                      ),
                      const CustomDivider(space: Dimensions.space15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(MyImages.theme,
                                  color: MyColor.getSelectedIconColor(),
                                  height: 20,
                                  width: 20),
                              const SizedBox(width: Dimensions.space15),
                              DefaultText(
                                  text: MyStrings.theme.tr,
                                  textColor: MyColor.getTextColor())
                            ],
                          ),
                          CustomSwitch(
                            value: theme.darkTheme,
                            onChanged: (bool val) {
                              theme.toggleTheme();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Dimensions.space15),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(Dimensions.space15),
                  decoration: BoxDecoration(
                      color: MyColor.getCardBg(),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultText(
                          text: MyStrings.settingAndApp,
                          textStyle: interRegularDefault.copyWith(
                              color: MyColor.mycolorGrey)),
                      const SizedBox(height: Dimensions.space15),
                      Visibility(
                          visible: true,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MenuRowWidget(
                                iconData: Icons.language,
                                label: MyStrings.languagestype,
                                onPressed: () {
                                  CustomBottomSheet(
                                    isNeedMargin: true,
                                    backgroundColor: MyColor.getCardBg(),
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      child: SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        child:
                                            GetBuilder<LocalizationController>(
                                          builder: (localizationController) {
                                            return Column(
                                              // mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                HeaderText(
                                                    text:
                                                        MyStrings.languagestype,
                                                    textStyle: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                ListView.builder(
                                                    itemCount: 2,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, index) =>
                                                            LanguageWidget(
                                                              languageModel:
                                                                  localizationController
                                                                          .languages[
                                                                      index],
                                                              localizationController:
                                                                  localizationController,
                                                              index: index,
                                                            )),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ).customBottomSheet(context);
                                },
                              ),
                              const CustomDivider(space: Dimensions.space15),
                            ],
                          )),
                      MenuRowWidget(
                        iconData: Icons.link_outlined,
                        label: MyStrings.referral.tr,
                        onPressed: () {
                          Get.toNamed(RouteHelper.referralScreen);
                        },
                      ),
                      const CustomDivider(space: Dimensions.space15),
                      MenuRowWidget(
                        iconData: Icons.privacy_tip,
                        label: MyStrings.termsAndPrivacy.tr,
                        onPressed: () {
                          Get.toNamed(RouteHelper.privacyScreen);
                        },
                      ),
                      const CustomDivider(space: Dimensions.space15),
                      MenuRowWidget(
                        iconData: Icons.abc_outlined,
                        label: MyStrings.faq.tr,
                        onPressed: () {
                          Get.toNamed(RouteHelper.faqScreen);
                        },
                      ),
                      const CustomDivider(space: Dimensions.space15),
                      MenuRowWidget(
                        iconData: Icons.logout,
                        label: MyStrings.signOut.tr,
                        onPressed: () {
                          // Get.put(ApiClient(sharedPreferences: Get.find()));
                          // Get.put(LoginRepo(apiClient: Get.find()));
                          // final controller = Get.put(LoginController(loginRepo: Get.find()));

                          // controller.loginRepo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
                          // controller.loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey, "");

                          // CustomSnackBar.showCustomSnackBar(errorList: [], msg: [MyStrings.logoutSuccessMsg], isError: false);
                          // Get.offAllNamed(RouteHelper.loginScreen);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Dimensions.space15),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(Dimensions.space15),
                  decoration: BoxDecoration(
                      color: MyColor.getCardBg(),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultText(
                          text: MyStrings.sheare.tr,
                          textStyle: interRegularDefault.copyWith(
                              color: MyColor.mycolorGrey)),
                      const SizedBox(height: Dimensions.space15),

                      MenuRowWidget(
                        iconData: Icons.link_outlined,
                        label: MyStrings.tb5fbook.tr,
                        onPressed: () {
                          launchFacebookPage();
                        },
                      ),
                      const CustomDivider(space: Dimensions.space15),

                      MenuRowWidget(
                        iconData: Icons.share_rounded,
                        label: MyStrings.tb5igram.tr,
                        onPressed: () {
                          launchInstagramProfile();
                        },
                      ),
                      //////////////////////////////////
                      const CustomDivider(space: Dimensions.space15),
                      MenuRowWidget(
                        iconData: Icons.face,
                        label: MyStrings.rateus.tr,
                        onPressed: () {
                          launchRateAppURL();
                        },
                      ),
                      const CustomDivider(space: Dimensions.space15),
                      MenuRowWidget(
                        iconData: Icons.shape_line,
                        label: MyStrings.invitefrieds.tr,
                        onPressed: () {
                          String referralLink =
                              'https://example.com/referral?code=your_unique_code';
                          shareReferralLink(referralLink);
                        },
                      ),

                      const CustomDivider(space: Dimensions.space15),

                      MenuRowWidget(
                        iconData: Icons.update,
                        label: MyStrings.tb5chfupd.tr,
                        onPressed: () {
                          launchRateAppURLUpdate();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: const CustomBottomNav(currentIndex: 4),
        );
      });
    });
  }
}
