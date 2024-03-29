
import 'dart:convert';

import 'package:get/get.dart';
import '../../../core/utilis/my_strings.dart';
import '../../../view/component/snackbar/custom_Snackbar.dart';
import '../../model/about/privacy_response_model.dart';
import '../../repo/privacy_repo/privacy_repo.dart';
import '../../servies/api_service.dart';


class PrivacyController extends GetxController{

  int selectedIndex=1;
  PrivacyRepo repo;
  bool isLoading=true;

  List<AllPolicy>policyList=[];
  late var selectedHtml='';

  PrivacyController({required this.repo});

  void loadData()async{
    ResponseModel model=await repo.loadPrivacyAndPolicy();
    if(model.statusCode==200){
      PrivacyResponseModel responseModel=PrivacyResponseModel.fromJson(jsonDecode(model.responseJson));
      List<AllPolicy>?tempPolicyList = responseModel.data?.allPolicy;
      if(tempPolicyList !=null && tempPolicyList.isNotEmpty){
        policyList.addAll(tempPolicyList);
        changeIndex(0);
        updateLoading(false);
      } else{
        CustomSnackBar.error(errorList: responseModel.message?.error??[MyStrings.somethingWentWrong]);
      }
    }else{
      CustomSnackBar.error(errorList: [model.message]);
      updateLoading(false);
    }
  }


  void changeIndex(int index){
    selectedIndex=index;
    selectedHtml = policyList[index].dataValues?.details??'';
    update();
  }

  updateLoading(bool status){
    isLoading = status;
    update();
  }
}