class LiveMatchHome   {
  final int matchId;
  final String series;
  final String matchDate;
  final String matchTime;
  final String matchType;
  final String matchStatus;
  final String teamA;
  final String teamAShort;
  final String teamAImg;
  final String venue;
  final dynamic min;
  final dynamic max;
  final dynamic favTeam;
  final String teamAScore;
  final String teamAOver;
  final String teamB;
  final String teamBShort;
  final String teamBImg;
  final String teamBScore;
  final String teamBOver;

  LiveMatchHome({
    this.min,
    this.max,
    this.favTeam,
    required this.matchId,
    required this.series,
    required this.venue,
    required this.matchDate,
    required this.matchTime,
    required this.matchType,
    required this.matchStatus,
    required this.teamA,
    required this.teamAShort,
    required this.teamAImg,
    required this.teamAScore,
    required this.teamAOver,
    required this.teamB,
    required this.teamBShort,
    required this.teamBImg,
    required this.teamBScore,
    required this.teamBOver,
  });

  factory LiveMatchHome.fromJson(Map<String, dynamic> json) {
    return LiveMatchHome(
      favTeam: json["fav_team"] ?? "-",
      min: json["min_rate"] ?? "0",
      max: json['max_rate'] ?? "0",
      matchId: json['match_id'],
      venue: json['venue'],
      series: json['series'],
      matchDate: json['match_date'],
      matchTime: json['match_time'],
      matchType: json['match_type'],
      matchStatus: json['match_status'],
      teamA: json['team_a'],
      teamAShort: json['team_a_short'],
      teamAImg: json['team_a_img'],
      teamAScore: json['team_a_scores'],
      teamAOver: json['team_a_over'],
      teamB: json['team_b'],
      teamBShort: json['team_b_short'],
      teamBImg: json['team_b_img'],
      teamBScore: json['team_b_scores'],
      teamBOver: json['team_b_over'],
    );
  }
}

