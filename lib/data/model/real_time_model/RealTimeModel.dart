
class LiveMatchFull {
  final dynamic rRRate;
  final dynamic matchId;
  final dynamic minRate2;
  final dynamic maxRate2;
  final dynamic seriesId;
  final dynamic tvId;
  final dynamic matchOver;
  final dynamic minRate;
  final dynamic maxRate;
  final dynamic favTeam;
  final dynamic toss;
  final dynamic result;
  final dynamic matchType;
  final dynamic powerplay;
  final dynamic sOvr;
  final dynamic sMin;
  final dynamic sMax;
  final dynamic teamAId;
  final dynamic teamA;
  final dynamic teamAShort;
  final dynamic teamAImg;
  final dynamic teamBId;
  final dynamic teamB;
  final dynamic teamBShort;
  final dynamic teamBImg;
  final dynamic nextBatsman;
  final dynamic currentInning;
  final List<Batsman>? batsmen;
  final Bowler? bowler;
  final dynamic firstCircle;
  final dynamic secondCircle;
  final dynamic ballingTeam;
  final dynamic battingTeam;
  final TeamScore? teamAScore;
    final TeamScore? teamBScore;
  final dynamic teamAScores;
  final dynamic teamAOver;
  final List<TeamScoreOver>? teamAScoresOver;
    final List<TeamScoreOver>? teamBScoresOver;
  final dynamic lambiOvr;
  final dynamic lambiMin;
  final dynamic lambiMax;
  final dynamic target;
  final Partnership? partnership;
  final List<String>? yetToBet;
  final dynamic currRate;
  final List<OverStats>? last4Overs;
  final List<String>? last36Ball;
  final dynamic session;
  final dynamic runneed;
  final dynamic teamBScores;
  final dynamic teamBover;
final   LastWicket?  lastWicket;
  LiveMatchFull(
      {this.target,
      this.matchId,
      this.minRate2,
      this.maxRate2,
      this.seriesId,
      this.tvId,
      this.matchOver,
      this.minRate,
      this.maxRate,
      this.favTeam,
      this.toss,
      this.result,
      this.matchType,
      this.powerplay,
      this.sOvr,
      this.sMin,
      this.sMax,
      this.teamAId,
      this.teamA,
      this.teamAShort,
      this.teamAImg,
      this.teamBId,
      this.teamB,
      this.teamBShort,
      this.teamBImg,
      this.nextBatsman,
      this.currentInning,
      this.batsmen,
      this.bowler,
      this.firstCircle,
      this.secondCircle,
      this.ballingTeam,
      this.battingTeam,
      this.teamAScore,
      this.teamAScores,
      this.teamBScore,
      this.teamAOver,
      this.teamAScoresOver,
      this.teamBScoresOver,
      this.lambiOvr,
      this.lambiMin,
      this.lambiMax,
      this.partnership,
      this.yetToBet,
      this.currRate,
      this.last4Overs,
      this.last36Ball,
      this.session,
      this.rRRate,
      this.teamBScores,
      this.teamBover,
      this.lastWicket,
      this.runneed});

  factory LiveMatchFull.fromJson(Map<String, dynamic>? json) {

    return LiveMatchFull(
        runneed: json?["run_need"] ?? "",
        rRRate: json?["rr_rate"] ?? "",
        target: json?["target"] ?? "",
        matchId: json?['match_id'] ?? "",
        seriesId: json?['series_id'] ?? "",
        tvId: json?['tv_id'] ?? "",
        matchOver: json?['match_over'] ?? "",
        minRate: json?['min_rate'] ?? "",
        maxRate: json?['max_rate'] ?? "",
        favTeam: json?['fav_team'] ?? "",
        toss: json?['toss'] ?? "",
        minRate2: json?["min_rate_2"] ?? "",
        maxRate2: json?["max_rate_2"] ?? "",
        result: json?['result'] ?? "",
        matchType: json?['match_type'] ?? "",
        powerplay: json?['powerplay'] ?? "",
        sOvr: json?['s_ovr'] ?? "",
        sMin: json?['s_min'] ?? "",
        sMax: json?['s_max'] ?? "",
        teamAId: json?['team_a_id'] ?? "",
        teamA: json?['team_a'] ?? "",
        teamAShort: json?['team_a_short'] ?? "",
        teamAImg: json?['team_a_img'] ?? "",
        teamBId: json?['team_b_id'] ?? "",
        teamB: json?['team_b'] ?? "",
        teamBScores: json?['team_b_scores'] ??"",
        teamBScore:  TeamScore.fromJson(json?['team_b_score']) ,
        teamBover: json?['team_b_over'] ??"",
        teamBShort: json?['team_b_short'] ?? "",
        teamBImg: json?['team_b_img'] ?? "",
        nextBatsman: json?['next_batsman'] ??"",
        currentInning: json?['current_inning'] ?? "",
        batsmen: (json?['batsman'] as List<dynamic>?)
            ?.map((x) => Batsman.fromJson(x))
            .toList(),
        bowler: Bowler.fromJson(json?['bolwer']),
        firstCircle: json?['first_circle'] ?? "",
        secondCircle: json?['second_circle'] ?? "",
        ballingTeam: json?['balling_team'] ?? "",
        battingTeam: json?['batting_team'] ?? "",
        teamAScore: TeamScore.fromJson(json?['team_a_score']),
        teamAScores: json?['team_a_scores'],
        teamAOver: json?['team_a_over'] ?? "",
        teamAScoresOver: (json?['team_a_scores_over'] as List<dynamic>?)
            ?.map((x) => TeamScoreOver.fromJson(x))
            .toList(),

            teamBScoresOver:(json?['team_b_scores_over'] as List<dynamic>?)
            ?.map((x) => TeamScoreOver.fromJson(x))
            .toList(),
        lambiOvr: json?['lambi_ovr'] ?? "",
        lambiMin: json?['lambi_min'] ?? "",
        lambiMax: json?['lambi_max'] ?? "",
        partnership: Partnership.fromJson(json?['partnership']),
        yetToBet: (json?['yet_to_bet'] as List<dynamic>?)?.cast<String>(),
        currRate: json?['curr_rate'] ?? "",
        last4Overs: (json?['last4overs'] as List<dynamic>?)
            ?.map((x) => OverStats.fromJson(x))
            .toList(),
        last36Ball: (json?['last36ball'] as List<dynamic>?)?.cast<String>(),
        lastWicket: json != null && json['lastwicket'] != null
    ? LastWicket.fromJson(json['lastwicket'])
    : null,
        session: json?['session'] ?? "");
        
  }
}

