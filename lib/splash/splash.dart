import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprotbuzz/core/helper/shared_preference_helper.dart';
import 'package:sprotbuzz/core/routes/routes.dart';
import 'package:sprotbuzz/core/utilis/borderbox.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/core/utilis/my_images.dart';

import '../core/utilis/AllColor.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final _splashDelay = 3000;
  late AnimationController _animationController;

  String? allreadyExit;
  String? Intro;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animationController.forward();
    super.initState();

    _loadWidget();
  }

  _loadWidget() async {
    final store = await SharedPreferences.getInstance();
  
    Intro = store.getString(SharedPreferenceHelper.accessInfo);
    var duration = Duration(milliseconds: _splashDelay);

    return Timer(duration, navigationPage);
  }

  Future<void> navigationPage() async {

    if (Intro == "0" || Intro == null) {

      Get.offNamed(RouteHelper.infoScreen);

    } else {

    Get.offNamed(RouteHelper.homeScreen);
         
    }
    
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.mybackgroundColor,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
         
        height: 600,
          child: Center(
          
              child: ScaleTransition(
                  scale: _animationController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                 
                    children: [
                      Container(
                     
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(MyImages.appLogo),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: boRadiusAll,
                        ),
                        height: 200, // Set the height as needed
                        width: 200, // Set the width as needed
                      ),
                    
                             
                    ],
                  ))),
        ),
      ),
    );
  }
}
