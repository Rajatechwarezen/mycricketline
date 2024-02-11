import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sprotbuzz/core/utilis/borderbox.dart';
import 'package:sprotbuzz/core/utilis/boxSpace.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/core/utilis/style.dart';
import 'package:sprotbuzz/data/repo/RealTimeRepo/Info_Repo.dart';
import 'package:sprotbuzz/view/component/custom_loader/custom_loader.dart';
import 'package:sprotbuzz/view/screens/InsideLiveScreen/Real_Time_Live/RealTimeLiveScreen.dart';
import 'package:sprotbuzz/view/screens/InsideLiveScreen/Real_Time_Live/RealTimecomponent/RealTimecomponent.dart';
import 'package:sprotbuzz/view/screens/InsideLiveScreen/player/PlayerScreen.dart';

import '../../../../data/controller/Infomation_controller/Infomation_controller.dart';
import '../../../../data/controller/Real_Time_Controller/RealTimeController.dart';
import '../../../../data/repo/RealTimeRepo/real_Time_Repo.dart';
import '../../../../data/servies/api_service.dart';
import '../../../component/circle_image/circle_image_button.dart';
import '../../../component/divider/custom_divider.dart';
import '../../../component/image/round_shape_icon.dart';
import '../../../component/text/small_text.dart';

class Info extends StatefulWidget {
  var id;
  var type;

  Info({
    super.key,
    required this.type,
    required this.id,
  });

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  InfomationController? infocontroller;
  @override
  void initState() {
    super.initState();

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(InfomationRepo(apiClient: Get.find()));
    infocontroller = Get.put(InfomationController(infomationRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      infocontroller!.fetcRealTimeData(matchId: widget.id);
      
    });
  }

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    final screenWidth = MediaQuery.of(context).size.width;
    //    var Infoprovider = Provider.of<InfoProvider>(context);
    //   Infoprovider.fetchLiveMatchesFullDataInfo(widget.id);

