import 'package:flutter/material.dart';
import 'package:sprotbuzz/core/utilis/borderbox.dart';
import 'package:sprotbuzz/core/utilis/boxSpace.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/view/component/divider/custom_divider.dart';

import '../../../../../core/utilis/style.dart';
import '../../../../../data/model/commentery_model/commentery_model.dart';

class CustomCardComentry extends StatelessWidget {
  final String title;
  final String batsman1Balls;
  final String batsman2Balls;
  final String bowlerOvers;
  final String bowlerWickets;
  final String bowlerRuns;
  final String bowlerMaidens;
 final String batsman1Name;
  final String batsman2Name;
   final String bowlerName;
    final List<Commentary1>? AllData;
  CustomCardComentry({
 required this.AllData,
    required this.title,
    required this.batsman1Balls,
    required this.batsman2Balls,
    required this.bowlerOvers,
    required this.bowlerWickets,
    required this.bowlerRuns,
    required this.bowlerMaidens, required this.batsman1Name, required this.batsman2Name, required this.bowlerName, 
  });

  @override
  Widget build(BuildContext context) {
List nonNullBowlerMaidens = AllData!
    .where((x) => x.data.bowlerMaidens != null)
    .map((x) {
      print('bowlerMaidens: ${x.data.bowlerMaidens}');
      return x.data.bowlerMaidens!;
    })
    .toList();
  return Expanded(
      child: Container(
        height: 140,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: MyColor.getCardBg(),
          border: border,
          
          borderRadius: boRadiusAll,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${title} : ${nonNullBowlerMaidens}" ?? '',
              style: interBoldDefault.copyWith(color: MyColor.getTextColor1()),
            ),
            CustomDivider(),
            Row(
              children: [
                Container(
                            margin: EdgeInsets.all(10),   
                            padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: MyColor.getCardBg(),

                    border: border,
                    borderRadius: boRadiusAll,
                  ),
                  child: Text("${int.parse(batsman2Balls)  + int.parse(batsman1Balls)  }",  style: interBoldHeader3.copyWith(color: MyColor.getTextColor()),),
                ),
                size10w,
                Expanded(
                  child: SizedBox(
                  height: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      
                          children: [
                                                    Text(
                              "${batsman1Name}" ?? '',
                              style: interBoldSmall.copyWith(color: MyColor.getTextColor1()),
                            ),
                            Text(
                              "${batsman1Balls}(${batsman1Balls})" ?? '',
                              style: interBoldSmall.copyWith(color: MyColor.getTextColor1()),
                            ),
                          ],
                        ),
                        Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              Text(
                              "${batsman2Name}" ?? '',
                              style: interBoldSmall.copyWith(color: MyColor.getTextColor1()),
                            ),
                            Text(
                              "${batsman2Balls}(${batsman2Balls})" ?? '',
                              style: interBoldSmall.copyWith(color: MyColor.getTextColor1()),
                            ),
                          ],
                        ),
                        Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(
                              "${bowlerName}" ?? '',
                              style: interBoldSmall.copyWith(color: MyColor.getTextColor1()),
                            ),
                            Text(
                              "${bowlerOvers}-${bowlerWickets}-${bowlerRuns} -${bowlerMaidens}" ?? '',
                              style: interBoldSmall.copyWith(color: MyColor.getTextColor1()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

