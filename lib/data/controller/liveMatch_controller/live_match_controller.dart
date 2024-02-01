import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';

import '../../../core/utilis/method.dart';
import '../../../core/utilis/url.dart';
import '../../model/home_page_models.dart';
import '../../repo/liveMatch_repo/liveMatch_repo.dart';
import '../../servies/api_service.dart';
import 'package:collection/collection.dart';
class LiveMatchController extends GetxController {
LiveMatchRepo liveMatchRepo;
LiveMatchController({required this.liveMatchRepo});
final allLiveMatches = RxList<LiveMatch>();
  final ApiClient apiClient = Get.find();
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();

    fetcLiveTimeData();
      Timer.periodic(const Duration(seconds: 2), (timer) {
     
fetcLiveTimeData();
  update();
       });
  }

  String apiUrl = UrlContainer.liveMatchUrl;

void allgetMatches(   List<LiveMatch>? updatedMatches) {
    
  for (int i = 0; i < updatedMatches!.length; i++) {
    if (i < allLiveMatches.length) {
      allLiveMatches[i] = updatedMatches[i];
    } else {
      
      allLiveMatches.add(updatedMatches[i]);
    }
  }
  update(); 
  // Trigger update without rebuilding the entire widget tree
}

  fetcLiveTimeData() async {
          List<LiveMatch>? matches = await  liveMatchRepo.getLiveMatchData();
          
       if(matches !=  null ){

             if (!const DeepCollectionEquality.unordered().equals(allLiveMatches, matches)) {
      allgetMatches(matches);
          updateLoading(false);
    } else{
      print("Api data is get error ");
             updateLoading(false);
    }
       }
  }
 updateLoading(bool status){
    isLoading.value = status;
    update();
  }
  void clearData() {
    allLiveMatches.clear();

    update();
  }
}
