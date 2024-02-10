class CricketMatchOdds {
  final dynamic matchOddId;
  final dynamic inning;
  final dynamic team;
  final dynamic score;
  final dynamic overs;
  final dynamic runs;
  final dynamic minRate;
  final dynamic maxRate;
  final dynamic sMin;
  final dynamic sMax;
  final dynamic dateTime;
  final dynamic time;

  CricketMatchOdds({
    required this.matchOddId,
    required this.inning,
    required this.team,
    required this.score,
    required this.overs,
    required this.runs,
    required this.minRate,
    required this.maxRate,
    required this.sMin,
    required this.sMax,
    required this.dateTime,
    required this.time,
  });

  factory CricketMatchOdds.fromJson(Map<String, dynamic> json) {
    return CricketMatchOdds(
      matchOddId: json['match_odd_id'] ?? " ",
      inning: json['inning'] ?? " ",
      team: json['team'] ?? " ",
      score: json['score'] ?? " ",
      overs: json['overs'] ?? " ",
      runs: json['runs'] ?? " ",
      minRate: json['min_rate'] ?? " ",
      maxRate: json['max_rate'] ?? " ",
      sMin: json['s_min'] ?? " ",
      sMax: json['s_max'] ?? " ",
      dateTime: json['date_time'] ?? " ",
      time: json['time'],
    );
  }
}
