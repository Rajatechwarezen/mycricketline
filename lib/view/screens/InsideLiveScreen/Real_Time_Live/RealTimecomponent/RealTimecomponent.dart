
  import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprotbuzz/core/utilis/AllColor.dart';
import 'package:sprotbuzz/core/utilis/borderbox.dart';
import 'package:sprotbuzz/core/utilis/boxSpace.dart';

import '../../../../../core/utilis/my_color.dart';
import '../../../../../core/utilis/style.dart';
import '../../../../../data/model/real_time_model/RealTimeModel.dart';
import '../RealTimeLiveScreen.dart';



///parse Data 
DateTime parseMatchDateTime(String matchDate, String matchTime) {
  final parsedDate = DateFormat('dd-MMM').parse(matchDate);
  final now = DateTime.now();
  final parsedTime = DateFormat('hh:mm a').parse(matchTime);

  final matchDateTime = DateTime(
    now.year,
    parsedDate.month,
    parsedDate.day,
    parsedTime.hour,
    parsedTime.minute,
  );

  return matchDateTime;
}

//calculateRemainingSeconds 


int calculateRemainingSeconds(DateTime matchDateTime) {
  final now = DateTime.now();
  final difference = matchDateTime.difference(now);
  final remainingSeconds = difference.inSeconds;
  return remainingSeconds > 0 ? remainingSeconds : 0;
}

//counter 

class CountdownTimerWidget extends StatefulWidget {
   int totalSeconds = 13;

   CountdownTimerWidget({super.key, required this.totalSeconds});

  @override
  _CountdownTimerWidgetState createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  late Timer _timer;
  int _currentSeconds = 0;

  @override
  void initState() {
    super.initState();
    _currentSeconds = widget.totalSeconds;
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentSeconds > 0) {
          _currentSeconds--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  String formatTime(int seconds) {
    int remainingSeconds = seconds % (24 * 60 * 60);
    int hours = remainingSeconds ~/ (60 * 60);
    remainingSeconds = remainingSeconds % (60 * 60);
    int minutes = remainingSeconds ~/ 60;
    remainingSeconds = remainingSeconds % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: boRadiusAll,
        color: MyColor.mycolorGolden
        
      ),
      child: Text(
        formatTime(_currentSeconds),
        style:interBoldExtraLarge.copyWith(color: MyColor.getBottomNavBg() ),
      ),
    );
  }
}


ScoresBox(value, ScoreType) {
  return Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.all(2),
    padding: const EdgeInsets.all(2),
    height: 50,
    width: 70,
    decoration: BoxDecoration(
      borderRadius: boRadius5,
      border: border,
      color: ScoreType == "A"
          ?  MyColor.getBorderColor() 
          :  MyColor.myprimaryColor,
    ),
    child: Text(value.toString(),
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: MyColor.getTextColor1())),
  );
}



Widget buildDataRow(String label, String? value) {
  return Expanded(
    child: Row(
      children: [
        Text("$label: ",
          style: interLightSmall.copyWith(color: MyColor.getTextFieldHintColor()),
        ),
        Text(value ?? "N/A",
          style: interLightSmall.copyWith(color: MyColor.getTextFieldHintColor()),
        ),
      ],
    ),
  );
}


Widget last24Balls(List<OverStats>? lastBall, String? liveOver) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (lastBall != null)
          for (var ball in lastBall.reversed)
            Row(
              children: [
                OverCard(
                  screenWidth: 80,
                  child: Text('Over ${ball.ballOver} ', style: interSemiBoldSmall.copyWith(color: MyColor.getTextColor())),
                ),
                for (var balls in ball.ball)
                  OverCard(
                    colors:  balls == 'w'
                            ? Colors.red
                            : balls == '4'
                                ? Colors.green
                                : balls == '6'
                                    ? Colors.blue
                                    :null,
                    border: border,
                    screenWidth: 46,
                    child: Text(
                      balls != 'w' && balls != '4' && balls != '6'
                          ? '$balls'
                          : balls,
                      style: interSemiBoldSmall.copyWith(color: MyColor.getTextColor()),
                    ),
                  ),
                Text('= ${ball.run}', style: interSemiBoldSmall.copyWith(color: MyColor.getTextColor())),
                size10w,
                 Container(color: MyColor.mycolorWhite, width: 1, height: 14),  ],
            ),
      ],
    ),
  );
}


cardBoxUi({Widget? child, screenWidth}) {
  return Container(
    padding: const EdgeInsets.all(5),
    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
    decoration: BoxDecoration(
        color: MyColor.getCardBg(), borderRadius: boRadiusAll, border: border),
    child: child!,
    width: screenWidth * 0.9,
  );
}



OverCard({Widget? child, screenWidth ,Color? colors ,border}) {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.all(3),
    margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
    decoration: BoxDecoration(
        color:  colors, borderRadius: BorderRadius.circular(100), border: border),
    child: child!,
    width: screenWidth * 0.9,
  );
}

