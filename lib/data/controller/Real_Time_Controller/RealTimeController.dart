import 'dart:async';

import 'package:get/get.dart';
import 'package:sprotbuzz/core/utilis/my_strings.dart';
import 'package:sprotbuzz/data/model/real_time_model/RealTimeModel.dart';
import 'package:sprotbuzz/data/repo/RealTimeRepo/real_Time_Repo.dart';

import '../../../view/component/Snackbar/custom_Snackbar.dart';
import '../../servies/api_service.dart';

import 'dart:async';


class RealTimeController extends GetxController {
  RealTimeRepo realTimeRepo;
  RxList<LiveMatchFull> allLiveMatches = <LiveMatchFull>[].obs;
  RxBool isLoading = true.obs;
  final ApiClient apiClient = Get.find();

  late StreamController<bool> _refreshController;
  late StreamSubscription<bool> _refreshSubscription;

  RealTimeController({required this.realTimeRepo}) ;

  void initData(id) async {
      
    try {
      List<LiveMatchFull>? matches = await realTimeRepo.getRealTimeData("$id");
      if (matches != null && matches.isNotEmpty) {
        allLiveMatches.assignAll(matches);
        updateLoading(false);
        update();
      } else {
        CustomSnackBar.showCustomSnackBar(
          errorList: [matches.toString()],
          msg: [MyStrings.error],
          isError: true,
        );
      }
    } catch (error) {
      updateLoading(false);
      print("Error fetching real-time data: $error");
    }
  }

  void refreshData() {
    _refreshController.add(true);
  }

  void clearData() {
    allLiveMatches.clear();
    update();
  }

  updateLoading(bool status) {
    isLoading.value = status;
    update();
  }

  @override
  void onClose() {
    // Cancel the subscription when the controller is closed
    _refreshSubscription.cancel();
    _refreshController.close();
    super.onClose();
  }
}
