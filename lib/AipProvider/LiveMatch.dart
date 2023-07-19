import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../model/Allmodel.dart';
import '../model/InfoData.dart';
import '../model/Livematch.dart';
import '../model/LivematchList.dart';

import '../model/Ternding.dart';
import '../model/newData.dart';
import '../model/player.dart';
import 'package:mycricketline/model/scoreModel.dart';

import '../screen/tab1/livescore/Infotab/infotab.dart';

class LiveMatchProvider extends ChangeNotifier {
  List<LiveMatch> _liveMatches = [];
  List<LiveMatch> get liveMatches => _liveMatches;

  List<LiveMatch2> _homeMatches = [];
  List<LiveMatch2> get homeMatche => _homeMatches;
  late Timer _timer;

  List<MyNews> _newsList = [];
  int _currentPage = 1;
  final int _resultsPerPage = 10;
  List<MyNews> get newsList => _newsList;

  List<LiveMatchFull> _oneliveDad = [];
  List<LiveMatchFull> get oneliveDad => _oneliveDad;

  // fetchLiveMatchesFullData(int id) async {
  //   const url =
  //       'http://apicricketchampion.in/webservices/liveMatch/20122cd5366e30f0847774c9d7698d30';

  //   try {
  //     final request = http.MultipartRequest('POST', Uri.parse(url));
  //     request.fields['match_id'] = "$id";

  //     final response = await request.send();

  //     if (response.statusCode == 200) {
  //       final responseBody = await response.stream.bytesToString();
  //       final data = json.decode(responseBody);
  //       if (data['status'] == true && data['data'] != null) {
  //         if (data['data'] is List) {
  //           List<LiveMatchFull> matches = (data['data'] as List)
  //               .map((json) => LiveMatchFull.fromJson(json))
  //               .toList();

  //           _oneliveDad = matches;
  //           print(_oneliveDad.length);
  //         } else {
  //           throw Exception('Invalid data format: Expected a list of matches');
  //         }
  //       } else {
  //         throw Exception('Invalid data format: Missing required fields');
  //       }
  //     } else {
  //       throw Exception('Failed to fetch live match');
  //     }
  //   } catch (error) {
  //     print(error);
  //     throw Exception('Failed to fetch live match');
  //   }
  //   notifyListeners();
  // }

  fetchLiveMatchesFullData(int id) async {
    const url =
        'http://apicricketchampion.in/webservices/liveMatch/20122cd5366e30f0847774c9d7698d30';

    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['match_id'] = "$id";

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();

        final data = json.decode(responseBody);
        if (data['status'] == true && data['data'] != null) {
          if (data['data'] is List) {
            List<LiveMatchFull> matches = (data['data'] as List)
                .map((json) => LiveMatchFull.fromJson(json))
                .toList();

            _oneliveDad = matches;
            return matches;
          } else if (data['data'] is Map) {
            // Handle the case when data is a single match object
            LiveMatchFull match = LiveMatchFull.fromJson(data['data']);
            _oneliveDad = [match];
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
      print(error);
      throw Exception('Failed to fetch live match');
    }

    notifyListeners();
  }

  void startFetching(id) {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      fetchLiveMatchesFullData(id);
    });
  }

  fetchLiveMatches() async {
    try {
      final url = Uri.parse(
          'http://apicricketchampion.in/webservices/liveMatchList/20122cd5366e30f0847774c9d7698d30');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<LiveMatch> matches = (data['data'] as List<dynamic>)
            .map((json) => LiveMatch.fromJson(json))
            .toList();
        notifyListeners();
        _liveMatches = matches;
        return data;
      } else {
        throw Exception('Failed to fetch live matches');
      }
    } catch (error) {
      throw Exception('Failed to fetch live matches: $error');
    }
  }

  Future<void> homeMatches() async {
    try {
      final url = Uri.parse(
          'http://apicricketchampion.in/webservices/homeList/20122cd5366e30f0847774c9d7698d30');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final List<LiveMatch2> home = (data['data'] as List<dynamic>)
            .map((json) => LiveMatch2.fromJson(json))
            .toList();
        _homeMatches = home;
      } else {
        throw Exception('Failed to fetch live matches');
      }
    } catch (error) {
      throw Exception('Failed to fetch live matches: $error');
    }

    notifyListeners();
  }

  fetchNewsList() async {
    final url =
        'http://apicricketchampion.in/webservices/news/20122cd5366e30f0847774c9d7698d30?page=$_currentPage&limit=$_resultsPerPage';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<MyNews> newsList = (data['data'] as List<dynamic>)
            .map((json) => MyNews.fromJson(json))
            .toList();

        // Update the news list
        if (_currentPage == 1) {
          // Clear the previous data if it's the first page
          _newsList = newsList;
        } else {
          // Append the new data to the existing list
          _newsList.addAll(newsList);
        }

        // Increment the page number for the next request
        _currentPage++;

        // Limit the news list to 10 items
        if (_newsList.length > 10) {
          _newsList = _newsList.sublist(0, 10);
        }

        notifyListeners();
      } else {
        throw Exception('Failed to fetch news list');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void clearNewsList() {
    _newsList.clear();
    _currentPage = 1;
    notifyListeners();
  }
}

