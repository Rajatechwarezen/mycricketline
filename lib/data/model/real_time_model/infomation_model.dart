class InfoData {
  final dynamic tvId;
  final dynamic seriesId;
  final dynamic venueid;
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
  final dynamic dateWise;
  final dynamic matchType;
  final dynamic teamAId;
  final dynamic teamA;
  final dynamic teamAShort;
  final dynamic teamAImg;
  final dynamic teamBId;
  final dynamic teamB;
  final dynamic teamBShort;
  final dynamic teamBImg;
 final VenueWeather venueWeather;
  InfoData({
    required this.venueid,
    required this.dateWise,
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
    required this.venueWeather
  });

  factory InfoData.fromJson(Map<String, dynamic> json) {
    return InfoData(
      venueid: json["venue_id"],
      venueWeather:VenueWeather.fromJson(json["venue_weather"]),
      dateWise: json["date_wise"],
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



class VenueWeather {
  final dynamic tempC;
  final dynamic tempF;
  final dynamic weather;
  final dynamic weatherIcon;
  final dynamic windMph;
  final dynamic windKph;
  final dynamic windDir;
  final dynamic humidity;
  final dynamic cloud;

  VenueWeather({
    required this.tempC,
    required this.tempF,
    required this.weather,
    required this.weatherIcon,
    required this.windMph,
    required this.windKph,
    required this.windDir,
    required this.humidity,
    required this.cloud,
  });

  factory VenueWeather.fromJson(Map<String, dynamic> json) {
    print("{===========================$json}");
    return VenueWeather(
      tempC: json['temp_c'],
      tempF: json['temp_f'],
      weather: json['weather'],
      weatherIcon: json['weather_icon'],
      windMph: json['wind_mph'],
      windKph: json['wind_kph'],
      windDir: json['wind_dir'],
      humidity: json['humidity'],
      cloud: json['cloud'],
    );
  }
}
