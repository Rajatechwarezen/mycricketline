import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprotbuzz/core/utilis/method.dart';

import 'package:sprotbuzz/data/controller/news_controller.dart';
import 'package:sprotbuzz/data/model/sky11news_model.dart';

import 'package:sprotbuzz/data/servies/api_service.dart';
import 'package:sprotbuzz/view/component/custom_loader/custom_loader.dart';
import 'package:sprotbuzz/view/screens/home/home_page_componet/new/new_Layout.dart';

import '../../../../component/news/newsShow.dart';

class HomeScreenNews extends StatelessWidget {
  HomeScreenNews({super.key});
  List<String> urlnewsLink = [];
  String apiUrl = '';
  final ScrollController scrollController = ScrollController();
  Newscontroller openseaController = Get.put(Newscontroller());
  final ApiClient apiClient = Get.find();
  Future<void> _refresh() async {
    await openseaController.makeApiRequest();
  }

  List<Map<String, dynamic>> tnews = [];

  Future<void> fetchSingleData(int index) async {
    //['_links']["wp:featuredmedia"][0]['href']

    var singleData = await apiClient.requestGet(
      openseaController.newsBolg[index].links!.wpFeaturedmedia![0].href
          .toString(),
      Method.getMethod,
      passHeader: false,
      isOnlyAcceptType: false,
    );

    Sky111 singleDatamore = Sky111.fromJson( json.decode(singleData!.responseJson.toString()));

    openseaController.newsBolg[index].content!.rendered.toString();
    Map<String, dynamic> newsItem = {
      'image': singleDatamore.guid!.rendered.toString()
    };

   
    tnews.add(newsItem);
  }




  @override
  Widget build(BuildContext context) {
    return GetBuilder<Newscontroller>(
      builder: (openseaController) {
        return RefreshIndicator(
          onRefresh: _refresh,
          child:  FutureBuilder(
                  future: Future.wait(
                    List.generate(
                      openseaController.newsBolg.length,
                      (index) => fetchSingleData(index),
                    ),
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CustomLoader();
                    } else if (snapshot.hasError) {
                      print("Error: ${snapshot.error}");
                      return Text("Error: ${snapshot.error}");
                    } else {
                      return ListView.builder(
                        itemCount: openseaController.newsBolg.length,
                        shrinkWrap: true,
                         controller: openseaController.scrollController,
                      
                        itemBuilder: (context, index) {
                
                          return GestureDetector(
                              onTap: () {
                      
                                ///we are not using getx routing 
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsLaouts(
                                        newsData: openseaController
                                          .newsBolg[index].content!.rendered, skyNews: true),
                                  ),
                                );
                              },
                              child: (index % 2 == 0)
                                  ? NewsCard(
                                      dateTime: openseaController
                                          .newsBolg[index].modified
                                          .toString(),
                                      img: tnews[index]['image'].toString(),
                                      newTitle: openseaController
                                          .newsBolg[index].title!.rendered
                                          .toString(),
                                      status: openseaController
                                              .newsBolg[index].status
                                              .toString() ??
                                          "",
                                    )
                                  : NewsCardRow(
                                      dateTime: openseaController
                                          .newsBolg[index].modified
                                          .toString(),
                                      img: tnews[index]['image'].toString(),
                                      newTitle: openseaController
                                          .newsBolg[index].title!.rendered
                                          .toString(),
                                      status: openseaController
                                              .newsBolg[index].status
                                              .toString() ??
                                          "",
                                    ));
                        },
                      );
                    }
                  },
                ),
        );
      },
    );
  }
}
