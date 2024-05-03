import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:very_good_coffee_app/features/body/application_body.dart';
import 'package:very_good_coffee_app/features/providers/connection_provider.dart';
import 'package:very_good_coffee_app/features/shared/custom_colors.dart';
import 'package:very_good_coffee_app/features/providers/images_provider.dart';

void main() {
  runApp(const VeryGoodCoffeeApp());
}

class VeryGoodCoffeeApp extends StatelessWidget {
  const VeryGoodCoffeeApp({super.key});

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
          bodySmall: TextStyle(
            color: Colors.white,
            fontFamily: 'Celias',
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
            fontFamily: 'Celias',
          ),
          titleLarge: TextStyle(
            color: Colors.white,
            fontFamily: 'Point Panther',
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontFamily: 'Celias'),
          ),
        ),
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: Colors.white),
        dividerColor: Colors.transparent,
        dividerTheme: const DividerThemeData(color: Colors.transparent),
        useMaterial3: true,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ImagesProvider()),
          ChangeNotifierProvider(create: (_) => ConnectionProvider()),
        ],
        child: const ApplicationBody(),
      ),
    );
  }
}
