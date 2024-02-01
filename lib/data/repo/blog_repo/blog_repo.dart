
import '../../../core/utilis/method.dart';
import '../../../core/utilis/url.dart';
import '../../servies/api_service.dart';

class BlogRepo{
  ApiClient apiClient;
  BlogRepo({required this.apiClient});

  Future<ResponseModel?> getBlogData()async{
    String url = "${UrlContainer.blogNews}";

    ResponseModel? responseModel = await apiClient.requestGet(url, Method.getMethod);
    return responseModel;
  }
}