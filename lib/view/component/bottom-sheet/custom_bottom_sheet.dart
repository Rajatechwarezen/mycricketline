import 'package:flutter/material.dart';
import 'package:sprotbuzz/core/utilis/dimansion.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';

class CustomBottomSheet{

  final Widget child;
  final Color backgroundColor;
  bool isNeedMargin;
  final VoidCallback? voidCallback;

  CustomBottomSheet({
    required this.child,
    this.isNeedMargin = false,
    this.voidCallback,
    this.backgroundColor = MyColor.mycardBgColor
  });

  void customBottomSheet(BuildContext context){

    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: MyColor.mytransparentColor,
      context: context,
      builder: (BuildContext context) => SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
          child: Container(
            margin: isNeedMargin ? const EdgeInsets.only(left: 15, right: 15, bottom: 15) : EdgeInsets.zero,
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space15),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: isNeedMargin ? BorderRadius.circular(15) : const BorderRadius.vertical(top: Radius.circular(15))
            ),
            child: child,
          ),
        ),
      )
    ).then((value){
      voidCallback;
    });
  }
}