class AdData {
  final int id;
  final String adName;
  final String adImg;
  final String adUrl;

  AdData({
    required this.id,
    required this.adName,
    required this.adImg,
    required this.adUrl,
  });

  factory AdData.fromJson(Map<String, dynamic> json) {
    return AdData(
      id: json['id'],
      adName: json['ad_name'],
      adImg: json['ad_img'],
      adUrl: json['ad_url'],
    );
  }
}
