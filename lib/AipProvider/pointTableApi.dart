import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/player.dart';
import '../model/pointTableData.dart';

class YourDataProvider with ChangeNotifier {
  List<PointTable> _pointTables = [];

  List<PointTable> get pointTables => _pointTables;

  fetchPointTable(id) async {
    const url =
        'http://apicricketchampion.in/webservices/pointsTable/20122cd5366e30f0847774c9d7698d30';

    try {
      var filterId = id.toString().replaceAll("\\p{P}", "");
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['series_id'] = "243";
      print("id :====$id");
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody);
        print(data);
        if (data != null && data['data'] is List) {
          final List<PointTable> pointTables = (data['data'] as List<dynamic>)
              .map((json) => PointTable.fromJson(json))
              .toList();

          _pointTables =
              pointTables; // Assign the list to the _pointTables variable
          notifyListeners();
        } else {
          throw Exception('Invalid data format: Missing required fields');
        }
      } else {
        throw Exception(
            'Request failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error sending request: $error');
    }
  }
}
