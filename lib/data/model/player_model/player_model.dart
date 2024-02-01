class MatchData {
  TeamData teamA;
  TeamData teamB;

  MatchData({required this.teamA, required this.teamB});

  factory MatchData.fromJson(Map<String, dynamic> json) {
    return MatchData(
      teamA: TeamData.fromJson(json["data"]['team_a'] ?? {}),
      teamB: TeamData.fromJson(json["data"]['team_b'] ?? {}),
    );
  }
}

class TeamData {
  dynamic name;
  dynamic shortName;
  dynamic flag;
  List<PlayerData> players;

  TeamData({
    required this.name,
    required this.shortName,
    required this.flag,
    required this.players,
  });

  factory TeamData.fromJson(Map<String, dynamic> json) {
    return TeamData(
      name: json['name'],
      shortName: json['short_name'],
      flag: json['flag'],
      players: json['player'] != null
          ? List<PlayerData>.from(
              json['player']!.map((player) => PlayerData.fromJson(player)),
            )
          : [],
    );
  }
}

class PlayerData {
  String playerId;
  String name;
  String playRole;
  String image;

  PlayerData({
    required this.playerId,
    required this.name,
    required this.playRole,
    required this.image,
  });

  factory PlayerData.fromJson(Map<String, dynamic> json) {
    return PlayerData(
      playerId: json['player_id'],
      name: json['name'],
      playRole: json['play_role'],
      image: json['image'],
    );
  }
}
