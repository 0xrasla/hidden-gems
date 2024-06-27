import 'package:app/common/prefs.dart';
import 'package:app/common/routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var loggedIn = await SharedPrefsHelper.getBool('loggedIn');

      if (loggedIn == true && mounted) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushNamed(context, Routes.home);
        });
      } else {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushNamed(context, Routes.login);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 1),
          child: RichText(
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'Hidden ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 52,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: 'Gems',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 52,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