    return Obx(() => SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: infocontroller!.isLoading.value
              ? CustomLoader()
              : Column(
                  children: [
                 infocontroller!.allLiveMatches!.isEmpty ? 
                 
                 CustomLoader():
                   Column(
                      children: infocontroller!.allLiveMatches!.map(
                        (Data) {
                          return Column(
                            children: [
                              Data.toss != null
                                  ? cardBoxUi(
                                      screenWidth: screenWidth,
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SmallText(
                                                text: Data.toss == " "
                                                    ? "${widget.type}"
                                                    : Data.toss,
                                                textStyle: interBoldExtraSmall
                                                    .copyWith(
                                                        color: MyColor
                                                            .getTextColor())),
                                            Container(
                                                height: 30,
                                                width: 30,
                                                margin: const EdgeInsets.only(
                                                  left: 10,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius: boRadiusAll,
                                                  image: const DecorationImage(
                                                    image: AssetImage(
                                                        "assets/images/toss.png"),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ]),
                                    )
                                  : const Text(""),
                              /////////////////team show

                              SizedBox(
                                  child: InkWell(
                                onTap: () {
                                  showModalBottomSheet<void>(
                                    showDragHandle: true,
                                    useSafeArea: true,
                                    isScrollControlled: true,
                                    elevation: 0,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CricketPlayerListState(
                                          matchId: widget.id);
                                    },
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    color: MyColor.getCardBg(),
                                    border: border,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      size10h,
                                      Row(
                                        children: [
                                          CircleImageWidget(
                                            height: 30.0,
                                            width: 30.0,
                                            imagePath: Data.teamAImg,
                                            isAsset: false,
                                          ),
                                          size10w,
                                          Text(
                                            Data.teamA,
                                            style: interBoldExtraSmall.copyWith(
                                              color: MyColor.getTextColor(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      CustomDivider(),
                                      Row(
                                        children: [
                                          CircleImageWidget(
                                            height: 30.0,
                                            width: 30.0,
                                            imagePath: Data.teamBImg,
                                            isAsset: false,
                                          ),
                                          size10w,
                                          Text(
                                            Data.teamB,
                                            style: interBoldExtraSmall.copyWith(
                                              color: MyColor.getTextColor(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      size10h,
                                    ],
                                  ),
                                ),
                              )),
                              cardBoxUi(
                                screenWidth: screenWidth,
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            size10h,
                                            SizedBox(
                                              width: 300,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Match Detail",
                                                        style: interBoldExtraSmall
                                                            .copyWith(
                                                                color: MyColor
                                                                    .getTextColor1())),
                                                    size10h,
                                                    Text(
                                                      "${Data.dateWise}",
                                                      style: interBoldSmall
                                                          .copyWith(
                                                              color: MyColor
                                                                  .getTextColor()),
                                                    ),
                                                    const CustomDivider(),
                                                  ]),
                                            ),
                                            size10h,
                                            Row(
                                              children: [
                                                Text("Series",
                                                    style: interBoldExtraSmall
                                                        .copyWith(
                                                            color: MyColor
                                                                .getTextColor1()))
                                              ],
                                            ),
                                            size10h,
                                            SizedBox(
                                              width: 300,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${Data.series}",
                                                      style: interBoldSmall
                                                          .copyWith(
                                                              color: MyColor
                                                                  .getTextColor()),
                                                    ),
                                                    CustomDivider(),
                                                  ]),
                                            ),
                                            CustomDivider(),
                                            size10h,
                                            Row(
                                              children: [
                                                Text("Match",
                                                    style: interBoldExtraSmall
                                                        .copyWith(
                                                            color: MyColor
                                                                .getTextColor1()))
                                              ],
                                            ),
                                            size10h,
                                            SizedBox(
                                              width: 300,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${Data.teamA} VS ${Data.teamB}",
                                                      style: interBoldDefault
                                                          .copyWith(
                                                        color: MyColor
                                                            .getTextColor(),
                                                      ),
                                                    ),
                                                    CustomDivider(),
                                                  ]),
                                            ),
                                            CustomDivider(),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Date & Time",
                                                    style: interBoldExtraSmall
                                                        .copyWith(
                                                            color: MyColor
                                                                .getTextColor1())),
                                                size10h,
                                                Text(
                                                  " ${Data.matchTime} - ${Data.matchDate}  ",
                                                  style:
                                                      interBoldSmall.copyWith(
                                                          color: MyColor
                                                              .getTextColor()),
                                                )
                                              ],
                                            ),
                                            size10h,
                                            Row(
                                              children: [
                                                Text("Match No  ",
                                                    style: interBoldExtraSmall
                                                        .copyWith(
                                                            color: MyColor
                                                                .getTextColor1()))
                                              ],
                                            ),
                                            size10h,
                                            SizedBox(
                                              width: 300,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${Data.match} ",
                                                    style:
                                                        interBoldSmall.copyWith(
                                                            color: MyColor
                                                                .getTextColor()),
                                                  )
                                                ],
                                              ),
                                            ),
                                            size10h,
                                            Row(
                                              children: [
                                                Text("venu ",
                                                    style: interBoldExtraSmall
                                                        .copyWith(
                                                            color: MyColor
                                                                .getTextColor1()))
                                              ],
                                            ),
                                            size10h,
                                            SizedBox(
                                              width: 300,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${Data.venue}",
                                                    style:
                                                        interBoldSmall.copyWith(
                                                            color: MyColor
                                                                .getTextColor()),
                                                  )
                                                ],
                                              ),
                                            ),
                                            size10h,
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                              cardBoxUi(
                                  screenWidth: screenWidth,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                               Text("Venue  ",
                                                  style: interBoldExtraSmall 
                                                      .copyWith(
                                                          color: MyColor
                                                              .getTextColor1())),
                                              Row(
                                                children: [
                                                  CircleImageWidget(
                                                      border: 1,
                                                      isAsset: false,
                                                      imagePath:
                                                          Data.venueWeather.weatherIcon?? ""),
                                                              Text(Data.venueWeather.weather?? "", style: interBoldExtraSmall 
                                                      .copyWith(
                                                          color: MyColor
                                                              .getTextColor1())),
                                                ],
                                              ),
                                             
                                              size10h,
                                          
                                              const CustomDivider(),
                                            ]),
                                      ),
                                    ],
                                  )),
                     
                       
                              //////////////////////////////////////////////////////////////////venueWeather
                      cardBoxUi(
                                  screenWidth: screenWidth,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                               Text("Venue Weather ",
                                                  style: interBoldExtraSmall 
                                                      .copyWith(
                                                          color: MyColor
                                                              .getTextColor1())),
                                              Row(
                                                children: [
                                                  CircleImageWidget(
                                                      border: 1,
                                                      isAsset: false,
                                                      imagePath:
                                                          Data.venueWeather.weatherIcon?? ""),
                                                              Text(Data.venueWeather.weather?? "", style: interBoldExtraSmall 
                                                      .copyWith(
                                                          color: MyColor
                                                              .getTextColor1())),
                                                ],
                                              ),
                                             
                                              size10h,
                                          
                                              const CustomDivider(),
                                            ]),
                                      ),
                                    ],
                                  )),

                            
                              //////////////////////////////////////////////////////////////////yetToBet

                              Data.referee == "" && Data.umpire == " "
                                  ? Container(
                                      padding: const EdgeInsets.all(5),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                      decoration: BoxDecoration(
                                          color: MyColor.getCardBg(),
                                          borderRadius: boRadiusAll,
                                          border: border),
                                      width: screenWidth * 0.9,
                                      child: Column(children: [
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Rafree/Umpire",
                                                    style: interBoldExtraSmall
                                                        .copyWith(
                                                            color: MyColor
                                                                .getTextColor1())),
                                                Text("Rafree:",
                                                    style: interBoldExtraSmall
                                                        .copyWith(
                                                            color: MyColor
                                                                .getTextColor1())),
                                                size10h,
                                                SizedBox(
                                                  width: 300,
                                                  child: Column(children: [
                                                    Text("${Data.referee}"),
                                                    CustomDivider(),
                                                  ]),
                                                ),
                                                size10h,
                                                Row(
                                                  children: [
                                                    Text("Umpire: ",
                                                        style: interBoldExtraSmall
                                                            .copyWith(
                                                                color: MyColor
                                                                    .getTextColor1())),
                                                  ],
                                                ),
                                                size10h,
                                                SizedBox(
                                                  width: 300,
                                                  child: Column(
                                                    children: [
                                                      Text(" ${Data.umpire}"),
                                                      CustomDivider(),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text("Thire Umpire : ",
                                                        style: interBoldExtraSmall
                                                            .copyWith(
                                                                color: MyColor
                                                                    .getTextColor1())),
                                                    CustomDivider(),
                                                  ],
                                                ),
                                                size10h,
                                                SizedBox(
                                                  width: 300,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                          " ${Data.thirdUmpire}" ??
                                                              " "),
                                                      CustomDivider(),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ]),
                                    )
                                  : const Text("")
                            ],
                          );
                        },
                      ).toList()
                    ),
                  ],
                ),
        ));
  }
}
