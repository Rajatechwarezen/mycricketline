import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/CommentaryData.dart';

class CommentaryApiProvider with ChangeNotifier {
  CricketMatch? _commentaryApiMatches;

  CricketMatch? get commentaryApiMatches => _commentaryApiMatches;

  commentaryApiMatchesFullData(id) async {
    const url =
        'http://apicricketchampion.in/webservices/commentary/20122cd5366e30f0847774c9d7698d30';

    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['match_id'] = "$id";

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();

        final data = json.decode(responseBody);
        print(data);
        if (data != null) {
          final matches = CricketMatch.fromJson(data);
          _commentaryApiMatches = matches;
          notifyListeners();
          return matches;
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
