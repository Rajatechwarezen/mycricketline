import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprotbuzz/core/utilis/boxSpace.dart';
import 'package:sprotbuzz/core/utilis/globlemargin.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/core/utilis/my_strings.dart';
import 'package:sprotbuzz/data/servies/api_service.dart';
import 'package:sprotbuzz/view/component/popup/will_popup.dart';
import 'package:sprotbuzz/view/component/row_item/header_row.dart';
import 'package:sprotbuzz/view/screens/Blog/Blog.dart';
import 'package:sprotbuzz/view/screens/home/home_page_componet/carousel/carousel_Cricket.dart';
import 'package:sprotbuzz/view/screens/home/home_page_componet/new/new_list.dart';

import '../../../core/routes/routes.dart';
import 'home_page_componet/treading/treading_Serices.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: '',
      child: SafeArea(
          child: Scaffold(
        backgroundColor: MyColor.getScreenBgColor(),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
             //ScreenCarousel =================================================

              size10h,
              HomeScreenCarousel(),

              //Trending =================================================
              Container(
                padding: GlobleglobleMargin.globleMargin,
                child: Column(children: [
                  size10h,
                  HeaderRow(
                    heading: MyStrings.trseries,
                    isShowMoreVisible: true,
                    onShowMorePress: () {
                      Get.toNamed(RouteHelper.fullTrendingScreen);
                    },
                  ),
                  const HomePageTrendindList(),
                  size10h,

                  //Best news =================================================

                  // HeaderRow(
                  //   heading: MyStrings.bestnews,
                  //   isShowMoreVisible: true,
                  //   onShowMorePress: () {
                  //     // print("click ");
                  //   },
                  // ),
                  // size10h,
                  // const PlanCard(
                  //   auther:" sunil",
                  //   dateTime: "3:44:45 2023",
                  //   img: MyImages.accountBold,
                  //   content: "best news forever ",
                  //   newTitle: 'dfd News is best way to undertend ',
                  // ),
                  // size10h,

                    //Blogs  =================================================


                  HeaderRow(
                    heading: MyStrings.blog.tr,
                    isShowMoreVisible: true,
                    onShowMorePress: () {
                      // print("click ");
                    },
                  ),
                   BlogsPage(),
                 
                 
                 
                  size10h,
                  HeaderRow(
                    heading: MyStrings.latnews,
                    isShowMoreVisible: true,
                    onShowMorePress: () {
                      // print("click ");
                    },
                  ),

                  HomeScreenNews()
                ]),
              )
            ],
          ),
        ),
      )),
    );
  }
}

