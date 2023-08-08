import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/adsData.dart';

Future<List<AdData>> fetchAdsFromApi() async {
  final apiUrl =
      'http://cricapi.mycricketline.com/api/getactviedisplayad'; // Replace with your API endpoint

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      final List<dynamic> data = responseData['data'];

      return data.map((item) => AdData.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
