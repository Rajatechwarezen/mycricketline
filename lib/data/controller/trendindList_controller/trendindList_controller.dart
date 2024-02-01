import 'package:get/get.dart';

import '../../../view/component/Snackbar/custom_Snackbar.dart';
import '../../model/trending_model/trending_model.dart';
import '../../repo/teanding_repo/teanding_repo.dart';

class TrendingListController extends GetxController {
  TeandingRepo teandingRepo;
  TrendingListController({required this.teandingRepo});
  
  RxBool isLoading = true.obs; // Use .obs to create RxBool

   List<SeriesData> dataList = [];

  void initData() async {
    dataList.clear();
    isLoading.value = true; // Use .value to modify RxBool
    update();

    await getTrendingData();

    isLoading.value = false; // Use .value to modify RxBool
    update();
  }

  Future<void> getTrendingData() async {
    try {
      List<SeriesData>? responseModel = await teandingRepo.getDataTending();
      if (responseModel.isEmpty) {
        CustomSnackBar.showCustomSnackBar(
          errorList: ["Error: $responseModel"],
          msg: ["Json decoding error"],
          isError: true,
        );
      } else {
        dataList.addAll(responseModel);
       
      }
    } catch (e) {
      CustomSnackBar.showCustomSnackBar(
        errorList: ["Error: $e"],
        msg: ["An error occurred while fetching data"],
        isError: true,
      );
    } finally {
      isLoading.value = false; // Use .value to modify RxBool
      update();
    }
  }
}
