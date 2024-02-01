import 'package:flutter/src/material/data_table.dart';

class ScoreData {
  Scorecard? data;
  String? result;
  ScoreData({required this.data, required this.result});

  factory ScoreData.fromJson(Map<String, dynamic> json) {
    return ScoreData(
      data: Scorecard.fromJson(json['data']?["scorecard"] ?? {"0": "0"}),
      result: json['data']?["result"] ?? " ",
    );
  }

  map(DataRow Function(dynamic batsman) param0) {}
}

class Scorecard {
  MatchData1 team1;
  MatchData1 team2;
  MatchData1 team3;
  MatchData1 team4;
  Scorecard(
      {required this.team1,
      required this.team2,
      required this.team3,
      required this.team4});

  factory Scorecard.fromJson(Map<String, dynamic> json) {
    return Scorecard(
      team1: MatchData1.fromJson(json['1'] ?? {"nodata": "0"}),
      team2: MatchData1.fromJson(json['2'] ?? {"nodata": "0"}),
      team3: MatchData1.fromJson(json['3'] ?? {"nodata": "0"}),
      team4: MatchData1.fromJson(json['4'] ?? {"nodata": "0"}),
    );
  }
}

class MatchData1 {
  TeamData team;
  List<BatsmanData> batsman;
  List<BowlerData> bolwer;
  List<FallWicketData> fallwicket;

  MatchData1({
    required this.team,
    required this.batsman,
    required this.bolwer,
    required this.fallwicket,
  });

  factory MatchData1.fromJson(Map<String, dynamic> json) {
    return MatchData1(
      team: TeamData.fromJson(json['team'] ?? {}),
      batsman: (json['batsman'] as List<dynamic>?)
              ?.map((batJson) => BatsmanData.fromJson(batJson))
              .toList() ??
          [],
      bolwer: (json['bolwer'] as List<dynamic>?)
              ?.map((bowlJson) => BowlerData.fromJson(bowlJson))
              .toList() ??
          [],
      fallwicket: (json['fallwicket'] as List<dynamic>?)
              ?.map((fallJson) => FallWicketData.fromJson(fallJson))
              .toList() ??
          [],
    );
  }
}

class TeamData {
  dynamic teamId;
  dynamic name;
  dynamic shortName;
  dynamic flag;
  dynamic score;
  dynamic wicket;
  dynamic over;
  dynamic extras;

  TeamData({
    this.teamId,
    this.name,
    this.shortName,
    this.flag,
    this.score,
    this.wicket,
    this.over,
    this.extras,
  });

  factory TeamData.fromJson(Map<String, dynamic> json) {
    return TeamData(
      teamId: json['team_id'] ?? "nodata",
      name: json['name'] ?? "nodata",
      shortName: json['short_name'] ?? "nodata",
      flag: json['flag'] ?? "nodata",
      score: json['score'] ?? "nodata",
      wicket: json['wicket'] ?? "nodata",
      over: json['over'] ?? "nodata",
      extras: json['extras'] ?? "nodata",
    );
  }
}

class BatsmanData {
  dynamic layerId;
  dynamic name;
  dynamic run;
  dynamic ball;
  dynamic fours;
  dynamic sixes;
  dynamic strikeRate;
  dynamic outBy;

  BatsmanData({
    this.layerId,
    this.name,
    this.run,
    this.ball,
    this.fours,
    this.sixes,
    this.strikeRate,
    this.outBy,
  });

  factory BatsmanData.fromJson(Map<String, dynamic> json) {
    return BatsmanData(
      layerId: json['layer_id'],
      name: json['name'] ?? "nodata",
      run: json['run'] ?? "nodata",
      ball: json['ball'] ?? "nodata",
      fours: json['fours'] ?? "nodata",
      sixes: json['sixes'] ?? "nodata",
      strikeRate: json['strike_rate'] ?? "nodata",
      outBy: json['out_by'] ?? "nodata",
    );
  }
}

class BowlerData {
  dynamic playerId;
  dynamic name;
  dynamic over;
  dynamic maiden;
  dynamic run;
  dynamic wicket;
  dynamic economy;
  dynamic dotBall;

  BowlerData({
    this.playerId,
    this.name,
    this.over,
    this.maiden,
    this.run,
    this.wicket,
    this.economy,
    this.dotBall,
  });

  factory BowlerData.fromJson(Map<String, dynamic> json) {
    return BowlerData(
      playerId: json['player_id'] ?? "nodata",
      name: json['name'] ?? "nodata",
      over: json['over'] ?? "nodata",
      maiden: json['maiden'] ?? "nodata",
      run: json['run'] ?? "nodata",
      wicket: json['wicket'] ?? "nodata",
      economy: json['economy'] ?? "nodata",
      dotBall: json['dot_ball'] ?? "nodata",
    );
  }
}

class FallWicketData {
  dynamic player;
  dynamic score;
  dynamic wicket;
  dynamic over;

  FallWicketData({this.player, this.score, this.wicket, this.over});

  factory FallWicketData.fromJson(Map<String, dynamic> json) {
    return FallWicketData(
      player: json['player'] ?? "nodata",
      score: json['score'] ?? "nodata",
      wicket: json['wicket'] ?? "nodata",
      over: json['over'] ?? "nodata",
    );
  }
}
