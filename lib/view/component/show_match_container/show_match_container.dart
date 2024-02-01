import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprotbuzz/data/model/home_page_models.dart';
import 'package:sprotbuzz/view/component/show_match_container/score_show/score_Show.dart';

import '../../../core/utilis/borderbox.dart';
import '../../../core/utilis/boxSpace.dart';
import '../../../core/utilis/my_color.dart';
import '../../../core/utilis/style.dart';
import '../../screens/home/home_page_componet/carousel/widget/Widget.dart';
import '../divider/custom_divider.dart';
import '../schadual_notification/NotificationService.dart';


// // ignore: must_be_immutable
// class ShowMatchContainer extends StatefulWidget {
//   dynamic details;
//   Function onTap;
//   bool isLive = false;
//   ShowMatchContainer(
//       {super.key,
//       required this.details,
//       required this.onTap,
//       required this.isLive});

//   @override
//   State<ShowMatchContainer> createState() => _ShowMatchContainerState();
// }

// class _ShowMatchContainerState extends State<ShowMatchContainer> {
//   @override
//   void initState() {
//     super.initState();
 
//    notiController.initializeNotifications();
//   }

//        final NotiController notiController = Get.put(NotiController());

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//         onTap: widget.onTap(),
//         child: Stack(
//           children:[
          
