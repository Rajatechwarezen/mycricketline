import 'dart:convert';

import 'package:sprotbuzz/data/servies/api_service.dart';

import '../../../core/utilis/method.dart';
import '../../../core/utilis/url.dart';
import '../../model/commentery_model/commentery_model.dart';

class CommenteryRepo {
  ApiClient apiClient;
  CommenteryRepo({required this.apiClient});

  Future commenterygetData({id}) async {
    String apiUrl = UrlContainer.commenteryUrl;
    
    var response = await apiClient.requestForm(
      apiUrl,
      Method.postMethod,
      id,
    );
    if (response != null && response.isSuccess) {
      var result = response.responseJson;
      var liveMatchJsonDecode = json.decode(result);

      if (liveMatchJsonDecode['status'] == true) {
        if (liveMatchJsonDecode["data"] is Map) {
          CricketMatch match = CricketMatch.fromJson(liveMatchJsonDecode);

          return [match];
        }
      } else {
        print('API response indicates failure: ${liveMatchJsonDecode['msg']}');
      }
    } else {
      print(
          'API request failed. Status code: ${response?.statusCode ?? "unknown"}');
    }

    return null;
  }
}
