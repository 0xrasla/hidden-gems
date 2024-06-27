import 'package:app/entities/User.dart';
import 'package:app/services/auth_services.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  bool isLoading = false;

  Future<User> login(String phoneNumber) async {
    try {
      isLoading = true;
      var response = await _authService.login(phoneNumber);
      isLoading = false;
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> logout() async {
    return await _authService.logout();
  }
}
