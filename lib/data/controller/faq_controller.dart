
import 'dart:convert';

import 'package:get/get.dart';

import '../../core/utilis/my_strings.dart';
import '../../view/component/snackbar/custom_Snackbar.dart';
import '../repo/faq_repo.dart';
import '../servies/api_service.dart';

class FaqController extends GetxController{

  FaqRepo faqRepo;
  FaqController({required this.faqRepo});

  bool isLoading = true;
  bool isPress = false;
  int selectedIndex = -1;

  List faqList = [];

  void changeSelectedIndex(int index){
    if(selectedIndex == index){
      selectedIndex = -1;
      update();
      return;
    }
    selectedIndex = index;
    update();
  }

 

  void loadData()async{
    ResponseModel model=await faqRepo.loadFaq();
    if(model.statusCode==200){
      var  responseModel =jsonDecode(model.responseJson);
      List? tempFaqList = responseModel["data"]["faqs"];
      if(tempFaqList !=null && tempFaqList.isNotEmpty){
        faqList.addAll(tempFaqList);
      } else{
        CustomSnackBar.error(errorList: responseModel["message"]["error"] ??[MyStrings.somethingWentWrong]);
      }
    }else{
      CustomSnackBar.error(errorList: [model.message]);
    }
    isLoading = false;
    update();
  }


}