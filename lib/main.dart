import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:very_good_coffee_app/features/body/application_body.dart';
import 'package:very_good_coffee_app/features/home/home_page.dart';
import 'package:very_good_coffee_app/features/shared/images_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF111111);

    return MaterialApp(
      title: 'Very Good Coffee App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        scaffoldBackgroundColor: primaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: Colors.white),
        dividerColor: Colors.transparent,
        dividerTheme: const DividerThemeData(color: Colors.transparent),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (_) => ImagesProvider(),
        child: const ApplicationBody(),
      ),
    );
  }
}
