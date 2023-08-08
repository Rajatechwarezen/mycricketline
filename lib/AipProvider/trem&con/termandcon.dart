import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/TermAndConditionData.dart';

Future<List<About>> about() async {
  try {
    final url = Uri.parse('http://cricapi.mycricketline.com/api/aboutget');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final List<About> matches = (data['data'] as List<dynamic>)
          .map((json) => About.fromJson(json))
          .toList();

      return matches;
    } else {
      throw Exception('Failed to fetch aboutget aboutget');
    }
  } catch (error) {
    throw Exception('Failed to fetch aboutget aboutget: $error');
  }
}

Future<List<PrivacyPolicy>> ppolicyget() async {
  try {
    final url = Uri.parse('http://cricapi.mycricketline.com/api/ppolicyget');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final List<PrivacyPolicy> matches = (data['data'] as List<dynamic>)
          .map((json) => PrivacyPolicy.fromJson(json))
          .toList();

      return matches;
    } else {
      throw Exception('Failed to fetch Privacy ppolicyget');
    }
  } catch (error) {
    throw Exception('Failed to fetch Privacy ppolicyget: $error');
  }
}

Future<List<PrivacyPolicy>> TremAndCondition() async {
  try {
    final url = Uri.parse('http://cricapi.mycricketline.com/api/termsget');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final List<PrivacyPolicy> matches = (data['data'] as List<dynamic>)
          .map((json) => PrivacyPolicy.fromJson(json))
          .toList();

      return matches;
    } else {
      throw Exception('Failed to fetch Privacy termsget');
    }
  } catch (error) {
    throw Exception('Failed to fetch Privacy termsget: $error');
  }
}
