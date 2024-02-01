import 'dart:convert';

import 'package:sprotbuzz/core/utilis/method.dart';
import 'package:sprotbuzz/data/servies/api_service.dart';

import '../../../core/utilis/url.dart';
import '../../../view/component/Snackbar/custom_Snackbar.dart';
import '../../model/trending_model/trending_model.dart';

class TeandingRepo {
ApiClient apiClient ;

  TeandingRepo({required this.apiClient});

 Future <List<SeriesData>> getDataTending()async{
 try{
  
 final  response =  await    apiClient.requestGet(UrlContainer.trending, Method.getMethod);
 TrendingSeries responseData  = TrendingSeries.fromJson(json.decode(response!.responseJson));


if(responseData.status == true){
    return responseData.data;
}
  return responseData.data;
 }catch (e){
  CustomSnackBar.showCustomSnackBar(
      errorList: ["Erorr: $e"],
      msg: ["Json decoding error"],
      isError: true,
    );
 print(e);
 }
      return [];
  }
}