//                     Container(
//             decoration: BoxDecoration(
//                 boxShadow: [MyBoxShow.getBoxshadow()],
//                 color: MyColor.getCardBg(),
//                 borderRadius: BorderRadius.circular(15)),
//             margin: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 9),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.only(right: 10, left: 10, top: 5),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         alignment: Alignment.topCenter,
//                         padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//                         decoration: BoxDecoration(
//                           color: colorChange(widget.details),
//                           borderRadius: boRadiusAll),
//                         child: SmallText(
//                           text: '•${widget.details.matchStatus}',
//                           textStyle: interBoldExtraSmall.copyWith(),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       SmallText(
//                         text: "  ${widget.details.matchDate} / ${widget.details.matchTime}  ",
//                         textStyle: interBoldExtraSmall.copyWith(
//                             color: MyColor.getTextColor()),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 10, left: 10, top: 5),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SmallText(
//                         text: widget.details.series,
//                         textStyle: interBoldExtraSmall.copyWith(
//                             color: MyColor.getTextColor()),
//                       ),
//                       SmallText(
//                         text: widget.details.matchType,
//                         textStyle: interBoldExtraSmall.copyWith(
//                             color: MyColor.getTextColor()),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const CustomDivider(
//                   space: 1,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 10, left: 10),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         flex: 3,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             scoreShow(
//                                 teamAOver: widget.details.teamAOver,
//                                 teamBOver: widget.details.teamBOver,
//                                 teamBScore: widget.details.teamBScore,
//                                 teamAScore: widget.details.teamAScore,
//                                 teamAImg: widget.details.teamAImg,
//                                 teamBImg: widget.details.teamBImg,
//                                 teamName: widget.details.teamAShort,
//                                 teamName2: widget.details.teamBShort,
//                                 teamScore: widget.details.teamAScore,
//                                 teamScore2: widget.details.teamBScore,
//                                 teamOver: widget.details.teamAOver,
//                                 teamOver2: widget.details.teamBOver,
//                                 matchType: widget.details.matchType)
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const CustomDivider(
//                   space: 0,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.only(
//                           right: 10, left: 10, top: 5, bottom: 3),
//                       width: 200,
//                       child: SmallTextTowLine(
//                         text: widget.details.venue,
//                         textStyle: interBoldExtraSmall.copyWith(
//                             color: MyColor.getTextColor()),
//                       ),
//                     ),
          
//                     ////here we need condition when match will live it show better 
//                     Column(
//                       children: [
//                         SmallText(
//                             text: "${widget.details.favTeam}",
//                             textStyle: interBoldExtraSmall.copyWith(
//                                 color: MyColor.getTextColor())),
//                       ],
//                     ),
//                     size10w,
//                     Row(
//                       children: [
//                         Container(
//                           height: 35,
//                           width: 60,
//                           decoration: BoxDecoration(
//                             color: MyColor.mycolorBlack,
//                             borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(
//                                   5), // Adjust the radius as needed
//                             ),
//                             border: border,
//                           ),
//                           child: Center(
//                               child: SmallText(
//                             textStyle: interBoldDefault.copyWith(
//                                 color: MyColor.getTextColor()),
//                             text: "${widget.details.min}",
//                           )),
//                         ),
//                         Container(
//                           height: 35,
//                           width: 60,
//                           decoration: BoxDecoration(
//                             color: MyColor.mylabelTextColor,
//                             border: border,
//                             borderRadius: const BorderRadius.only(
//                               bottomRight: Radius.circular(
//                                   5), // Adjust the radius as needed
//                             ),
//                           ),
//                           child: Center(
//                             child: SmallText(
//                               textStyle: interBoldDefault.copyWith(
//                                   color: MyColor.mybottomNavBgColor),
//                               text: "${widget.details.max}",
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//     Positioned(
//       right: 0,
//       child:TextButton(onPressed: (){
// notiController.showNotification("hello", "body");
//       }, child: Text("noti"),)),
//           ]
          
//          ));
//   }
// }

import 'package:flutter/material.dart';

import '../text/small_text.dart';

Widget showMatchContainer({
  required dynamic details,
  required Function onTap,
  required bool isLive,
}) {
  final NotiController notiController = Get.put(NotiController());

  return InkWell(
    onTap: () => onTap(),
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [MyBoxShow.getBoxshadow()],
            color: MyColor.getCardBg(),
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.only(
            top: 5,
            left: 10,
            right: 10,
            bottom: 9,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                        color: colorChange(details),
                        borderRadius: boRadiusAll,
                      ),
                      child: SmallText(
                        text: '•${details.matchStatus}',
                        textStyle: interBoldExtraSmall.copyWith(),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                   details.matchStatus == "Finished" || details.matchStatus ==   "Live"?   Text("") :     TextButton(
            onPressed: () {
              notiController.showNotificationsList( ["${details.matchDate} / ${details.matchTime}"], "hello", "body");
            },
            child:  Icon(Icons.notification_add, color: MyColor.getTextColor(),size:20,),
          ),
                        SmallText(
                          text:
                              "  ${details.matchDate} / ${details.matchTime}  ",
                          textStyle: interBoldExtraSmall.copyWith(
                              color: MyColor.getTextColor()),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallText(
                      text: details.series,
                      textStyle: interBoldExtraSmall.copyWith(
                          color: MyColor.getTextColor()),
                    ),
                    SmallText(
                      text: details.matchType,
                      textStyle: interBoldExtraSmall.copyWith(
                          color: MyColor.getTextColor()),
                    ),
                  ],
                ),
              ),
              const CustomDivider(
                space: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          scoreShow(
                              teamAOver: details.teamAOver,
                              teamBOver: details.teamBOver,
                              teamBScore: details.teamBScore,
                              teamAScore: details.teamAScore,
                              teamAImg: details.teamAImg,
                              teamBImg: details.teamBImg,
                              teamName: details.teamAShort,
                              teamName2: details.teamBShort,
                              teamScore: details.teamAScore,
                              teamScore2: details.teamBScore,
                              teamOver: details.teamAOver,
                              teamOver2: details.teamBOver,
                              matchType: details.matchType)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const CustomDivider(
                space: 0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        right: 10, left: 10, top: 5, bottom: 3),
                    width: 200,
                    child: SmallTextTowLine(
                      text: details.venue,
                      textStyle: interBoldExtraSmall.copyWith(
                          color: MyColor.getTextColor()),
                    ),
                  ),

                  ////here we need condition when match will live it show better 
                  Column(
                    children: [
                      SmallText(
                          text: "${details.favTeam}",
                          textStyle: interBoldExtraSmall.copyWith(
                              color: MyColor.getTextColor())),
                    ],
                  ),
                  size10w,
                  Row(
                    children: [
                      Container(
                        height: 35,
                        width: 60,
                        decoration: BoxDecoration(
                          color: MyColor.mycolorBlack,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(
                                5), // Adjust the radius as needed
                          ),
                          border: border,
                        ),
                        child: Center(
                            child: SmallText(
                          textStyle: interBoldDefault.copyWith(
                              color: MyColor.getTextColor()),
                          text: "${details.min}",
                        )),
                      ),
                      Container(
                        height: 35,
                        width: 60,
                        decoration: BoxDecoration(
                          color: MyColor.mylabelTextColor,
                          border: border,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(
                                5), // Adjust the radius as needed
                          ),
                        ),
                        child: Center(
                          child: SmallText(
                            textStyle: interBoldDefault.copyWith(
                                color: MyColor.mybottomNavBgColor),
                            text: "${details.max}",
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
     
      ],
    ),
  );
}
