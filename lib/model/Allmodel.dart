class ApiResponseBlog {
  List<Blog> data;

  ApiResponseBlog({required this.data});

  factory ApiResponseBlog.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<Blog> data = dataList.map((item) => Blog.fromJson(item)).toList();
    return ApiResponseBlog(data: data);
  }
}

class Blog {
  int id;
  String blTitle;
  String blDesc;
  String blImg;
  String createdOn;
  String modifyOn;

  Blog({
    required this.id,
    required this.blTitle,
    required this.blDesc,
    required this.blImg,
    required this.createdOn,
    required this.modifyOn,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      blTitle: json['bl_title'],
      blDesc: json['bl_desc'],
      blImg: json['bl_img'],
      createdOn: json['created_on'],
      modifyOn: json['modify_on'],
    );
  }
}
