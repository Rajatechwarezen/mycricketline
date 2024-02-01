
import 'dart:convert';

import 'package:sprotbuzz/core/utilis/method.dart';
import 'package:sprotbuzz/core/utilis/url.dart';
import 'package:sprotbuzz/data/servies/api_service.dart';

import '../../model/home_page_models.dart';

class LiveMatchRepo  {
  ApiClient apiClient ;
   LiveMatchRepo({required this.apiClient});
 Future< List<LiveMatch>?> getLiveMatchData() async {
  String apiUrl = UrlContainer.liveMatchUrl;

    var response = await apiClient.requestGet(
      apiUrl,
      Method.getMethod,
      passHeader: false,
      isOnlyAcceptType: false,
    );

    if (response != null) {
      if (response.isSuccess) {
        var result = response.responseJson;
        var liveMatchJsonDecode = json.decode(result);
        if (liveMatchJsonDecode['status'] == true) {
          List<LiveMatch> matches = (liveMatchJsonDecode['data'] as List)
              .map((json) => LiveMatch.fromJson(json))
              .toList();

          return matches;
        }
      } else {
        print('API request failed with status code: ${response.statusCode}');
      }
    } else {
      print('API request returned null response');
    }
    return null;
   }
}