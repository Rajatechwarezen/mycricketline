class FinishData {
  final int matchId;
  final int seriesId;
  final String series;
  final String dateWise;
  final String matchDate;
  final String matchTime;
  final String match;
  final String venue;
  final String matchType;
  final String result;
  final int teamAId;
  final String teamA;
  final String teamAShort;
  final String teamAImg;
  final String teamAScores;
  final String teamAOver;
  final String teamAScore;
  final String teamBScore;
  final int teamBId;
  final String teamB;
  final String teamBShort;
  final String teamBImg;
  final String teamBScores;
  final String teamBOver;

  FinishData({
    required this.matchId,
    required this.seriesId,
    required this.series,
    required this.dateWise,
    required this.matchDate,
    required this.matchTime,
    required this.match,
    required this.venue,
    required this.matchType,
    required this.result,
    required this.teamAId,
    required this.teamA,
    required this.teamAShort,
    required this.teamAImg,
    required this.teamAScores,
    required this.teamBScore,
    required this.teamAScore,
    required this.teamAOver,
    required this.teamBId,
    required this.teamB,
    required this.teamBShort,
    required this.teamBImg,
    required this.teamBScores,
    required this.teamBOver,
  });

  factory FinishData.fromJson(Map<String, dynamic> json) {
    return FinishData(
      matchId: json['match_id'],
      seriesId: json['series_id'],
      series: json['series'],
      dateWise: json['date_wise'],
      matchDate: json['match_date'],
      matchTime: json['match_time'],
      match: json['matchs'],
      venue: json['venue'],
      matchType: json['match_type'],
      result: json['result'],
      teamAId: json['team_a_id'],
      teamA: json['team_a'],
      teamAShort: json['team_a_short'],
      teamAImg: json['team_a_img'],
      teamAScores: json['team_a_scores'],
      teamAScore: json['team_a_scores'],
      teamBScore: json['team_b_scores'],
      teamAOver: json['team_a_over'],
      teamBId: json['team_b_id'],
      teamB: json['team_b'],
      teamBShort: json['team_b_short'],
      teamBImg: json['team_b_img'],
      teamBScores: json['team_b_scores'],
      teamBOver: json['team_b_over'],
    );
  }
}

class ImageShotData {
  final dynamic id;
  final dynamic image;
  late final dynamic userslike;
  final dynamic usershare;
  final dynamic userstatus;

  ImageShotData({
    required this.id,
    required this.image,
    required this.userslike,
    required this.usershare,
    required this.userstatus,
  });

  factory ImageShotData.fromJson(Map<String, dynamic> json) {
    return ImageShotData(
      id: json['id'] ?? "-",
      image: json['image'] ?? "-",
      userslike: json['userslike'] ?? "-",
      usershare: json['usershare'] ?? "-",
      userstatus: json['userstatus'] ?? "-",
    );
  }
}
