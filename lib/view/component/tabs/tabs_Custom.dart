
import 'package:flutter/material.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/core/utilis/style.dart';
import 'package:sprotbuzz/view/component/text/small_text.dart';

MyTab(name) {
  return Tab(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        color: MyColor.mytransparentColor
        ),
      child: SmallText(
        
        textStyle:   interLightLarge.copyWith(color: MyColor.myprimaryColor), text: name,
      ),
    ),
  );
}
