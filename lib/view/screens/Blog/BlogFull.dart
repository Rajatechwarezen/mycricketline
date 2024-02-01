import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sprotbuzz/core/utilis/my_strings.dart';
import 'package:sprotbuzz/core/utilis/url.dart';
import 'package:sprotbuzz/data/repo/blog_repo/blog_repo.dart';
import 'package:sprotbuzz/view/component/appbar/custom_appbar.dart';
import 'package:sprotbuzz/view/component/divider/custom_divider.dart';

import '../../../core/utilis/borderbox.dart';
import '../../../data/controller/blog/blog_controller.dart';
import '../../../data/servies/api_service.dart';

class BlogFull extends StatelessWidget {
  const BlogFull({super.key});

  
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(BlogRepo(apiClient: Get.find()));
    final controller = Get.put(BlogController(blogRepo: Get.find()));

  
    WidgetsBinding.instance.addPostFrameCallback((_) {
     
      controller.initData();
     
    });


  }

  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      appBar:CustomAppBar(title: MyStrings.blog.tr),
      body: GetBuilder<BlogController>(builder: (controller)=>
      
      Column(
        children: controller.blogMatches.asMap().entries.map((entry) {
          final news = entry.value;
       
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: boRadiusAll,
              border: border,
            ),
            child: Column(
              children: [
                Container(
                  height: 133,
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://cricapi.mycricketline.com/api/blogimg/2023-07-21T111822.758Zwarnerausvwi2ndt20ilive_1200x768.jpeg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news.blTitle.toString(),
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(news.blDesc.toString()),
                    ],
                  ),
                ),
                const CustomDivider(),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Published: ${news.createdOn}',
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      const Text('Content:'),
                      SizedBox(height: 4.0),
                
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
     ) );
  }
}
