import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';

import '../../model/allMatches_model/allMatches_model.dart';
import '../../model/home_page_models.dart';
import '../../repo/allmatches_repo/AllUpcoming_Repo.dart';

class AllUpComingController extends GetxController {
  AllUpcomingRepo allUpcomingRepo;
  AllUpComingController({required this.allUpcomingRepo});

  RxList<AllMatcheModel> allMatches = <AllMatcheModel>[].obs;
  RxBool isLoading = true.obs;
  RxBool hasMoreData = true.obs;

  int intCount = 0;
  int intlCount = 10;

   int batchSize = 10;

  @override
  void onInit() {
    super.onInit();
    fetchData();
 
  }

  void fetchData() async {
    if (!hasMoreData.value) {
      return;
    }

    isLoading.value = true;
    update();

    List<AllMatcheModel>? matches = await allUpcomingRepo.loadData();
    if (matches != null) {
      if (matches.isEmpty) {
        hasMoreData.value = false;
      } else {
        int newItemsCount = min(batchSize, matches.length);
        allMatches.addAll(matches.sublist(0, newItemsCount));
        intCount = intlCount;

        if (allMatches.length >= batchSize) {
          batchSize += 10; // Increase the batch size by 10 for the next fetch
        }

        if (allMatches.length >= 100) {
          hasMoreData.value = false; // Stop fetching after a certain limit
        }
      }
    }

    isLoading.value = false;
    update();
  }


  void loadMoreData() {
    intlCount += 10;
    fetchData();
  }

  void clearData() {
    allMatches.clear();
    intCount = 0;
    hasMoreData.value = true;

    update();
  }
}

