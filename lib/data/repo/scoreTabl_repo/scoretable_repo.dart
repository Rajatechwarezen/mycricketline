

import 'dart:convert';

import '../../../core/utilis/method.dart';
import '../../../core/utilis/url.dart';
import '../../model/scoreTable_model/scoreTable_model.dart';
import ''as http;
import '../../servies/api_service.dart';
class ScoreTableRepo{

  ApiClient apiClient ;

ScoreTableRepo({required this.apiClient});


   
Future fetchScorecarData(id) async {

    String apiUrl = UrlContainer.scoreTable;

    var response = await apiClient.requestForm(
      apiUrl,
      Method.postMethod,
      "3766",
    );

  print("${response!.responseJson} ======================66666666666");
  if (response != null && response.isSuccess) {
      var result = response.responseJson;
      var liveMatchJsonDecode = json.decode(result);

      if (liveMatchJsonDecode['status'] == true) {
          if (liveMatchJsonDecode != null) {
            var inning = ScoreData.fromJson(liveMatchJsonDecode as Map<String, dynamic>);

            return inning;
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