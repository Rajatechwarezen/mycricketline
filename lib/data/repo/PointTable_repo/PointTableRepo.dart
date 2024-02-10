import 'dart:convert';

import 'package:sprotbuzz/data/servies/api_service.dart';
import 'package:http/http.dart' as http;

import '../../../view/component/snackbar/custom_Snackbar.dart';
import '../../model/pointTable/poitTable.dart';
class PointTableRepo{
  ApiClient apiClient ;
  PointTableRepo({required this.apiClient});

 
 Future<List<PointTable>> fetchPointTable(id) async {
  const url =
      'http://apicricketchampion.in/apiv4/pointsTable/68352c40e73f0d00dc1bcab407633cdc';

  try {
    var filterId = id.toString().replaceAll("\\p{P}", "");
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['series_id'] = "313";

    final response = await request.send();

    if (response.statusCode == 200) {

      final responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody);

      if (data != null && data['data'] is List) {
        final List<PointTable> pointTables = (data['data'] as List<dynamic>)
            .map((json) => PointTable.fromJson(json))
            .toList();


        return pointTables;
      } else {
        throw Exception('Invalid data format: Missing required fields');
      }
    } else {
      throw Exception(
          'Request failed with status code: ${response.statusCode}');
    }
  } catch (error) {
      CustomSnackBar.showCustomSnackBar(errorList: ['Error fetching data: $error'], msg: [], isError: true);
       


    throw Exception('Error sending request: $error');
  }
}

  
}