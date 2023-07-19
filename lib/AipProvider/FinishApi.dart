import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mycricketline/model/Ternding.dart';

import '../model/FinishData.dart';
import '../model/upcomingData.dart';

class FinishMatchesProvider with ChangeNotifier {
  List<FinishData> _finishDataMatches = [];

  List<FinishData> get finishDataMatches => _finishDataMatches;

  fetchUpcomingMatchesFullData() async {
    try {
      final url = Uri.parse(
          'http://apicricketchampion.in/webservices/recentMatches/20122cd5366e30f0847774c9d7698d30');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final List<FinishData> home = (data['data'] as List<dynamic>)
            .map((json) => FinishData.fromJson(json))
            .toList();

        _finishDataMatches = home;
      } else {
        throw Exception('Failed to fetch live matches');
      }
    } catch (error) {
      throw Exception('Failed to fetch live matches: $error');
    }

    notifyListeners();
  }

  ///MatchesBySeriesFinish SeriesId upcoming
  List<MatchesBySeriesFinish> _matchesBySeriesFinish = [];

  List<MatchesBySeriesFinish> get matchesBySeriesFinish =>
      _matchesBySeriesFinish;

  trendingMatchesBySeriesFinishData(seriesid) async {
    const url =
        'http://apicricketchampion.in/webservices/matchesRecentBySeriesId/20122cd5366e30f0847774c9d7698d30';
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['series_id'] = "$seriesid";

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print('${responseBody}${seriesid}');
        final data = json.decode(responseBody);
        if (data['status'] == true && data['data'] != null) {
          if (data['data'] is List) {
            List<MatchesBySeriesFinish> matches = (data['data'] as List)
                .map((json) => MatchesBySeriesFinish.fromJson(json))
                .toList();

            _matchesBySeriesFinish = matches;
            return matches;
          } else if (data['data'] is Map) {
            // Handle the case when data is a single match object
            MatchesBySeriesFinish match =
                MatchesBySeriesFinish.fromJson(data['data']);
            _matchesBySeriesFinish = [match];
          } else {
            throw Exception('Invalid data format: Unexpected data type');
          }
        } else {
          throw Exception('Invalid data format: Missing required fields');
        }
      } else {
        throw Exception('Failed to fetch live match');
      }
    } catch (error) {
      throw Exception('Failed to fetch live matches: $error');
    }

    notifyListeners();
  }

  ///MatchesBySeriesFinish SeriesId upcoming
  List<ImageShotData> _shortData = [];

  List<ImageShotData> get shortData => _shortData;

  Future<List<ImageShotData>> ShortData() async {
    try {
      final url =
          Uri.parse('http://cricapi.lineofcricket.com/api/getactiveshorts');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        final List<ImageShotData> matches = (data['data'] as List<dynamic>)
            .map((json) => ImageShotData.fromJson(json))
            .toList();
        notifyListeners();
        _shortData = matches;
        return matches;
      } else {
        throw Exception('Failed to fetch live matches');
      }
    } catch (error) {
      throw Exception('Failed to fetch live matches: $error');
    }
  }
}
