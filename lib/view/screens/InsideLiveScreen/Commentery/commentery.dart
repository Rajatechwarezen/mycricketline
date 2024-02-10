import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sprotbuzz/core/utilis/AllColor.dart';
import 'package:sprotbuzz/core/utilis/boxSpace.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/core/utilis/style.dart';
import 'package:sprotbuzz/data/repo/commentery_repo/CommenteryRepo.dart';
import 'package:sprotbuzz/view/component/custom_loader/custom_loader.dart';
import 'package:sprotbuzz/view/screens/InsideLiveScreen/Commentery/widget/commentryCard.dart';

import '../../../../core/utilis/borderbox.dart';
import '../../../../data/controller/commentery_controller/commentery_controller.dart';
import '../../../../data/model/commentery_model/commentery_model.dart';

class Commentary extends StatefulWidget {
  final idMatch;

  Commentary({Key? key, required this.idMatch}) : super(key: key);

  @override
  State<Commentary> createState() => _CommentaryState();
}

class _CommentaryState extends State<Commentary> {
  CommenteryController commenteryController = CommenteryController(
      commenteryRepo: CommenteryRepo(apiClient: Get.find()));

  List<bool> isExpandedList = [];

  CricketMatch? commentaryApiMatches;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var data  = await commenteryController.commenteryfatchData(idMatch:widget.idMatch);

    if(data!=null) {
      commentaryApiMatches = commenteryController.allLiveMatches![0];
    }
    
    if (commentaryApiMatches != null) {
      setState(() {
        isExpandedList =
            List<bool>.filled(commentaryApiMatches!.data.length, false);
      });
    }
  }

  void toggleExpansion(int index) {
    setState(() {
      isExpandedList[index] = !isExpandedList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
/////////////////////////////////////////
    final screenWidth = MediaQuery.of(context).size.width;

    if (commentaryApiMatches == null) {
      // Handle case when data is not available
      return CustomLoader();
    } else {
      return Scaffold(
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: commentaryApiMatches!.data.length,
          itemBuilder: (context, index) {
            String inningKey = commentaryApiMatches!.data.keys.elementAt(index);
            Inning inning = commentaryApiMatches!.data[inningKey]!;

            return Column(
              children: [
                GestureDetector(
                  onTap: () => toggleExpansion(index),
                  child: Container(child: customboxbutton2(inningKey)),
                ),
                if (index == 0 ? true:  isExpandedList[index] )
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: inning.overs.length,
                    itemBuilder: (context, index) {
                      String overKey = inning.overs.keys.elementAt(index);
                      List<Commentary1>? commentaries = inning.overs[overKey];

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              overKey,
                              style: interBoldExtraLarge.copyWith(
                                  color: MyColor.getTextColor()),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: commentaries!.length,
                            itemBuilder: (context, index) {
                              Commentary1 commentary = commentaries[index];
                              Data data = commentary.data;
                              colorChange() {
                                if (data.runs == "w") {
                                  return MyColor.closeRedColor;
                                } else if (data.runs == "6") {
                                  return MyColor.myprimaryColor;
                                } else if (data.runs == "4") {
                                  return MyColor.greenP;
                                } else {
                                  return Colors.grey;
                                }
                              }

                              return ListTile(
                                subtitle: SizedBox(
                                  child: Row(
                                   
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                        Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text("${data.overs ?? ""}",
                                                  style:
                                                      interBoldSmall.copyWith(
                                                          color: MyColor
                                                              .getTextColor())),
                                              data.title
                                                      .toString()
                                                      .contains("END OF OVER")
                                                  ? size10h
                                                  : Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: 30,
                                                      height: 30,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      margin:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                          color: colorChange(),
                                                          borderRadius:
                                                              boRadius5),
                                                      child: Text(
                                                        ' ${data.runs ?? ''}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: interBoldDefault
                                                            .copyWith(
                                                                color: MyColor
                                                                    .getTextColor()),
                                                      )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    size20w,
                                    
                                    
                                    
                                      data.title
                                              .toString()
                                              .contains("END OF OVER")
                                          ?
                                          
                               CustomCardComentry(
                                AllData:commentaries,
  title: data.title ?? '',
  batsman1Name:data.batsman1Name ,

  batsman2Name: data.batsman2Name,
  bowlerName: data.bowlerName,
  batsman1Balls: data.batsman1Balls ?? '',
  batsman2Balls: data.batsman2Balls ?? '',
  bowlerOvers: data.bowlerOvers ?? '',
  bowlerWickets: data.bowlerWickets ?? '',
  bowlerRuns: data.bowlerRuns ?? '',
  bowlerMaidens: data.bowlerMaidens ?? '',

)
                                         
                                         
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data.title ?? '',
                                                  style:
                                                      interBoldDefault.copyWith(
                                                          color: MyColor
                                                              .getTextColor1()),
                                                ),
                                              
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
              ],
            );
          },
        ),
      );
    }
  }
}

customboxbutton2(inningKey) {
  return Container(
      decoration: BoxDecoration(
          color: MyColor.getCardBg(),
          border: border,
          borderRadius: boRadiusAll),
      margin: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 5),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            inningKey,
            style: interBoldDefault.copyWith(color: MyColor.getTextColor()),
          ),
          const Icon(
            Icons.arrow_circle_down,
            color: MyColor.mycolorWhite,
          )
        ],
      ));
}
