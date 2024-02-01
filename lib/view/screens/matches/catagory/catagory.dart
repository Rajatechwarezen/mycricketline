
//T20
import 'package:flutter/material.dart';
import 'package:sprotbuzz/core/utilis/boxSpace.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/core/utilis/style.dart';
import 'package:sprotbuzz/view/component/divider/custom_divider.dart';
import 'package:sprotbuzz/view/screens/InsideLiveScreen/Real_Time_Live/RealTimecomponent/RealTimecomponent.dart';

import '../../../../core/utilis/borderbox.dart';
import '../../home/home_page_componet/carousel/widget/Widget.dart';

// List<Widget> T20MatchItem(matches, context, screenWidth, themeProvider) {
//   return matches
//       .where((match) => match.matchType == "T20")
//       .map<Widget>((match) {
//     final matchDateTime = parseMatchDateTime(
//         match.matchDate.toString(), match.matchTime.toString());
//     final remainingSeconds = calculateRemainingSeconds(matchDateTime);

//     return InkWell(
//       onTap: () {
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(
//         //     builder: (context) => OnlinelineLiveTabTab(
//         //       idMatch: match.matchId,
//         //       type: "Upcoming",
//         //       data: const ["", "", "", ""],
//         //     ),
//         //   ),
//         // );
//       },
//       child: Container(
//         width: screenWidth * 2,
//         height: 220,
//         margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         decoration: BoxDecoration(
//           color:MyColor.getCardBg(),
//           border: border,
//           borderRadius: BorderRadius.circular(10),
          
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 10, top: 5),
//               child: Row(
//                 children: [
//                   Text(
//                     'Upcoming',
//                  style:interBoldDefault.copyWith(color: MyColor.getTextColor()),
                
//                   ),
//                  size10w,
//                   Expanded(
//                     flex: 1,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           truncateText(match.series.toString(), 30),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(fontSize: 9),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           child: Text(
//                               "${match.matchTime.toString()} : ${match.matchDate.toString()}"),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//            CustomDivider(),
//             // Row of team 1
//             Row(
//               children: [
//                 size10w,
//                 Expanded(
//                   flex: 3,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       teamheadingscore2(
//                         teamAImg: match.teamAImage,
//                         teamBImg: match.teamBImage,
//                         teamName: match.teamAShort,
//                         teamName2: match.teamBShort,
//                         teamScore: "-",
//                         teamScore2: "-",
//                         teamOver: '-',
//                         teamType: match.matchType,
//                         matchTime: match.matchTime,
//                         teamOver2: "-",
//                       ),
//                     ],
//                   ),
//                 ),
//                 size10w,
//               ],
//             ),
//            CustomDivider(),
//             Row(
//               children: [
//                 Row(
//                   children: [
//                     size10w,
//                     //Aw -

//                     const Text("Match Timing Left"),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10, top: 10),
//                       child: Container(
//                         width: 100,
//                         decoration: BoxDecoration(
//                           borderRadius:boRadiusAll,
//                           border: border,
//                         ),
//                         child: Center(
//                           child: CountdownTimerWidget(
//                             totalSeconds: remainingSeconds,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),

//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10, top: 10),
//                   child: Text(
//                     truncateText(match.venue.toString(), 60),
//                    style:interBoldDefault.copyWith(color: MyColor.getTextColor()),
                
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }).toList();
// }

// //Test

// List<Widget> TestchItem(matches, context, screenWidth, themeProvider) {
//   return matches
//       .where((match) => match.matchType == "Test")
//       .map<Widget>((match) {
//     final matchDateTime = parseMatchDateTime(
//         match.matchDate.toString(), match.matchTime.toString());
//     final remainingSeconds = calculateRemainingSeconds(matchDateTime);

