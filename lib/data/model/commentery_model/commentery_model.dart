class CricketMatch {
  Map<String, Inning> data;

  CricketMatch({required this.data});

  factory CricketMatch.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> dataJson = json['data'];
    Map<String, Inning> data = {};

    dataJson.forEach((key, value) {
      data[key] = Inning.fromJson(value);
    });

    return CricketMatch(data: data);
  }
}

class Inning {
  Map<String, List<Commentary1>> overs;

  Inning({required this.overs});

  factory Inning.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> oversJson = json;
    Map<String, List<Commentary1>> overs = {};

    oversJson.forEach((key, value) {
      List<Commentary1> commentaryList =
          (value as List).map((item) => Commentary1.fromJson(item)).toList();
      overs[key] = commentaryList;
    });

    return Inning(overs: overs);
  }
}

class Commentary1 {
  dynamic commentaryId;
  dynamic inning;
  dynamic type;
  Data data;

  Commentary1({
    required this.commentaryId,
    required this.inning,
    required this.type,
    required this.data,
  });

  factory Commentary1.fromJson(Map<String, dynamic> json) {
    return Commentary1(
      commentaryId: json['commentary_id'] ?? "",
      inning: json['inning'] ?? "",
      type: json['type'] ?? "",
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  dynamic title;
  dynamic over;
  dynamic runs;
  dynamic wickets;
  dynamic team;
  dynamic teamScore;
  dynamic teamWicket;
  dynamic batsman1Name;
  dynamic batsman1Runs;
  dynamic batsman1Balls;
  dynamic batsman2Name;
  dynamic batsman2Runs;
  dynamic batsman2Balls;
  dynamic bowlerName;
  dynamic bowlerOvers;
  dynamic bowlerMaidens;
  dynamic bowlerRuns;
  dynamic bowlerWickets;
  dynamic overs;
  dynamic wicket;
  dynamic description;

  Data({
    this.title,
    this.over,
    this.runs,
    this.wickets,
    this.team,
    this.teamScore,
    this.teamWicket,
    this.batsman1Name,
    this.batsman1Runs,
    this.batsman1Balls,
    this.batsman2Name,
    this.batsman2Runs,
    this.batsman2Balls,
    this.bowlerName,
    this.bowlerOvers,
    this.bowlerMaidens,
    this.bowlerRuns,
    this.bowlerWickets,
    this.overs,
    this.wicket,
    this.description,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      title: json['title'] ?? "",
      over: json['over'] ?? "",
      runs: json['runs'] ?? "",
      wickets: json['wickets'] ?? "",
      team: json['team'] ?? "",
      teamScore: json['team_score'] ?? "",
      teamWicket: json['team_wicket'] ?? "",
      batsman1Name: json['batsman_1_name'] ?? "",
      batsman1Runs: json['batsman_1_runs'] ?? "",
      batsman1Balls: json['batsman_1_balls'] ?? "",
      batsman2Name: json['batsman_2_name'] ?? "",
      batsman2Runs: json['batsman_2_runs'] ?? "",
      batsman2Balls: json['batsman_2_balls'] ?? "",
      bowlerName: json['bolwer_name'] ?? "",
      bowlerOvers: json['bolwer_overs'] ?? "",
      bowlerMaidens: json['bolwer_maidens'] ?? "",
      bowlerRuns: json['bolwer_runs'] ?? "",
      bowlerWickets: json['bolwer_wickets'] ?? "",
      overs: json['overs'] ?? "",
      wicket: json['wicket'] ?? "",
      description: json['description'] ?? "",
    );
  }
}
