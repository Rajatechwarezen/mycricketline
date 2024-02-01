class TrendingSeries{
  bool status;
  String msg;
  List<SeriesData> data;

  TrendingSeries({required this.status, required this.msg, required this.data});

  factory TrendingSeries.fromJson(Map<String, dynamic> json) {
    return TrendingSeries(
      status: json['status'],
      msg: json['msg'],
      data: List<SeriesData>.from(json['data'].map((seriesData) => SeriesData.fromJson(seriesData))),
    );
  }
}

class SeriesData {
  int seriesId;
  String series;
  String seriesDate;
  int totalMatches;
  String startDate;
  String endDate;
  String image;
  String monthWise;

  SeriesData({
    required this.seriesId,
    required this.series,
    required this.seriesDate,
    required this.totalMatches,
    required this.startDate,
    required this.endDate,
    required this.image,
    required this.monthWise,
  });

  factory SeriesData.fromJson(Map<String, dynamic> json) {
    return SeriesData(
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
