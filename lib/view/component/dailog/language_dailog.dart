import 'package:flutter/material.dart';
import 'package:sprotbuzz/core/utilis/dimansion.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/core/utilis/my_strings.dart';
import 'package:sprotbuzz/core/utilis/style.dart';

class LanguageDialogBody extends StatefulWidget {
  final List langList ;
  final bool fromSplashScreen;
  const LanguageDialogBody({Key? key,required this.langList,this.fromSplashScreen = false}) : super(key: key);

  @override
  State<LanguageDialogBody> createState() => _LanguageDialogBodyState();
}

class _LanguageDialogBodyState extends State<LanguageDialogBody> {

  int pressIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: Text(MyStrings.LANGUAGE_CODE,style: interRegularDefault.copyWith(color:MyColor.getTextColor(),fontSize: Dimensions.fontLarge),),),
          const SizedBox(height: Dimensions.space15,),
          Flexible(child: ListView.builder(
              shrinkWrap: true,
              itemCount:  widget.langList.length,
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: ()async{
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                    decoration: BoxDecoration(color: MyColor.getCardBg(), borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                    child: pressIndex==index?const  Center(
                      child: SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(color: MyColor.myprimaryColor)),
                    ):Text(
                     ( widget.langList[index].languageName).tr,
                      style: interRegularDefault.copyWith(color: MyColor.getTextColor()),
                    ),
                  ),
                );
              })),
        ],
      ),
    );
  }
}
