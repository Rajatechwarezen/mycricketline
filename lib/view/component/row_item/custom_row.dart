import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprotbuzz/core/utilis/dimansion.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/core/utilis/style.dart';
import 'package:sprotbuzz/view/component/divider/custom_divider.dart';

class CustomRow extends StatelessWidget {
  final String firstText,lastText;
  final bool isStatus,isAbout,showDivider;
  final Color? statusTextColor;
  final bool hasChild;
  final Widget? child;
  const CustomRow({Key? key,this.child,this.hasChild=false,this.statusTextColor,required this.firstText,required this.lastText,this.isStatus=false,this.isAbout=false,this.showDivider=true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return hasChild?Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(firstText,style: interRegularDefault.copyWith(color: MyColor.getPrimaryTextColor()),overflow: TextOverflow.ellipsis,maxLines: 1,)),
            child ?? const SizedBox(),
          ],
        ),
        const SizedBox(height: 5,),
        showDivider? const CustomDivider(): const SizedBox(),
        showDivider? const SizedBox(height: 5,) : const SizedBox(),
      ],
    ): isAbout ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(firstText,style: interRegularDefault.copyWith(color: MyColor.getPrimaryTextColor())),
        const SizedBox(height: 4,),
       Text(lastText,style: interRegularDefault.copyWith(color: isStatus ? statusTextColor : MyColor.getPrimaryTextColor()),),
        const SizedBox(height: 5,),
      ],
    ) :
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(firstText,style: interRegularDefault.copyWith(color: MyColor.getPrimaryTextColor()),overflow: TextOverflow.ellipsis,maxLines: 1,)),
            isStatus ? StatusButton(text: lastText, bgColor: MyColor.getPrimaryTextColor()) : Flexible(child:Text(lastText, maxLines:2, style: interRegularDefault.copyWith(color: isStatus ? MyColor.redCancelTextColor : MyColor.getPrimaryTextColor()),overflow: TextOverflow.ellipsis,textAlign: TextAlign.end,))
          ],
        ),
        const SizedBox(height: 5),
        showDivider ? const  CustomDivider(): const SizedBox(),
        showDivider ? const SizedBox(height: 5,) : const SizedBox(),
      ],
    );
  }
}

class StatusButton extends StatelessWidget {

  final String text;
  final Color bgColor;
  final bool isShowBg;
  final double minWidth;
  final double minHeight;
  final bool isCircle;

  const StatusButton({Key? key,
    this.minWidth=45,
    this.minHeight=10,
    this.isShowBg=true,
    this.isCircle = false,
    required this.text,
    required this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isCircle?
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: bgColor.withOpacity(.05),
        border: Border.all(color: bgColor)
      ),
      child: Text(
        text.tr,
        style: interRegularDefault.copyWith(
            fontSize: Dimensions.fontExtraSmall,
            color: bgColor),
      ),
    ):
    Text(
      text,
      style: interRegularDefault.copyWith(
          fontSize: Dimensions.fontDefault,
          color: bgColor),
    );
  }
}
