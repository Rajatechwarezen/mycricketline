import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprotbuzz/data/repo/allmatches_repo/AllUpcoming_Repo.dart';
import 'package:sprotbuzz/view/component/Show_match_container/show_match_container.dart';

import '../../../../data/controller/Matches_controller/Allupcoming_controller.dart';
import '../../../component/custom_loader/custom_loader.dart';

class AllUpcoming extends StatefulWidget {
  const AllUpcoming({super.key});

  @override
  State<AllUpcoming> createState() => _AllUpcomingState();
}

class _AllUpcomingState extends State<AllUpcoming> {
   final AllUpComingController allmatchesController = Get.put(
      AllUpComingController(
          allUpcomingRepo: AllUpcomingRepo(apiClient: Get.find())));

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ListView.builder(
          itemCount: allmatchesController.allMatches.length +
              (allmatchesController.hasMoreData.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == allmatchesController.allMatches.length) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CustomLoader()),
              );
            } else {
              return showMatchContainer(
                details: allmatchesController.allMatches[index],
                onTap: () {
                  // Handle onTap
                },
                isLive: false, // Modify based on your logic
              );
            }
          },
          controller: _scrollController, // Use the custom controller
        ),
      ),
    );
  }

  void _scrollListener() {
    // If the user scrolls to the end of the list and more data is available, load more
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (allmatchesController.hasMoreData.value) {

        allmatchesController.loadMoreData();
      }
    }
  }

}