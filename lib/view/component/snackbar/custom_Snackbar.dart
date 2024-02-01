
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprotbuzz/core/utilis/dimansion.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/core/utilis/my_strings.dart';
import 'package:sprotbuzz/core/utilis/style.dart';

class CustomSnackBar{
  static  showCustomSnackBar({required List<String>errorList,required List<String> msg,required bool isError,int duration=5}){
    String message='';
    if(isError){
      if(errorList.isEmpty){
        message = MyStrings.somethingWentWrong.tr;
      }else{
        for (var element in errorList) {
          String tempMessage = element.tr;
          message = message.isEmpty?tempMessage:"$message\n$tempMessage";
        }
      }
      message = message;
    } else{
      if(msg.isEmpty){
        message = MyStrings.requestSuccess.tr;
      }  else{
        for (var element in msg) {
          String tempMessage = element.tr;
          message=message.isEmpty?tempMessage:"$message\n$tempMessage";
        }
      }
      message = message;
    }
    Get.rawSnackbar(
      progressIndicatorBackgroundColor: isError?MyColor.myred: MyColor.mygreen,
      progressIndicatorValueColor: AlwaysStoppedAnimation<Color>(isError?MyColor.myred: MyColor.mygreen ),
      messageText: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2,),
          Text(message,style: interRegularDefault.copyWith(color: MyColor.getTextColor())),
        ],
      ),
      dismissDirection: DismissDirection.horizontal,
      snackPosition: SnackPosition.TOP,
      titleText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text((!isError?MyStrings.success.tr:MyStrings.error.tr).toLowerCase().capitalizeFirst??'',style: interSemiBoldSmall.copyWith(fontSize: Dimensions.fontLarge,color: MyColor.getTextColor())),
          // SvgPicture.asset(isError?MyImages.errorImage:MyImages.errorImage,height: 25,width: 25,color:isError?MyColor.red : MyColor.green)
        ],
      ),
      backgroundColor: MyColor.getScreenBgColor(),
      borderRadius: 4,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      duration:  Duration(seconds: duration),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeIn,
      showProgressIndicator: true,
      leftBarIndicatorColor: MyColor.getScreenBgColor(),
      animationDuration: const Duration(seconds: 1),
      borderColor: MyColor.myborderColor,
      reverseAnimationCurve: Curves.easeOut,
      borderWidth: 2,
    );
  }
  static  error({required List<String>errorList,int duration=5}){
    String message='';
      if(errorList.isEmpty){
        message = MyStrings.somethingWentWrong.tr;
      }else{
        for (var element in errorList) {
          String tempMessage = element.tr;
          message = message.isEmpty?tempMessage:"$message\n$tempMessage";
        }
      }
      message = message;
    Get.rawSnackbar(
      progressIndicatorBackgroundColor: MyColor.myred,
      progressIndicatorValueColor: const AlwaysStoppedAnimation<Color>(MyColor.myred),
      messageText: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2,),
          Text(message,style: interRegularDefault.copyWith(color: MyColor.getTextColor()),),
        ],
      ),
      dismissDirection: DismissDirection.horizontal,
      snackPosition: SnackPosition.TOP,
      titleText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(MyStrings.error.tr.toLowerCase().capitalizeFirst??MyStrings.error.tr,style: interSemiBoldSmall.copyWith(fontSize: Dimensions.fontLarge,color: MyColor.getTextColor())),
         
        ],
      ),
      backgroundColor: MyColor.mycolorBlack,
      borderRadius: 4,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      duration:  Duration(seconds: duration),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeIn,
      showProgressIndicator: true,
      leftBarIndicatorColor: MyColor.getScreenBgColor(),
      animationDuration: const Duration(seconds: 1),
      borderColor: MyColor.myborderColor,
      reverseAnimationCurve:Curves.easeOut,
      borderWidth: 2,
    );
  }
  static  success({required List<String>successList,int duration=5}){
    String message='';
      if(successList.isEmpty){
        message = MyStrings.somethingWentWrong.tr;
      }else{
        for (var element in successList) {
          String tempMessage = element.tr;
          message = message.isEmpty?tempMessage:"$message\n$tempMessage";
        }
      }
      message = message;
    Get.rawSnackbar(
      progressIndicatorBackgroundColor:  MyColor.mygreen,
      progressIndicatorValueColor: const AlwaysStoppedAnimation<Color>(MyColor.mygreen),
      messageText: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2,),
          Text(message,style: interRegularDefault.copyWith(color: MyColor.mycolorWhite)),
        ],
      ),
      dismissDirection: DismissDirection.horizontal,
      snackPosition: SnackPosition.TOP,
      titleText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(MyStrings.success.tr.toLowerCase().capitalizeFirst??MyStrings.success.tr,style: interSemiBoldSmall.copyWith(fontSize: Dimensions.fontLarge, color: MyColor.getTextColor())),
        ],
      ),
      backgroundColor: MyColor.getTextColor(),
      borderRadius: 4,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      duration:  Duration(seconds: duration),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeIn,
      showProgressIndicator: true,
      leftBarIndicatorColor: MyColor.getScreenBgColor(),
      animationDuration: const Duration(seconds: 1),
      borderColor: MyColor.getBorderColor(),
      reverseAnimationCurve:Curves.easeOut,
      borderWidth: 2,
    );
  }

  static showSnackBarWithoutTitle(BuildContext context,String message,{Color bg=MyColor.mygreen}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: bg,
        content: Text(message),
      ),
    );
  }



}