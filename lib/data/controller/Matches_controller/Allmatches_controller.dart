
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';

import '../../../core/utilis/method.dart';
import '../../../core/utilis/url.dart';
import '../../model/allMatches_model/Allfinish.dart';
import '../../model/home_page_models.dart';
import '../../repo/allmatches_repo/AllmatchesRepo.dart';
import '../../servies/api_service.dart';

class AllmatchesController extends GetxController {
  AllmatchesRepo allmatchesRepo;
  AllmatchesController({required this.allmatchesRepo});

  RxList<AllfinishModel> allMatches = <AllfinishModel>[].obs;
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

    List<AllfinishModel>? matches = await allmatchesRepo.loadData();
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

