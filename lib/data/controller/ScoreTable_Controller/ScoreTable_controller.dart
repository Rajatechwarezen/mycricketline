import 'package:get/get.dart';
import 'package:sprotbuzz/data/repo/scoreTabl_repo/scoretable_repo.dart';

import '../../model/scoreTable_model/scoreTable_model.dart';

class ScoreTableController extends GetxController{
  var isLoading = true.obs;
ScoreTableRepo scoreTableRepo;

  var  scorerData;
ScoreTableController({required this.scoreTableRepo});


fetchScorecard(id) async {

  try{
 scorerData = await scoreTableRepo.fetchScorecarData(id) ;
   updateLoading(false);
     update();
 } catch (error) {
      updateLoading(false);
      update();
    }
}
  updateLoading(bool status) {
    isLoading.value = status;
    update();
  }
}

