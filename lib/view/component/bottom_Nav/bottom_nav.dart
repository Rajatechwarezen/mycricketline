
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprotbuzz/core/utilis/dimansion.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/core/utilis/my_strings.dart';
import 'package:sprotbuzz/core/utilis/style.dart';
import 'package:sprotbuzz/data/controller/language_controller.dart';
import 'package:sprotbuzz/data/controller/theme_controller.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import '../../../core/routes/routes.dart';
import '../../../core/utilis/my_images.dart';


class CustomBottomNav extends StatefulWidget {
  final int currentIndex;
  const CustomBottomNav({Key? key,required this.currentIndex}) : super(key: key);

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {

  var bottomNavIndex = 0;//default index of a first screen


  List<String> iconList = [
    MyImages.home,
    MyImages.planIcon,
    MyImages.history1,
        MyImages.planIcon,
    MyImages.menu
  ];

  final textList = [
    MyStrings.hhome.tr,
    MyStrings.hshort.tr,
    MyStrings.hmatches.tr,
        MyStrings.hpolls.tr,
    MyStrings.hmore
  ];

  @override
  void initState() {
    bottomNavIndex = widget.currentIndex;
    Get.put(ThemeController(sharedPreferences: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (theme){
      return GetBuilder<LocalizationController>(builder: (languageController)=>AnimatedBottomNavigationBar.builder(
        height: 65,
        elevation: 10,
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconList[index],
                height: 22, width: 22,
                color: isActive ? MyColor.getSelectedIconColor() : MyColor.getUnselectedIconColor(),
              ),
              const SizedBox(height: Dimensions.space5),
              Text(
                textList[index].tr,
                style: interRegularSmall.copyWith(color: isActive ? MyColor.getSelectedIconColor() : MyColor.getUnselectedIconColor()),
              )
            ],
          );
        },
        backgroundColor: MyColor.getBottomNavColor(),
        splashColor: MyColor.getScreenBgColor(),
        gapLocation: GapLocation.none,
        leftCornerRadius: 0,
        rightCornerRadius: 0,
        onTap: (index) {
          _onTap(index);
        },
        activeIndex: bottomNavIndex,
      ));
    });
  }


  void _onTap(int index) {

    if (index == 0) {
      if (!(widget.currentIndex == 0)) {
        Get.toNamed(RouteHelper.homeScreen);
      }
    }

    else if (index == 1) {
      if (!(widget.currentIndex == 2)) {
         Get.toNamed(RouteHelper.shortPageScreen);
      }
    }

    else if (index == 2) {
      if (!(widget.currentIndex == 3)) {
    Get.toNamed(RouteHelper.allMatchesScreen);
      }
    }
    else if (index == 3) {
      if (!(widget.currentIndex == 4)) {
        Get.toNamed(RouteHelper.poolScreen);
      }
    }
    else if (index == 4) {
      if (!(widget.currentIndex == 5)) {
        Get.toNamed(RouteHelper.menuScreen);
      }
    }

  }
}




  




  


