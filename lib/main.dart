import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:very_good_coffee_app/features/body/application_body.dart';
import 'package:very_good_coffee_app/features/shared/custom_colors.dart';
import 'package:very_good_coffee_app/features/shared/images_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Very Good Coffee App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: CustomColors.primaryColor),
        scaffoldBackgroundColor: CustomColors.primaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: CustomColors.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Colors.white),
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
