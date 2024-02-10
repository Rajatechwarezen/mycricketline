import 'package:flutter/material.dart';



class ScoreParser {
  ScoreParser(context);

  static List<Map<String, dynamic>> parseScore(String scoreData) {
    List<Map<String, dynamic>> parsedScores = [];

    scoreData.split('&').forEach((score) {
      List<String> parts = score.trim().split('-');
      double value = double.parse(parts[0]);
      double formattedValue = double.parse(parts[1]);
      parsedScores.add({'': value, '': formattedValue});
    });

    return parsedScores;
  }
}
