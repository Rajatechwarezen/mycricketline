import 'dart:convert';

import 'package:sprotbuzz/data/servies/api_service.dart';

import '../../../core/utilis/method.dart';
import '../../../core/utilis/url.dart';
import '../../model/real_time_model/infomation_model.dart';

class InfomationRepo {


  ApiClient apiClient ;
   InfomationRepo({required this.apiClient});
   
Future getInfoTimeData(id) async {

    String apiUrl = UrlContainer.informtionMatchUrl;

    var response = await apiClient.requestForm(
      apiUrl,
      Method.postMethod,
      "4105",
    );

  
  if (response != null && response.isSuccess) {
      var result = response.responseJson;
      var liveMatchJsonDecode = json.decode(result);

      if (liveMatchJsonDecode['status'] == true) {
          if (liveMatchJsonDecode['data'] is List) {
              List<InfoData> matches = (liveMatchJsonDecode['data'] as List)
                  .map((json) => InfoData.fromJson(json))
                  .toList();

              return matches;
            } else if (liveMatchJsonDecode['data'] is Map) {
              InfoData match = InfoData.fromJson(liveMatchJsonDecode['data']);
             return [match];
            } else {
              throw Exception('Invalid data format: Unexpected data type');
            }
      } else {
        print('API response indicates failure: ${liveMatchJsonDecode['message']}');
      }
    } else {
      print('API request failed. Status code: ${response?.statusCode ?? "unknown"}');
    }



}

}
