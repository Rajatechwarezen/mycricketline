import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sprotbuzz/core/utilis/method.dart';
import 'package:sprotbuzz/data/model/liveMatch_model/liveMatch_model.dart';

import '../../../core/utilis/url.dart';
import '../../model/home_page_models.dart';
import '../../servies/api_service.dart';

class OwlTimeDataController extends GetxController {
  var homeliveMatches = <LiveMatch>[].obs;

  final ApiClient apiClient = Get.find();
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRealTimeData();
  }

  String apiUrl = UrlContainer.homeMatches;

  void updateLiveMatches(List<LiveMatch> updatedMatches) {
   
    homeliveMatches.assignAll(updatedMatches);
  }

  fetchRealTimeData() async {

      var response = await apiClient.requestGet(
        apiUrl,
        Method.getMethod,
        passHeader: false,
        isOnlyAcceptType: false,
      );

      if (response != null) {
        if (response.isSuccess) {
          var result = response.responseJson;
          var homeMatchJsonDecode = json.decode(result);


          if (homeMatchJsonDecode['status'] == true) {
    
            List<LiveMatch> matches = (homeMatchJsonDecode['data'] as List)
                .map((json) => LiveMatch.fromJson(json))
                .toList();
      updateLiveMatches(matches);
            
            return matches;
          }
        } else {
          print('API request failed with status code: ${response.statusCode}');
        }
      } else {
        print('API request returned null response');
      }
   
  }

  void clearData() {
    homeliveMatches.clear();

    update();
  }
}
