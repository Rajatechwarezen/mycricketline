import 'dart:async';

import 'package:flutter/material.dart';

import 'package:mycricketline/screen/Myhome.dart';

import '../utils/Color.dart';

// ignore: depend_on_referenced_packages
// import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showAnimation();
  }

  bool animate1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cricket_white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: Image.asset(
                'images/logo.gif',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showAnimation() async {
    // Timer(const Duration(seconds: 5), () {
    //   setState(() {
    //     animate1 = true;
    //   });
    // });

    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CricketPage()),
      );
    });
  }
}
