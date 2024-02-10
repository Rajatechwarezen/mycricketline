class PointTable {
  final dynamic  teams;
  final dynamic flag;
  final dynamic p;
  final dynamic w;
  final dynamic l;
  final dynamic nr;
  final dynamic pts;
  final dynamic nrr;

  PointTable({
    required this.teams,
    required this.flag,
    required this.p,
    required this.w,
    required this.l,
    required this.nr,
    required this.pts,
    required this.nrr,
  });

  factory PointTable.fromJson(Map<String, dynamic> json) {
    return PointTable(
      teams: json['teams']??"",
      flag: json['flag']??"",
      p: json['P']??"",
      w: json['W']??"",
      l: json['L']??"",
      nr: json['NR']??"",
      pts: json['Pts']?? "",
      nrr: json['NRR'] ?? "",
    );
  }
}
