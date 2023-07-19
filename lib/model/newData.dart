// ignore: file_names
class MyNews {
  final int newsId;
  final String title;
  final String description;
  final String image;
  final String pubDate;
  final List<String> content;

  MyNews({
    required this.newsId,
    required this.title,
    required this.description,
    required this.image,
    required this.pubDate,
    required this.content,
  });

  factory MyNews.fromJson(Map<String, dynamic> json) {
    final List<dynamic> contentJson = json['content'];
    return MyNews(
      newsId: json['news_id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      pubDate: json['pub_date'],
      // ignore: unnecessary_null_comparison
      content: contentJson != null ? List<String>.from(contentJson) : [],
    );
  }

  get key => null;
}
