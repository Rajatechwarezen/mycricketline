class PointTable {
  final String teams;
  final String flag;
  final String p;
  final String w;
  final String l;
  final String nr;
  final String pts;
  final String nrr;

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
      teams: json['teams'],
      flag: json['flag'],
      p: json['P'],
      w: json['W'],
      l: json['L'],
      nr: json['NR'],
      pts: json['Pts'],
      nrr: json['NRR'],
    );
  }
}
