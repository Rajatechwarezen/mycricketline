import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../view/component/snackbar/custom_Snackbar.dart';
import '../../model/referral_model/referral_response_model.dart';
import '../../repo/referral/referral_repo.dart';
import '../../servies/api_service.dart';

class ReferralController extends GetxController{
  ReferralRepo referralRepo;
  ReferralController({required this.referralRepo});

  bool isLoading = true;
  List<Referrals> dataList = [];

  String? nextPageUrl;
  int page = 0;
  String searchReferrals = "";

  TextEditingController searchController = TextEditingController();


  void initData() async{

    page = 0;
    dataList.clear();
    isLoading = true;
    update();

    await allReferralsData();
    isLoading = false;
    update();

  }

  void loadPaginationData()async{
    await allReferralsData();
    update();
  }

  Future<void> allReferralsData() async{
    page = page + 1;
    if(page == 1){
      dataList.clear();
    }

    ResponseModel? responseModel = await referralRepo.getReferralData(page);

    if(responseModel!.statusCode == 200){
      ReferralModel referralModel = ReferralModel.fromJson(jsonDecode(responseModel.responseJson));

      if(referralModel.status.toString().toLowerCase() == "success"){
        List<Referrals>? tempList = referralModel.data?.referrals;
        if(tempList != null && tempList.isNotEmpty){
          dataList.addAll(tempList);
        }
      }
      else{
        CustomSnackBar.showCustomSnackBar(errorList: [referralModel.message.toString()], msg: [], isError: true);
      }
    }
    else{
      CustomSnackBar.showCustomSnackBar(errorList: [responseModel.message.toString()], msg: [], isError: true);
    }
    update();
  }


  bool hasNext(){
    return nextPageUrl != null && nextPageUrl!.isNotEmpty && nextPageUrl != 'null' ? true : false;
  }
}