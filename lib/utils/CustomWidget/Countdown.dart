import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mycricketline/utils/Style.dart';

import '../Color.dart';

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

int calculateRemainingSeconds(DateTime matchDateTime) {
  final now = DateTime.now();
  final difference = matchDateTime.difference(now);
  final remainingSeconds = difference.inSeconds;
  return remainingSeconds > 0 ? remainingSeconds : 0;
}

class CountdownTimerWidget extends StatefulWidget {
  final int totalSeconds;

  CountdownTimerWidget({required this.totalSeconds});

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
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: CustomStylesBorder.boderRadius10,
      ),
      child: Text(
        formatTime(_currentSeconds),
        style: CustomStyles.cardBoldDarkDrawerTextStyle,
      ),
    );
  }
}

class SimpleCounter extends StatefulWidget {
  const SimpleCounter({super.key, required this.totalSeconds});
  final int totalSeconds;

  @override
  State<SimpleCounter> createState() => _SimpleCounterState();
}

class _SimpleCounterState extends State<SimpleCounter> {
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
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: CustomStylesBorder.boderRadius10,
      ),
      child: Text(
        "Starts in:${formatTime(_currentSeconds)}",
        style: CustomStyles.cardBoldDarkroboto,
      ),
    );
  }
}
