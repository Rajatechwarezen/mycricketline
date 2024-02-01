
  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/view/component/text/header_text.dart';
import 'package:sprotbuzz/view/component/text/small_text.dart';

import '../../../core/utilis/style.dart';
import '../buttons/category_button.dart';

void showOverlay(String title, String body) {
    final overlay = Get.overlayContext;
    if (overlay != null) {
   late    OverlayEntry overlayEntry;

      overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: 40.0,
          left: 29.0,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 320,
              height: 104,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: MyColor.getBottomNavBg(),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderText(
                  text:  title,
                    textStyle:    interBoldDefault.copyWith(color: MyColor.getTextColor()),
                  ),
                  SizedBox(height: 4.0),
                  SmallText(
                   text: body,
                    textStyle: interBoldSmall.copyWith(color: MyColor.getTextColor()),
                  ),
                  SizedBox(height: 4.0),
                  CategoryButton(text:'Dismiss', press: () {   overlayEntry.remove();  },),
                ],
              ),
            ),
          ),
        ),
      );

      Overlay.of(overlay).insert(overlayEntry);
    }
  }