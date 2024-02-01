
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
          await infomationRepo.getInfoTimeData("$matchId");

    
      if (!matches!.isEmpty) {
     
        allLiveMatches = matches;
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

  void clearData() {
    allLiveMatches?.clear();

    update();
  }

  updateLoading(bool status) {
    isLoading.value = status;
    update();
  }
}
