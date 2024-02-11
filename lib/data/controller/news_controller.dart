import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sprotbuzz/core/utilis/method.dart';
import 'package:sprotbuzz/data/servies/api_service.dart';
import 'package:sprotbuzz/data/model/sky11news_model.dart';
class Newscontroller extends GetxController {
  final ApiClient apiClient = Get.find();
  var isLoading = true.obs;
int currentPage = 1;
  List<Sky11> _newBlog = [];
  List<Sky11> get newsBolg => _newBlog;

 final ScrollController scrollController = ScrollController();



  
Future<List<Sky11>> makeApiRequest() async {
  String url = 'http://sky11.news/wp-json/wp/v2/posts?per_page=16';


  var response = await apiClient.requestGet(
    url,
    Method.getMethod,
    passHeader: false,
    isOnlyAcceptType: false,
  );

  try {
    if (response != null) {
      if (response.isSuccess) {
        var result = jsonDecode(response.responseJson);

      
        for (int index = 0; index < result.length; index++) {
          final Sky11 newsItem = Sky11.fromJson(result[index]);
          _newBlog.add(newsItem);
        }

        return _newBlog;
      } else {
        print('API request failed with status code: ${response.statusCode}');
        print('Response body: ${response.responseJson}');
      }
    } else {
      print('API request returned null response');
    }
  } catch (error) {
    print('Error during API request: $error');
  }

  // Return an empty list in case of errors
  return [];
}


 List<Map<String, dynamic>> tnews = []; //image 
fatchDataIntoImage(){
 Future.wait(
                    List.generate(
                      _newBlog.length,
                      (index) => fetchSingleData(index),
                    ),
                  );
}

  Future<void> fetchSingleData(int index) async {
    //['_links']["wp:featuredmedia"][0]['href']

    var singleData = await apiClient.requestGet(
     _newBlog[index].links!.wpFeaturedmedia![0].href
          .toString(),
      Method.getMethod,
      passHeader: false,
      isOnlyAcceptType: false,
    );

    print(singleData!.responseJson);
    Sky111 singleDatamore = Sky111.fromJson( json.decode(singleData!.responseJson.toString()));
_newBlog[index].content!.rendered.toString();
    Map<String, dynamic> newsItem = {
      'image': singleDatamore.guid!.rendered.toString()
    };

   
    tnews.add(newsItem);
  }



}
