class Series {
  final int seriesId;
  final String series;
  final String seriesDate;
  final int totalMatches;
  final String startDate;
  final String endDate;
  final String image;
  final String monthWise;

  Series({
    required this.seriesId,
    required this.series,
    required this.seriesDate,
    required this.totalMatches,
    required this.startDate,
    required this.endDate,
    required this.image,
    required this.monthWise,
  });

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      seriesId: json['series_id'],
      series: json['series'],
      seriesDate: json['series_date'],
      totalMatches: json['total_matches'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      image: json['image'],
      monthWise: json['month_wise'],
    );
  }
}

//////////////////////////
///
///
// this is MatchesBySeriesId by upcomming
class MatchesBySeriesId {
  int? matchId;
  int? seriesId;
  String? series;
  String? dateWise;
  String? matchDate;
  String? matchTime;
  String? matchGroup;
  String? venue;
  String? matchType;
  double? minRate;
  double? maxRate;
  String? favoriteTeam;
  int? teamAId;
  String? teamA;
  String? teamAShort;
  String? teamAImage;
  int? teamBId;
  String? teamB;
  String? teamBShort;
  String? teamBImage;

  MatchesBySeriesId({
    this.matchId,
    this.seriesId,
    this.series,
    this.dateWise,
    this.matchDate,
    this.matchTime,
    this.matchGroup,
    this.venue,
    this.matchType,
    this.minRate,
    this.maxRate,
    this.favoriteTeam,
    this.teamAId,
    this.teamA,
    this.teamAShort,
    this.teamAImage,
    this.teamBId,
    this.teamB,
    this.teamBShort,
    this.teamBImage,
  });

  factory MatchesBySeriesId.fromJson(Map<String, dynamic> json) {
    return MatchesBySeriesId(
      matchId: json['match_id'] as int?,
      dateWise: json['date_wise'] as String?,
      matchDate: json['match_date'] as String?,
      matchTime: json['match_time'] as String?,
      matchGroup: json['matchs'] as String?,
      venue: json['venue'] as String?,
      matchType: json['match_type'] as String?,
      minRate: json['min_rate'] != null ? double.parse(json['min_rate']) : null,
      maxRate: json['max_rate'] != null ? double.parse(json['max_rate']) : null,
      favoriteTeam: json['fav_team'] as String?,
      teamAId: json['team_a_id'] as int?,
      teamA: json['team_a'] as String?,
      teamAShort: json['team_a_short'] as String?,
      teamAImage: json['team_a_img'] as String?,
      teamBId: json['team_b_id'] as int?,
      teamB: json['team_b'] as String?,
      teamBShort: json['team_b_short'] as String?,
      teamBImage: json['team_b_img'] as String?,
    );
  }
}

class MatchesBySeriesFinish {
  final int? matchId;

  final String? series;
  final String? dateWise;
  final String? matchDate;
  final String? matchTime;
  final String? venue;
  final String? matchType;
  final String? result;
  final int? teamAId;
  final String? teamA;
  final String? teamAShort;
  final String? teamAImg;
  final String? teamAScores;
  final String? teamAOver;
  final String? teamAScore;
  final String? teamBScore;
  final int? teamBId;
  final String? teamB;
  final String? teamBShort;
  final String? teamBImg;
  final String? teamBScores;
  final String? teamBOver;

  MatchesBySeriesFinish({
    required this.matchId,
    required this.series,
    required this.dateWise,
    required this.matchDate,
    required this.matchTime,
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
  //  {
  //     "match_id": 3300,
  //     "series": "Major League Cricket 2023",
  //     "date_wise": "16 Jul 2023, Sunday",
  //     "match_date": "16-Jul",
  //     "match_time": "06:00 AM",
  //     "matchs": "4th Match",
  //     "venue": "Grand Prairie Stadium, Texas",
  //     "match_type": "T20",
  //     "result": "Seattle Orcas won by 35 runs",
  //     "team_a_id": 240,
  //     "team_a": "San Francisco Unicorns",
  //     "team_a_short": "SFU",
  //     "team_a_img": "http://cricketchampion.co.in/webroot/img/teams/1060088815_team.jpg",
  //     "team_a_scores": "142-10",
  //     "team_a_over": "17.5",
  //     "team_b_id": 237,
  //     "team_b": "Seattle Orcas",
  //     "team_b_short": "SOR",
  //     "team_b_img": "http://cricketchampion.co.in/webroot/img/teams/147043200_team.png",
  //     "team_b_scores": "177-4",
  //     "team_b_over": "20"
  //   },
  factory MatchesBySeriesFinish.fromJson(Map<String, dynamic> json) {
    return MatchesBySeriesFinish(
      matchId: json['match_id'],
      series: json['series'],
      dateWise: json['date_wise'],
      matchDate: json['match_date'],
      matchTime: json['match_time'],
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