class InfoProvider with ChangeNotifier {
  List<InfoData> _infoMatches = [];

  List<InfoData> get infoMatches => _infoMatches;

  fetchLiveMatchesFullDataInfo(id) async {
    const url =
        'http://apicricketchampion.in/webservices/matchInfo/20122cd5366e30f0847774c9d7698d30';

    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['match_id'] = "$id";
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();

        final data = json.decode(responseBody);

        if (data['status'] == true && data['data'] != null) {
          if (data['data'] is List) {
            List<InfoData> matches = (data['data'] as List)
                .map((json) => InfoData.fromJson(json))
                .toList();

            _infoMatches = matches;
          } else if (data['data'] is Map) {
            // Handle the case when data is a single match object
            InfoData match = InfoData.fromJson(data['data']);
            _infoMatches = [match];
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
      print(error);
      throw Exception('Failed to fetch live match');
    }

    notifyListeners();
  }
}

class SeriesProvider with ChangeNotifier {
  List<Series> _seriesMatches = [];

  List<Series> get SeriesMatches => _seriesMatches;

  fetchSeriesData() async {
    try {
      final url = Uri.parse(
          'http://apicricketchampion.in/webservices/seriesList/20122cd5366e30f0847774c9d7698d30/');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<Series> matches = (data['data'] as List<dynamic>)
            .map((json) => Series.fromJson(json))
            .toList();
        notifyListeners();
        _seriesMatches = matches;

        return matches;
      } else {
        throw Exception('Failed to fetch live matches');
      }
    } catch (error) {
      throw Exception('Failed to fetch live matches: $error');
    }
  }
}

class BlogProvider with ChangeNotifier {
  List<Blog> _dataObject = [];

  List<Blog> get blogMatches => _dataObject;

  Future<void> getBlogData() async {
    final url = Uri.parse('http://cricapi.lineofcricket.com/api/getblog');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final dataList = jsonData['data'] as List<dynamic>;
        _dataObject = dataList.map((item) => Blog.fromJson(item)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load blog data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}

class PlayerProvider with ChangeNotifier {
  MatchData? _player;

  MatchData? get player => _player;

  Future<void> PlayerMatchesFullData(String id) async {
    const url =
        'http://apicricketchampion.in/webservices/playersByMatchId/20122cd5366e30f0847774c9d7698d30';
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['match_id'] = id;

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();

        final data = json.decode(responseBody);
        if (data['status'] == true && data['data'] != null) {
          if (data['data'] != null) {
            // List<MatchData>? matches = (data['data'] as List)
            //     .map((json) => MatchData.fromJson(json))
            //     .toList();
            final matches = MatchData.fromJson(data as Map<String, dynamic>);

            _player = matches;
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
      print(error);
      throw Exception('Failed to fetch live match');
    }

    notifyListeners();
  }
}

// Scorer Board

class ScorerProvider with ChangeNotifier {
  List<BatsmanData> _scorerProvider = [];

  List<BatsmanData> get scorerProvider => _scorerProvider;

  ScoreData? _scorerData;
  ScoreData? get scorerData => _scorerData;
  fetchScorecard(String id) async {
    const url =
        'http://apicricketchampion.in/webservices/scorecardByMatchId/20122cd5366e30f0847774c9d7698d30';

    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['match_id'] = id;

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody);

        if (data['status'] == true && data['data'] != null) {
          if (data != null) {
            // final List<BatsmanData> batsman =
            //     (data['data']["scorecard"]["1"]["batsman"] as List<dynamic>)
            //         .map((json) => BatsmanData.fromJson(json))
            //         .toList();
            // _scorerProvider = batsman;

////////////////////////////////////////////
            final inning = ScoreData.fromJson(data as Map<String, dynamic>);

            _scorerData = inning;
          } else {
            throw Exception('Invalid data format: Unexpected data type');
          }
        } else {
          throw Exception('Invalid data format: Missing required fields');
        }

        notifyListeners();
      } else {
        throw Exception('Failed to fetch live matches');
      }
    } catch (error) {
      print(error);
      throw Exception('Failed to fetch live match');
    }
  }
}
