import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/Ternding.dart';
import '../model/upcomingData.dart';

class UpcomingMatchesProvider with ChangeNotifier {
  List<Upcomingdata> _upcomingMatches = [];

  List<Upcomingdata> get upcomingMatches => _upcomingMatches;

  fetchUpcomingMatchesFullData() async {
    try {
      final url = Uri.parse(
          'http://apicricketchampion.in/webservices/upcomingMatches/20122cd5366e30f0847774c9d7698d30');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final List<Upcomingdata> home = (data['data'] as List<dynamic>)
            .map((json) => Upcomingdata.fromJson(json))
            .toList();

        _upcomingMatches = home;
      } else {
        throw Exception('Failed to fetch live matches');
      }
    } catch (error) {
      throw Exception('Failed to fetch live matches: $error');
    }

    notifyListeners();
  }

  ///trending SeriesId upcoming
  List<MatchesBySeriesId> _trendingUpcoming = [];

  List<MatchesBySeriesId> get trendingUpcoming => _trendingUpcoming;

  trendingUpcomingMatchesFullData(seriesid) async {
    const url =
        'http://apicricketchampion.in/webservices/matchesBySeriesId/20122cd5366e30f0847774c9d7698d30';
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['series_id'] = "$seriesid";

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();

        final data = json.decode(responseBody);
        if (data['status'] == true && data['data'] != null) {
          if (data['data'] is List) {
            List<MatchesBySeriesId> matches = (data['data'] as List)
                .map((json) => MatchesBySeriesId.fromJson(json))
                .toList();

            _trendingUpcoming = matches;
            return matches;
          } else if (data['data'] is Map) {
            // Handle the case when data is a single match object
            MatchesBySeriesId match = MatchesBySeriesId.fromJson(data['data']);
            _trendingUpcoming = [match];
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
}
