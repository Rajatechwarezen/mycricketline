import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprotbuzz/data/repo/short_rero/short_repo.dart';

import '../../../core/helper/shared_preference_helper.dart';
import '../../../view/component/Snackbar/custom_Snackbar.dart';
import '../../model/shrot_model/short_model.dart';

class ShrotController extends GetxController {
  final ShortRepo shortRepo;
  ShrotController({required this.shortRepo});

  bool isLoading = true;

  List<ImageShotData> _shortData = [];

  List<ImageShotData> get shortData => _shortData;

  RxBool isButtonDisabled = false.obs;
  List<String> userLikeId = <String>[].obs;
  RxInt userLikeCount = 0.obs;

  void initData() async {
    _shortData.clear();
    isLoading = true;
    update(); // Trigger UI update
    await showData();
    isLoading = false;
    update(); // Trigger UI update
  }

  Future<List<ImageShotData>> showData() async {
  
    try {
      final responseModel = await shortRepo.getShortData();

      if (responseModel!.statusCode == 200) {
        final responseModelJson = jsonDecode(responseModel.responseJson);

        if (responseModelJson["success"] == 1) {
           isLoading = false;
          List responseData = responseModelJson["data"];

          final referralModel =
              responseData.map((e) => ImageShotData.fromJson(e)).toList();

         

          _shortData.addAll(referralModel);

          return _shortData;
        } else {
          CustomSnackBar.showCustomSnackBar(
              errorList: [responseModel.toString()], msg: [], isError: true);
          return _shortData; // Return appropriate response or throw an exception
        }
      } else {
        CustomSnackBar.showCustomSnackBar(
            errorList: [responseModel.toString()], msg: [], isError: true);
        return _shortData; // Return appropriate response or throw an exception
      }
    } catch (e) {
      print('Error: $e');
      // Handle the exception or return an appropriate response
      return _shortData; // Return appropriate response or throw an exception
    }
  }

  Future<void> updateLike({required String id, required int userLikeCount,required bool boolLike}) async {
  final storage = await SharedPreferences.getInstance();
  try {
    // Retrieve existing userLikeData from SharedPreferences
    Set<String>? existingLikes = Set.from(storage.getStringList(SharedPreferenceHelper.userLikeData) ?? []);

    // Remove the previous entry with the same userLikeId, if it exists
    existingLikes.removeWhere((like) => like.contains('"userLikeId": "$id"'));

    // Create a new JSON string and add it to the set
    String newLike = '{"useClickLike": "$boolLike", "userLikeId": "$id"}';
    existingLikes.add(newLike);

    // Save the updated set back to SharedPreferences
    storage.setStringList(SharedPreferenceHelper.userLikeData, existingLikes.toList());

    // Call your repository method
    await shortRepo.geLikeData({"id": id, "userslike": userLikeCount});
    
     
      if (!userLikeId.contains(id)) {
        this.userLikeCount++;
        isButtonDisabled = true.obs;
        userLikeId.add(id);
    
      } else {
        this.userLikeCount--;
        isButtonDisabled = false.obs;
        userLikeId.remove(id);
      }
    } catch (e) {
      isLoading = false;
      update();
      print('Error: $e');
    }
  }
}
