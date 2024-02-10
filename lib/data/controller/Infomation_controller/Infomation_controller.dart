
import 'dart:async';

import 'package:get/get.dart';
import 'package:sprotbuzz/core/utilis/my_strings.dart';
import 'package:sprotbuzz/data/model/real_time_model/infomation_model.dart';

import '../../../view/component/Snackbar/custom_Snackbar.dart';
import '../../repo/RealTimeRepo/Info_Repo.dart';
import '../../servies/api_service.dart';

class InfomationController extends GetxController {
  InfomationRepo infomationRepo;
  InfomationController({required this.infomationRepo});
  List<InfoData>? allLiveMatches;
    List<InfoData>? vanueMatches;
  var isLoading = true.obs;
  final ApiClient apiClient = Get.find();

  @override
  void onInit() {
    super.onInit();

    fetcRealTimeData();

  }

  fetcRealTimeData({matchId}) async {
    try {
      List<InfoData>? matches =
          await infomationRepo.getInfoTimeData("4259");

    
      if (matches!.isNotEmpty) {
     
        allLiveMatches = matches;
        vanue(vanueId: matches[0].venueid);
           updateLoading(false);
        update();
      } else {
        CustomSnackBar.showCustomSnackBar(
            errorList: [matches.toString()],
            msg: [MyStrings.error],
            isError: true);
      }
    } catch (error) {
      updateLoading(false);

      print("Error fetching real-time data: $error");
    }
  }

  vanue({vanueId}) async {
    try {
      List<InfoData>? vanueList =
          await infomationRepo.getvanueData("$vanueId");

    
      if (vanueList!.isNotEmpty) {
     
        vanueMatches = vanueList;
           updateLoading(false);
        update();
      } else {
        CustomSnackBar.showCustomSnackBar(
            errorList: [vanueList.toString()],
            msg: [MyStrings.error],
            isError: true);
      }
    } catch (error) {
      updateLoading(false);

      print("Error fetching real-time data: $error");
    }
  }

  void clearData() {
    allLiveMatches?.clear();

    update();
  }

  updateLoading(bool status) {
    isLoading.value = status;
    update();
  }
}
