import 'dart:convert';

import 'package:sprotbuzz/data/servies/api_service.dart';

import '../../../core/utilis/method.dart';
import '../../../core/utilis/url.dart';
import '../../model/player_model/player_model.dart';

class PlayerRepo {
  ApiClient apiClient;
  PlayerRepo({required this.apiClient});

  Future geplayerData(id) async {

    String apiUrl = UrlContainer.playersByMatchId;

    var response = await apiClient.requestForm(
      apiUrl,
      Method.postMethod,
     "4105",
    );
    
     if (response!.isSuccess == true) {
final data = json.decode(response.responseJson);

 if (data['status'] == true && data['data'] != null) {

      if (data['data'] != null) {
            // List<MatchData>? matches = (data['data'] as List)
            //     .map((json) => MatchData.fromJson(json))
            //     .toList();
            final matches = MatchData.fromJson(data as Map<String, dynamic>);
  
        return   matches;
          } else {
           return data;
          }
        } else {
       return  response!.message;
         }
     }
    return null;
  }
}
