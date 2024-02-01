import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utilis/my_color.dart';
import '../../../core/utilis/my_images.dart';
import '../../../core/utilis/my_strings.dart';
import '../../../core/utilis/utilis.dart';
import '../../../data/controller/theme_controller.dart';
import '../../component/bottom_Nav/bottom_nav.dart';
import '../../component/image/round_shape_icon.dart';
import '../../component/neternet_connection/internet_checker.dart';
import '../../component/popup/will_popup.dart';
import '../../component/tabs/tabs_Custom.dart';
import 'finish/all_FinishData.dart';
import 'upcoming/All_UpcomingData.dart';
class AllMatches extends StatefulWidget {
  const AllMatches({super.key});

  @override
  State<AllMatches> createState() => _AllMatchesState();
}

class _AllMatchesState extends State<AllMatches>   with SingleTickerProviderStateMixin  {
  late TabController _tabController;
    @override
  void initState() {
    super.initState();

//Internet connection
 getConnectivity(context,setState);  
   
    Get.put<ThemeController>(
      ThemeController(sharedPreferences: Get.find()),
    );

    ThemeController themeController = Get.find();
    MyUtils.allScreensUtils(themeController.darkTheme);

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: '',
      child:  
   Scaffold(
      appBar: AppBar(
        leading: const ShapeIcon(icon: MyImages.filter,height: 18, width: 430,),
        bottom: TabBar(
          labelColor: MyColor.getPrimaryTextColor(),
          indicatorColor: MyColor.getPrimaryTextColor(),
          isScrollable: true,

          controller: _tabController,
          dividerColor: MyColor.mytransparentColor,
          tabs: [MyTab(MyStrings.upcoming.tr), MyTab(MyStrings.finish.tr)],
        ),
      ),
      body: TabBarView(
        physics: const ScrollPhysics(),
        controller: _tabController,
        children: const [
          //home Screen ---------------------------------------------------------------
          Stack(
            children: [
        
                 //Ads ---------------------------------------------------------------
            //  Positioned(
            //   bottom: 0,
            //   left: 35,
            //   child:    BannerAdWidget())
            AllUpcoming()
            ],
          ),


          //Live Match Screen ----------------------------------------------------------
          
      Stack(
            children: [
        
                 //Ads ---------------------------------------------------------------
            //  Positioned(
            //   bottom: 0,
            //   left: 35,
            //   child:    BannerAdWidget())
AllFinishList()
            
            ],
          ),


        ],
      ),
      bottomNavigationBar: const CustomBottomNav(
        currentIndex: 2,
      ),
    )
,
    );
  }

}