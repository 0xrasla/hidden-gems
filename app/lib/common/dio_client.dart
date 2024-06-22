import 'package:app/common/config.dart';
import 'package:app/common/prefs.dart';
import 'package:dio/dio.dart';

class ApiClient {
  static final Dio _dio = Dio();

  static Dio get dio => _dio;

  ApiClient._();

  static void initialize() async {
    _dio.options.baseUrl = AppConfig.apiUrl;

    String? token = await SharedPrefsHelper.getString("token");

    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}
