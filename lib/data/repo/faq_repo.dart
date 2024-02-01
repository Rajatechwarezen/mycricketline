  
import 'package:sprotbuzz/core/utilis/url.dart';
import 'package:sprotbuzz/data/servies/api_service.dart';

import '../../core/utilis/method.dart';

class FaqRepo{

  ApiClient apiClient;
  FaqRepo({required this.apiClient});

  Future<dynamic>loadFaq()async{

    String url='${UrlContainer.baseUrl}';
    final response=await apiClient.request(url,Method.getMethod,null);
    return response;
  }

}