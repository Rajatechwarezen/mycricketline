

import '../../../core/utilis/method.dart';
import '../../../core/utilis/url.dart';
import '../../servies/api_service.dart';

class ReferralRepo{
  ApiClient apiClient;
  ReferralRepo({required this.apiClient});

  Future<ResponseModel?> getReferralData(int page)async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.referralEndPoint}?page=$page";

    ResponseModel? responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }
}