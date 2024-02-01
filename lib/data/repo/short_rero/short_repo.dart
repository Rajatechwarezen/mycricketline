import '../../../core/utilis/method.dart';
import '../../servies/api_service.dart';

class ShortRepo {
  final String baseUrl = 'http://cricapi.mycricketline.com/api';
  ApiClient apiClient;
  ShortRepo({required this.apiClient});
  Future<ResponseModel?> geLikeData(params) async {
    String url = "$baseUrl/updatelike";

    ResponseModel? responseModel = await apiClient
        .request(url, Method.postMethod, params, passHeader: true);
    return responseModel;
  }

  // ignore: non_constant_identifier_names
  Future<ResponseModel?> getShortData() async {
    try {
      const url = 'http://cricapi.mycricketline.com/api/getactiveshorts';

      ResponseModel? responseModel =
          await apiClient.requestGet(url, Method.postMethod, passHeader: true);

      return responseModel;
    } catch (error) {
      throw Exception('Failed to fetch live matches: $error');
    }
  }
}
