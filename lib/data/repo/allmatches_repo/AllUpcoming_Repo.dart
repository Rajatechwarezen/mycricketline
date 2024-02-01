import 'dart:convert';

import '../../../core/utilis/method.dart';
import '../../../core/utilis/url.dart';
import '../../model/allMatches_model/allMatches_model.dart';
import '../../model/home_page_models.dart';
import '../../servies/api_service.dart';

class AllUpcomingRepo{
  
  late ApiClient apiClient;
  AllUpcomingRepo({required this.apiClient});


  Future<List<AllMatcheModel>?> loadData() async {
    String apiUrl = UrlContainer.allUpcoming;

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
          List<AllMatcheModel> matches = (liveMatchJsonDecode['data'] as List)
              .map((json) => AllMatcheModel.fromJson(json))
              .toList();

          return matches;
        }
      } else {
        print('API request failed with status code: ${response.statusCode}');
      }
    } else {
      print('API request returned null response');
    }
  }
}