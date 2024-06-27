import 'package:app/common/prefs.dart';
import 'package:app/common/routes.dart';
import 'package:app/entities/User.dart';
import 'package:app/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:otpless_flutter/otpless_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _otplessFlutterPlugin = Otpless();
  var arg = {
    'appId': "12HPZZIEBD3RMOMZBPZU",
    'crossButtonHidden': "true",
  };
  var message = "";

  final AuthRepository _authRepository = AuthRepository();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var loggedIn = await SharedPrefsHelper.getBool('loggedIn');
      if (loggedIn == true && mounted) {
        Navigator.pushNamed(context, '/home');
        return;
      } else {
        await startOtpLess();
      }
    });
  }

  Future<void> startOtpLess() async {
    // Ensure that the method and parameter names are correct
    await _otplessFlutterPlugin.openLoginPage(
      (result) async {
        if (result['data'] != null) {
          final token = result['data']['token'];
          message = "token: $token";
          String phoneNumber = result['data']['identities'][0]['identityValue']
              .toString()
              .substring(2);
          User user = await _authRepository.login(phoneNumber);
          SharedPrefsHelper.setBool('loggedIn', true);
          SharedPrefsHelper.setString('phone', user.user.mobileNumber);

          if (mounted) {
            Navigator.pushNamed(context, Routes.home);
          }
        } else {
          message = result['errorMessage'];
          if (context.mounted && message == "user cancelled") {
            Navigator.pushNamed(context, Routes.splash);
          }
        }
      },
      arg,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(),
    );
  }
}
