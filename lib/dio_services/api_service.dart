import 'package:dio/dio.dart';
import 'package:hamilton1/dio_services/api_url_constant.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.validateStatus = (status) {
      return status != null && status < 500;
    };
  }

  Future<Response> postDataWithForm(Map<String, dynamic> formData, String path,
      {Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.post(
        AppConstant.baseUrl + path,
        options: Options(headers: headers),
        data: FormData.fromMap(formData),
      );
      return response;
    } catch (error) {
      throw Exception('API Request Error: $error');
    }
  }

  Future<Response> getDataWithForm(
      String path, Map<String, dynamic> headers) async {
    try {
      final response = await _dio.get(AppConstant.baseUrl + path,
          options: Options(headers: headers));
      return response;
    } catch (error) {
      throw Exception('API Request Error: $error');
    }
  }
}
