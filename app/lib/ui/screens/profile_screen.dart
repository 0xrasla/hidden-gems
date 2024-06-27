import 'package:app/common/colors.dart';
import 'package:app/common/prefs.dart';
import 'package:app/common/routes.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MaterialButton(
            onPressed: () async {
              if (mounted) {
                await SharedPrefsHelper.clear();
                if (context.mounted) {
                  Navigator.pushNamed(context, Routes.splash);
                }
              }
            },
            color: AppColors.accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              'Logout',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
