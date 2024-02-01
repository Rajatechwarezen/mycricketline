import 'dart:convert';

import '../../../core/utilis/method.dart';
import '../../../core/utilis/url.dart';
import '../../model/real_time_model/RealTimeModel.dart';
import '../../servies/api_service.dart';

class RealTimeRepo{

  ApiClient apiClient ;
   RealTimeRepo({required this.apiClient});
   
Future getRealTimeData(id) async {

    String apiUrl = UrlContainer.RealTimeUrl;

    var response = await apiClient.requestForm(
      apiUrl,
      Method.postMethod,
      id,
    );

    if (response != null && response.isSuccess) {
      var result = response.responseJson;
      var liveMatchJsonDecode = json.decode(result);

      if (liveMatchJsonDecode['status'] == true) {
          if (liveMatchJsonDecode['data'] is List) {
              List<LiveMatchFull> matches = (liveMatchJsonDecode['data'] as List)
                  .map((json) => LiveMatchFull.fromJson(json))
                  .toList();

              return matches;
            } else if (liveMatchJsonDecode['data'] is Map) {
              LiveMatchFull match = LiveMatchFull.fromJson(liveMatchJsonDecode['data']);
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


  return null;
}
}