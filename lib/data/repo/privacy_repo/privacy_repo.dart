
import '../../../core/utilis/method.dart';
import '../../../core/utilis/url.dart';
import '../../servies/api_service.dart';

class PrivacyRepo{

  ApiClient apiClient;
  PrivacyRepo({required this.apiClient});

  Future<dynamic>loadPrivacyAndPolicy()async{
    String url='${UrlContainer.baseUrl}${UrlContainer.privacyPolicyEndPoint}?template=';
    final response=await apiClient.request(url,Method.getMethod,null);
    return response;
  }

}