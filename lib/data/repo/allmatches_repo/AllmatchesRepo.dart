import 'dart:convert';

import '../../../core/utilis/method.dart';
import '../../../core/utilis/url.dart';
import '../../model/allMatches_model/Allfinish.dart';
import '../../servies/api_service.dart';

class AllmatchesRepo {
  late ApiClient apiClient;
  AllmatchesRepo({required this.apiClient});


  Future<List<AllfinishModel>?> loadData() async {
    String apiUrl = UrlContainer.allFinish;

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
          List<AllfinishModel> matches = (liveMatchJsonDecode['data'] as List)
              .map((json) => AllfinishModel.fromJson(json))
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
