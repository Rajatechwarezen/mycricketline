import 'package:get/get.dart';
import 'package:sprotbuzz/data/repo/scoreTabl_repo/scoretable_repo.dart';

import '../../model/scoreTable_model/scoreTable_model.dart';
class ScoreTableController extends GetxController {
  var isLoading = true.obs;
  ScoreTableRepo scoreTableRepo;
  ScoreData? scoreData;

  ScoreTableController({required this.scoreTableRepo});

  Future<void> fetchScorecard({id}) async {
    try {
      scoreData = await scoreTableRepo.fetchScorecarData(id);
      updateLoading(false);
    } catch (error) {
      // Provide more information about the error
      print('Error during scorecard fetching: $error');
      updateLoading(false);
    }
    update();
  }



  void updateLoading(bool status) {
    isLoading.value = status;
  }
}
