import 'package:get/get.dart';
import 'package:sprotbuzz/data/servies/api_service.dart';

import '../../../core/utilis/my_strings.dart';
import '../../../view/component/snackbar/custom_Snackbar.dart';
import '../../model/commentery_model/commentery_model.dart';
import '../../repo/commentery_repo/CommenteryRepo.dart';

class CommenteryController extends GetxController {
  CommenteryRepo commenteryRepo;
  CommenteryController({required this.commenteryRepo});

  List<CricketMatch>? allLiveMatches;
  var isLoading = true.obs;
  final ApiClient apiClient = Get.find();


 commenteryfatchData({idMatch}) async {

    try {
      List<CricketMatch>? matches =
          await commenteryRepo.commenterygetData(id: idMatch.toString());

      if (matches!.isNotEmpty) {
        allLiveMatches = matches;
        
        updateLoading(false);
        update();
 return matches;
      

      } else {
        CustomSnackBar.showCustomSnackBar(
            errorList: [matches.toString()],
            msg: [MyStrings.error],
            isError: true);
             return [];
      
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