//     return InkWell(
//       onTap: () {
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(
//         //     builder: (context) => OnlinelineLiveTabTab(
//         //       idMatch: match.matchId,
//         //       type: "Upcoming",
//         //       data: const ["", "", "", ""],
//         //     ),
//         //   ),
//        // );
//       },
//       child: Container(
//         width: screenWidth * 2,
//         height: 220,
//         margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         decoration: BoxDecoration(
//           color: MyColor.getCardBg(),
//           border: border,
//           borderRadius: BorderRadius.circular(10),
        
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 10, top: 5),
//               child: Row(
//                 children: [
//                   Text(
//                     'Upcoming',
//                     style: interBoldDefault.copyWith(color: MyColor.getTextColor()),
//                   ),
//                   size10h,
//                   Expanded(
//                     flex: 1,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           truncateText(match.series.toString(), 30),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(fontSize: 9),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           child: Text(
//                               "${match.matchTime.toString()} : ${match.matchDate.toString()}"),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             CustomDivider(
//                      ),
//             // Row of team 1
//             Row(
//               children: [
//               size10w,
//                 Expanded(
//                   flex: 3,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       teamheadingscore2(
//                         teamAImg: match.teamAImage,
//                         teamBImg: match.teamBImage,
//                         teamName: match.teamAShort,
//                         teamName2: match.teamBShort,
//                         teamScore: "-",
//                         teamScore2: "-",
//                         teamOver: '-',
//                         teamType: match.matchType,
//                         matchTime: match.matchTime,
//                         teamOver2: "-",
//                       ),
//                     ],
//                   ),
//                 ),
//                size10w
//               ],
//             ),
//             CustomDivider(),
//             Row(
//               children: [
//                 Row(
//                   children: [
//                     size10w,
//                     //Aw -

//                     const Text("Match Timing Left"),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10, top: 10),
//                       child: Container(
//                         width: 100,
//                         decoration: BoxDecoration(
//                           borderRadius:boRadiusAll,
//                           border: border,
//                         ),
//                         child: Center(
//                           child: CountdownTimerWidget(
//                             totalSeconds: remainingSeconds,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),

//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10, top: 10),
//                   child: Text(
//                     truncateText(match.venue.toString(), 60),
//                     style: interBoldDefault.copyWith(color: MyColor.getTextColor()),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }).toList();
// }

// //ODI

// List<Widget> ODIchItem(matches, context, screenWidth, themeProvider) {
//   return matches
//       .where((match) => match.matchType == "ODI")
//       .map<Widget>((match) {
//     final matchDateTime = parseMatchDateTime(
//         match.matchDate.toString(), match.matchTime.toString());
//     final remainingSeconds = calculateRemainingSeconds(matchDateTime);

//     return InkWell(
//       onTap: () {
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(
//         //     builder: (context) => OnlinelineLiveTabTab(
//         //       idMatch: match.matchId,
//         //       type: "Upcoming",
//         //       data: const ["", "", "", ""],
//         //     ),
//         //   ),
//         // );
//       },
//       child: Container(
//         width: screenWidth * 2,
//         height: 220,
//         margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         decoration: BoxDecoration(
//           color: MyColor.getTextColor(),
//           border: border,
//           borderRadius: BorderRadius.circular(10),
         
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 10, top: 5),
//               child: Row(
//                 children: [
//                   Text(
//                     'Upcoming',
//                     style: interBoldDefault.copyWith(color: MyColor.getTextColor()),
//                   ),
//                   size10w,
//                   Expanded(
//                     flex: 1,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           truncateText(match.series.toString(), 30),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(fontSize: 9),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           child: Text(
//                               "${match.matchTime.toString()} : ${match.matchDate.toString()}"),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             CustomDivider(
           
//             ),
//             // Row of team 1
//             Row(
//               children: [
//                 size10w,
//                 Expanded(
//                   flex: 3,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       teamheadingscore2(
//                         teamAImg: match.teamAImage,
//                         teamBImg: match.teamBImage,
//                         teamName: match.teamAShort,
//                         teamName2: match.teamBShort,
//                         teamScore: "-",
//                         teamScore2: "-",
//                         teamOver: '-',
//                         teamType: match.matchType,
//                         matchTime: match.matchTime,
//                         teamOver2: "-",
//                       ),
//                     ],
//                   ),
//                 ),
//                 size10w
//               ],
//             ),
//            CustomDivider() ,
//             Row(
//               children: [
//                 Row(
//                   children: [
//                     size10w,
//                     //Aw -

//                     const Text("Match Timing Left"),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10, top: 10),
//                       child: Container(
//                         width: 100,
//                         decoration: BoxDecoration(
//                           borderRadius:boRadiusAll,
//                           border: border,
//                         ),
//                         child: Center(
//                           child: CountdownTimerWidget(
//                             totalSeconds: remainingSeconds,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),

//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10, top: 10),
//                   child: Text(
//                     truncateText(match.venue.toString(), 60),
//                     style:interBoldDefault.copyWith(color: MyColor.getTextColor()),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }).toList();
// }
