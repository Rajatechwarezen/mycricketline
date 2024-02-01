

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprotbuzz/core/helper/shared_preference_helper.dart';
import 'package:sprotbuzz/core/routes/routes.dart';
import 'package:sprotbuzz/core/utilis/AllColor.dart';
import 'package:sprotbuzz/core/utilis/style.dart';
import 'package:sprotbuzz/view/component/text/header_text.dart';
import 'package:sprotbuzz/view/component/text/small_text.dart';

import '../core/utilis/my_color.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static const routeName = " Onboarding";
  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ?  MyColor.bgColorLight : MyColor.myprimaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  // void initState() {
  //   // WidgetsBinding.instance?.addPostFrameCallback((_) async {
  //   //   await contractionDeviceInfo(context);
  //   //   await getDeviceInfo(context);
  // //  });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 600.0,
                child: PageView(
                  physics: const ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children:  [
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Image(
                              image: AssetImage(
                                'assets/onboarding0.png',
                              ),
                              height: 300.0,
                              width: 300.0,
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          SmallText(
                             text:  'Connect people\naround the world',
                        textStyle:interSemiBoldExtraLarge.copyWith(color: MyColor.getTextColor())
                          ),
                          SizedBox(height: 15.0),
                          SmallText(
                          text:  'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                          textStyle:interSemiBoldExtraSmall.copyWith(color: MyColor.getTextColor()) ,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Image(
                              image: AssetImage(
                                'assets/onboarding1.png',
                              ),
                              height: 300.0,
                              width: 300.0,
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          SmallText(
                              text:'Live your life smarter\nwith us!',
                                   textStyle:interSemiBoldExtraLarge.copyWith(color: MyColor.getTextColor())
                        ),
                          const SizedBox(height: 15.0),
                          SmallText(
                              text:'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                             textStyle:interSemiBoldExtraSmall.copyWith(color: MyColor.getTextColor()) ,
                       
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Image(
                              image: AssetImage(
                                'assets/onboarding2.png',
                              ),
                              height: 300.0,
                              width: 300.0,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          SmallText(
                             text: 'Get a new experience\nof imagination',
                        textStyle:interSemiBoldExtraLarge.copyWith(color: MyColor.getTextColor())
                       
                          ),
                          SizedBox(height: 15.0),
                          SmallText(
                             text: 'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                              textStyle:interSemiBoldExtraSmall.copyWith(color: MyColor.getTextColor()) ,
                     
                      
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
              _currentPage != _numPages - 1
                  ? Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              HeaderText(
                                text: 'Next',
                             textStyle: interSemiBoldExtraLarge.copyWith(color: MyColor.getTextColor()),
                   
                              ),
                              const SizedBox(width: 10.0),
                             const Icon(
                                Icons.arrow_forward,
                                color: MyColor.myprimaryColor,
                                size: 30.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const Text(''),
            ],
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 70.0,
              width: double.infinity,
              color: MyColor.myprimaryColor,
              child: TextButton(
                onPressed: () async {
                  try {
                    final preferences = await SharedPreferences.getInstance();
                    preferences.setString(SharedPreferenceHelper.accessInfo, _currentPage.toString());
                    Get.offAllNamed(RouteHelper.homeScreen);
                  } catch (e) {
                    // Handle SharedPreferences error
                    if (kDebugMode) {
                      print('Error accessing SharedPreferences: $e');
                    }
                  }
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: HeaderText(
                      text: 'Get started',
                       textStyle: interSemiBoldExtraLarge.copyWith(color: MyColor.getTextColor()),
                      // style: CustomStyleswhite.headerTextStyle,
                    ),
                  ),
                ),
              ),
            )
          : const Text(''),
    );
  }
}
