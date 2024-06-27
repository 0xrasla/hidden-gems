import 'package:app/common/dio_client.dart';
import 'package:app/entities/User.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  final Dio _dio = ApiClient.dio;

  Future<User> login(String phoneNumber) async {
    try {
      var response =
          await _dio.post("/auth/login", data: {"mobileNumber": phoneNumber});

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Login Successful");
        return User.fromJson(response.data);
      } else {
        Fluttertoast.showToast(msg: "Login Failed");
        throw Exception(response.data["message"]);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      rethrow;
    }
  }

  Future<bool> logout() async {
    return true;
  }
}
