class InfoData {
  final dynamic tvId;
  final dynamic seriesId;
  final dynamic series;
  final dynamic match;
  final dynamic matchDate;
  final dynamic matchTime;
  final dynamic venue;
  final dynamic toss;
  final dynamic umpire;
  final dynamic thirdUmpire;
  final dynamic referee;
  final dynamic manOfMatch;
  final dynamic matchType;
  final dynamic teamAId;
  final dynamic teamA;
  final dynamic teamAShort;
  final dynamic teamAImg;
  final dynamic teamBId;
  final dynamic teamB;
  final dynamic teamBShort;
  final dynamic teamBImg;

  InfoData({
    required this.tvId,
    required this.seriesId,
    required this.series,
    required this.match,
    required this.matchDate,
    required this.matchTime,
    required this.venue,
    required this.toss,
    required this.umpire,
    required this.thirdUmpire,
    required this.referee,
    required this.manOfMatch,
    required this.matchType,
    required this.teamAId,
    required this.teamA,
    required this.teamAShort,
    required this.teamAImg,
    required this.teamBId,
    required this.teamB,
    required this.teamBShort,
    required this.teamBImg,
  });

  factory InfoData.fromJson(Map<String, dynamic> json) {
    return InfoData(
      tvId: json['tv_id'],
      seriesId: json['series_id'],
      series: json['series'],
      match: json['matchs'],
      matchDate: json['match_date'],
      matchTime: json['match_time'],
      venue: json['venue'],
      toss: json['toss'],
      umpire: json['umpire'],
      thirdUmpire: json['third_umpire'],
      referee: json['referee'],
      manOfMatch: json['man_of_match'],
      matchType: json['match_type'],
      teamAId: json['team_a_id'],
      teamA: json['team_a'],
      teamAShort: json['team_a_short'],
      teamAImg: json['team_a_img'],
      teamBId: json['team_b_id'],
      teamB: json['team_b'],
      teamBShort: json['team_b_short'],
      teamBImg: json['team_b_img'],
    );
  }
}
