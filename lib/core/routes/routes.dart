import 'package:get/get.dart';
import 'package:sprotbuzz/home_Screen.dart';
import 'package:sprotbuzz/splash/splash.dart';
import 'package:sprotbuzz/view/screens/InsideLiveScreen/Real_Time_Live/RealTimeLiveScreen.dart';
import 'package:sprotbuzz/view/screens/menu/menu_screen.dart';
import 'package:sprotbuzz/view/screens/pool/pool_screen.dart';
import 'package:sprotbuzz/view/screens/short/shortHomeScreen.dart';

import '../../splash/intro.dart';
import '../../view/screens/about/privacy_policy_screen.dart';
import '../../view/screens/faq/faq_screen.dart';
import '../../view/screens/home/home_page_componet/treading/fullTrendingScreen.dart';
import '../../view/screens/matches/Allmatches.dart';
import '../../view/screens/referral/referral_screen.dart';


class RouteHelper{

  static const String splashScreen='/splash_screen';
  static const String homeScreen='/home_screen';
  static const String privacyScreen='/privacy_screen';
  static const String referralScreen = "/referral_screen";
  static const String editProfileScreen = "/edit_profile_screen";
  static const String faqScreen = "/faq_screen";
  static const String notificationScreen = "/notification_screen";
  static const String menuScreen = "/menuScreen";
  static const String infoScreen = "/infoScreen";
 static const String shortPageScreen = "/shortPageScreen";
 static const String  fullTrendingScreen = "/fullTrendingScreen";
 static const String  allMatchesScreen = "/AllMatches";
 static const String  realTimeScreen = "/RealTime";

 static const String  poolScreen = "/PoolScreen";



  static List<GetPage> routes = [

    GetPage(name: splashScreen,               page: () =>  const SplashScreen()),
       GetPage(name: homeScreen,               page: () =>   CricketHomePage()),
       GetPage(name: faqScreen,                  page: () =>  const FaqScreen()),
      GetPage(name: menuScreen,               page: () =>  const MenuScreen()),
     GetPage(name: infoScreen,               page: () =>  const OnboardingScreen()),
     GetPage(name: referralScreen,               page: () =>  const ReferralScreen()),
  GetPage(name: privacyScreen,              page: () =>  const PrivacyScreen()),
  
    GetPage(name: shortPageScreen,               page: () =>  ShortPageScreen()),
      GetPage(name: fullTrendingScreen,               page: () =>  FullTrendingScreen()),
       GetPage(name: allMatchesScreen,               page: () =>  const AllMatches()),
    
       GetPage(name: realTimeScreen,               page: () =>   RealTimeLiveScreen(idMatch: 0, type: '', allData: null,)),   
       
       GetPage(name: poolScreen,               page: () =>  const PoolScreen()),   

  ];
}