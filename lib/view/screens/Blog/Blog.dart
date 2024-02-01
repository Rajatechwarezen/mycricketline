import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sprotbuzz/core/utilis/boxSpace.dart';
import 'package:sprotbuzz/view/component/custom_loader/custom_loader.dart';
import 'package:sprotbuzz/view/component/divider/custom_divider.dart';
import 'package:sprotbuzz/view/component/text/header_text.dart';
import 'package:sprotbuzz/view/screens/Blog/widget/BlogNewsItem.dart';

import '../../../core/utilis/url.dart';
import '../../../data/controller/blog/blog_controller.dart';
import '../../../data/repo/blog_repo/blog_repo.dart';
import '../../../data/servies/api_service.dart';
import '../home/home_page_componet/new/new_Layout.dart';
import 'BlogFull.dart';

class BlogsPage extends StatefulWidget {
  const BlogsPage({super.key});

  @override
  State<BlogsPage> createState() => _BlogsPageState();
}



class _BlogsPageState extends State<BlogsPage> {
  final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(BlogRepo(apiClient: Get.find()));
    final controller = Get.put(BlogController(blogRepo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initData();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      child:  GetBuilder<BlogController>(builder: (controller)=>
      controller.isLoading ? const CustomDivider():
         
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.blogMatches.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: (){
                         Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsLaouts(
                                        newsData:controller.blogMatches[index], skyNews: false),
                                  ),
                                );
                    },
                    child: 
                     NewsBlogsCard(newTitle: controller.blogMatches[index] .blTitle.toString(), img:"http://cricapi.mycricketline.com/uploads/blogimg/${controller.blogMatches[index].blImg.toString()}",dateTime: controller.blogMatches[index].modifyOn.toString(),status: "Publish" ),);
                },
              ),
            ),

      ),
    );
  }
}
