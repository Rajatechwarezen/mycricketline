
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/data/controller/language_controller.dart';
import 'package:sprotbuzz/data/controller/theme_controller.dart';

import 'package:sprotbuzz/firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sprotbuzz/core/helper/di_services.dart' as di_service;
import 'package:sprotbuzz/core/routes/routes.dart';
import 'package:sprotbuzz/core/theme/dark.dart';
import 'package:sprotbuzz/core/theme/light.dart';
import 'package:sprotbuzz/core/utilis/AllColor.dart';
import 'package:sprotbuzz/core/utilis/massages.dart';
import 'package:sprotbuzz/core/utilis/my_strings.dart';
import 'package:sprotbuzz/push_notification_service.dart';
import 'package:sprotbuzz/view/component/schadual_notification/NotificationService.dart';

import 'view/component/overlay/overlay.dart';

       final NotiController notiController = Get.put(NotiController());
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Perform tasks based on the incoming FCM message when the app is in the background.
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
notiController.initializeNotifications();
  Map<String, Map<String, String>> _languages = await di_service.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
 await PushNotificationService().setupInteractedMessage();
  _fcmConfigure();
  runApp(MyApp(
    languages: _languages,
  ));
}

class MyApp extends StatelessWidget {
   final Map<String, Map<String, String>> languages;

  MyApp({Key? key, required this.languages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return  GetBuilder<LocalizationController>(builder: (localizationController) {
            return  GetBuilder<ThemeController>(
        builder: (theme) {
          return GetMaterialApp(
            title: MyStrings.appName,
            initialRoute: RouteHelper.splashScreen,
            defaultTransition: Transition.topLevel,
            transitionDuration: const Duration(milliseconds: 200),
            getPages: RouteHelper.routes,
            navigatorKey: Get.key,
            theme: theme.darkTheme ? dark : light,
            debugShowCheckedModeBanner: false,
          locale: localizationController.locale,
        translations: Messages(languages: languages),
    fallbackLocale: Locale(localizationController.locale.languageCode, localizationController.locale.countryCode),
         
          );
        },
      );

        });

    }
}

_fcmConfigure() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    showOverlay(message.notification?.title ?? "No Title",
            message.notification?.body ?? "No body");

  });
}

