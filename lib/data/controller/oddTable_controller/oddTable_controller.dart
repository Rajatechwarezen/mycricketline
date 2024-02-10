import 'dart:async';

import 'package:get/get.dart';

import '../../../core/utilis/my_strings.dart';
import '../../../view/component/Snackbar/custom_Snackbar.dart';
import '../../model/player_model/player_model.dart';
import '../../repo/oddTable_repo/oddTableRepo.dart';
import '../../repo/player_repo/Player_Repo.dart';
import '../../servies/api_service.dart';

class OddController extends GetxController {
  OddTableRepo oddTableRepo;
  OddController({required this.oddTableRepo});
  List<MatchData>? playerMatchesList;
  var isLoading = true.obs;
  final ApiClient apiClient = Get.find();


  initData({matchId}) async {
    await fetchOddTableData();
    updateLoading(false);
    update();
  }
  fetchOddTableData({matchId}) async {
    try {
      MatchData matches = await oddTableRepo.fetchoddTable("$matchId");

      playerMatchesList = [matches];
      updateLoading(false);
      update();
    } catch (error) {
      update();
      updateLoading(false);

      print("Error fetching real-time data: $error");
    }
  }

  void clearData() {
    playerMatchesList?.clear();
    update();
  }

  updateLoading(bool status) {
    isLoading.value = status;
    update();
  }
}