class Batsman {
  final dynamic name;
  final dynamic run;
  final dynamic ball;
  final dynamic fours;
  final dynamic sixes;
  final dynamic strikeRate;

  Batsman({
    this.name,
    this.run,
    this.ball,
    this.fours,
    this.sixes,
    this.strikeRate,
  });

  factory Batsman.fromJson(Map<String, dynamic>? json) {
    return Batsman(
      name: json?['name' ?? ""],
      run: json?['run'] ?? "",
      ball: json?['ball'] ?? "",
      fours: json?['fours'] ?? "",
      sixes: json?['sixes'] ?? "",
      strikeRate: json?['strike_rate'] ?? "",
    );
  }
}

class Bowler {
  final dynamic name;
  final dynamic run;
  final dynamic over;
  final dynamic wicket;
  final dynamic economy;
  final dynamic maidens;

  Bowler(
      {this.name,
      this.run,
      this.over,
      this.wicket,
      this.economy,
      this.maidens});

  factory Bowler.fromJson(Map<String, dynamic>? json) {
    return Bowler(
        name: json?['name'] ?? "",
        run: json?['run'] ?? "",
        over: json?['over'] ?? "",
        wicket: json?['wicket'] ?? "",
        economy: json?['economy'] ?? "",
        maidens: json?['maidens'] ?? "0");
  }
}

class TeamScore {
  final dynamic score;
  final dynamic wicket;
  final dynamic ball;
final dynamic over;
  TeamScore({
    this.score,
    this.wicket,
    this.ball,
    this.over
  });

  factory TeamScore.fromJson(Map<String, dynamic>? json) {
    return TeamScore(
      score: json?['score'] ?? "",
      wicket: json?['wicket'] ?? "",
      ball: json?['ball'] ?? "",
      over:json?["over"] ?? " "
    );
  }
}

class TeamScoreOver {
  final dynamic score;
  final dynamic over;

  TeamScoreOver({
    this.score,
    this.over,
  });

  factory TeamScoreOver.fromJson(Map<String, dynamic>? json) {
    return TeamScoreOver(
      score: json?['score'] ?? "",
      over: json?['over'] ?? "",
    );
  }
}

class Partnership {
  final dynamic runs;
  final dynamic balls;
  final dynamic wicket;

  Partnership({
    this.runs,
    this.balls,
    this.wicket,
  });

  factory Partnership.fromJson(Map<String, dynamic>? json) {
    return Partnership(
      runs: json?['run'] ?? "",
      balls: json?['ball'] ?? "",
      wicket: json?['wicket'] ?? "",
    );
  }
}

class OverStats {
  final dynamic ballOver;
  final dynamic ball;

  final dynamic run;

  OverStats({
    this.ballOver,
    this.ball,
    this.run,
  });

  factory OverStats.fromJson(Map<String, dynamic>? json) {
    return OverStats(
      ballOver: json?['over'] ?? "",
     ball: List<String>.from(json?['balls']),
      run: json?['runs'] ?? "",
    );
  }
}





class LastWicket {
  final dynamic player;
  final dynamic run;
  final dynamic ball;

  LastWicket({
    required this.player,
    required this.run,
    required this.ball,
  });

  factory LastWicket.fromJson(Map<String, dynamic> json) {
    return LastWicket(
      player: json['player'],
      run: json['run'],
      ball: json['ball'],
    );
  }
}
