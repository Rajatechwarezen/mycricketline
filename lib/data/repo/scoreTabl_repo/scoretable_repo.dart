

import 'dart:convert';

import '../../../core/utilis/method.dart';
import '../../../core/utilis/url.dart';
import '../../model/scoreTable_model/scoreTable_model.dart';
import ''as http;
import '../../servies/api_service.dart';
class ScoreTableRepo{

  ApiClient apiClient ;

ScoreTableRepo({required this.apiClient});



Future<ScoreData> fetchScorecarData(String id) async {
  try {
    String apiUrl = UrlContainer.scoreTable;

    var response = await apiClient.requestForm(
      apiUrl,
      Method.postMethod,
      id,
    );

 
    if (response != null && response.isSuccess) {
      var result = response.responseJson;
      var liveMatchJsonDecode = json.decode(result);

      if (liveMatchJsonDecode != null && liveMatchJsonDecode['status'] == true) {
        return ScoreData.fromJson(liveMatchJsonDecode as Map<String, dynamic>);
      } else {
        throw Exception('Invalid data format or status is false: $liveMatchJsonDecode');
      }
    } else {
      throw Exception('API request failed. Status code: ${response?.statusCode ?? "unknown"}');
    }
  } catch (e) {
    print('Error during scorecard data fetching: $e');
    rethrow; // rethrow the exception for better debugging
  }
}
}