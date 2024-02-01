
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:url_launcher/url_launcher.dart';
void launchRateAppURL() async {
  // The package name (Android) or app ID (iOS) of your app
  const String packageName = 'your_app_package_name';
  const String iOSAppId = 'your_app_id';

  if (await canLaunchUrl(Uri.parse(_getStoreUrl(packageName, iOSAppId)))) {
    await launchUrl(Uri.parse(_getStoreUrl(packageName, iOSAppId)));
  } else {
    throw 'Could not launch store URL';
  }
}

String _getStoreUrl(String packageName, String iOSAppId) {
  if (Platform.isAndroid) {
    return 'https://play.google.com/store/apps/details?id=$packageName';
  } else if (Platform.isIOS) {
    return 'https://apps.apple.com/us/app/your-app-name/$iOSAppId';
  } else {
    throw 'Unsupported platform';
  }
}

// update
showRateUsDialogUpdate(BuildContext context) async {

  return showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor:MyColor.myprimaryColor,
        contentTextStyle: TextStyle(
          color: MyColor.getTextColor(),
          fontFamily: 'Lora',
          fontWeight: FontWeight.w400,
          fontSize: 10,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Update Available",
              style: TextStyle(
                color: MyColor.getTextColor(),
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Please consider updating us!",
              style: TextStyle(
                color: MyColor.getTextColor(),
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              "Maybe later",
              style: TextStyle(
                color: MyColor.getTextColor(),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              launchRateAppURLUpdate();
              Navigator.pop(context, true);
            },
            child: Text(
              "Update Now",
              style: TextStyle(color: MyColor.getTextColor()),
            ),
          ),
        ],
      );
    },
  );
}

void launchRateAppURLUpdate() async {
  // The package name (Android) or app ID (iOS) of your app
  const String packageName = 'your_app_package_name';
  const String iOSAppId = 'your_app_id';

  if (await canLaunchUrl(
      Uri.parse(_getStoreUrlUpdata(packageName, iOSAppId)))) {
    await launchUrl(Uri.parse(_getStoreUrlUpdata(packageName, iOSAppId)));
  } else {
    throw 'Could not launch store URL';
  }
}

String _getStoreUrlUpdata(String packageName, String iOSAppId) {
  if (Platform.isAndroid) {
    return 'https://play.google.com/store/apps/details?id=$packageName';
  } else if (Platform.isIOS) {
    return 'https://apps.apple.com/us/app/your-app-name/$iOSAppId';
  } else {
    throw 'Unsupported platform';
  }
}

String generateRandomCode(int length) {
  final random = Random();
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  return String.fromCharCodes(
    Iterable.generate(
        length, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
  );
}



void shareReferralLink(String referralLink) {
  String referralCode = generateRandomCode(6);
  Share.share(
      'Join our app using this referral link: ${referralLink + referralCode}');
}

//facebook link
void launchFacebookPage() async {
  final facebookPageUrl = 'https://www.facebook.com/your_page_username_or_id';
  if (await canLaunchUrl(Uri.parse(facebookPageUrl))) {
    await launchUrl(Uri.parse(facebookPageUrl));
  } else {
    throw 'Could not launch Facebook page';
  }
}

//instagram link
void launchInstagramProfile() async {
  final instagramProfileUrl =
      'https://www.instagram.com/your_profile_username/';
  if (await canLaunch(instagramProfileUrl)) {
    await launch(instagramProfileUrl);
  } else {
    throw 'Could not launch Instagram profile';
  }
}

