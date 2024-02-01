import 'dart:convert';

import 'package:get/get.dart';
import 'package:sprotbuzz/data/repo/blog_repo/blog_repo.dart';

import '../../model/blog_model/blog_model.dart';
import '../../servies/api_service.dart';

class BlogController extends GetxController {
  BlogRepo blogRepo;
  BlogController({required this.blogRepo});

  bool isLoading = true;

  List<Datum> _dataObject = [];

  List<Datum> get blogMatches => _dataObject;

  void initData() async {
    _dataObject.clear();
    isLoading = true;
    update();

    await allBlogData();
    isLoading = false;
    update();
  }

  Future<void> allBlogData() async {
    try {
      ResponseModel? responseModel = await blogRepo.getBlogData();
      if (responseModel!.isSuccess) {
        final blogModeljson = jsonDecode(responseModel.responseJson);
        Blogs blogsData = Blogs.fromMap(blogModeljson);
        if (blogsData.success == 1) {
          List<Datum>? tempList = blogsData.data;

          if (tempList!.isNotEmpty) {
            _dataObject.addAll(tempList);
          }
        } else {
          throw Exception('Failed to load blog data');
        }
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
