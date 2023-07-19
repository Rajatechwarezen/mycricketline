class Upcomingdata {
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

  Upcomingdata({
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

  factory Upcomingdata.fromJson(Map<String, dynamic> json) {
    return Upcomingdata(
      matchId: json['match_id'] as int?,
      seriesId: json['series_id'] as int?,
      series: json['series'] as String?,
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
