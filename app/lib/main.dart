import 'package:app/common/colors.dart';
import 'package:app/common/dio_client.dart';
import 'package:app/common/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ApiClient.initialize();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.splash,
      title: 'Hidden Spots',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: AppColors.commonColor),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.commonColor),
        useMaterial3: true,
      ),
    );
  }
}
