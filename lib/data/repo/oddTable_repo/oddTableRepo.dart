import 'dart:convert';

import 'package:sprotbuzz/data/servies/api_service.dart';
import 'package:http/http.dart' as http;

import '../../../view/component/snackbar/custom_Snackbar.dart';
import '../../model/odds_model/OddsData.dart';
import '../../model/pointTable/poitTable.dart';

class OddTableRepo {
  ApiClient apiClient;
  OddTableRepo({required this.apiClient});

  fetchoddTable(id) async {
    const url =
        'http://apicricketchampion.in/webservices/matchOddHistory/20122cd5366e30f0847774c9d7698d30';

    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['match_id'] = "";

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody);

        if (data != null) {
          final List<CricketMatchOdds> matches = (data['data'] as List<dynamic>)
              .map((json) => CricketMatchOdds.fromJson(json))
              .toList();
          return matches;
        } else {
          throw Exception('Invalid data format: Missing required fields');
        }
      } else {
        throw Exception('Failed to fetch live match');
      }
    } catch (error) {
   
      throw Exception('Failed to fetch live match');
    }
  }
}
