import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/OddsData.dart';
import '../screen/tab1/livescore/odds/odds.dart';

class OddsApiProvider with ChangeNotifier {
  List<CricketMatchOdds>? _CricketMatchOdds;

  List<CricketMatchOdds>? get cricketMatchOdds => _CricketMatchOdds;
  matchOdds({idMatch}) async {
    const url =
        'http://apicricketchampion.in/webservices/matchOddHistory/20122cd5366e30f0847774c9d7698d30';

    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['match_id'] = "${idMatch}";

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody);
        print("data : $data");
        if (data != null) {
          final List<CricketMatchOdds> matches = (data['data'] as List<dynamic>)
              .map((json) => CricketMatchOdds.fromJson(json))
              .toList();

          _CricketMatchOdds = matches;
          notifyListeners();
        } else {
          throw Exception('Invalid data format: Missing required fields');
        }
      } else {
        throw Exception('Failed to fetch live match');
      }
    } catch (error) {
      print(error);
      throw Exception('Failed to fetch live match');
    }
  }
}
