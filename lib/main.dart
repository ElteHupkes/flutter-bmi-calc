import 'package:flutter/material.dart';
import 'input_page.dart';

const baseColor = Color(0xff0a0e21);
const containerColor = Color(0xff1d1e33);
const primaryColor = Color(0xFFD73459);

void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final baseDarkTheme = ThemeData.from(
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        onPrimary: Colors.white,
        background: baseColor,
        surface: containerColor,
      ),
      textTheme: Typography.whiteMountainView.apply(
        displayColor: Colors.white70,
        bodyColor: Colors.white,
      ),
    );

    final darkTheme = baseDarkTheme.copyWith(
      scaffoldBackgroundColor: baseColor,
      applyElevationOverlayColor: false,
      appBarTheme: baseDarkTheme.appBarTheme.copyWith(
        elevation: 4,
        backgroundColor: baseDarkTheme.backgroundColor,
      ),
    );

    final baseLightTheme = ThemeData.from(
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        surface: Colors.black.withOpacity(0.05),
      ),
      textTheme: Typography.blackMountainView,
    );
    final lightTheme = baseLightTheme.copyWith(
      appBarTheme: baseLightTheme.appBarTheme.copyWith(
          elevation: 4,
          backgroundColor: baseLightTheme.colorScheme.background,
          foregroundColor: baseLightTheme.colorScheme.onBackground),
    );

    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: InputPage(),
      // home: ResultPage(height: 170, weight: 80, age: 23),
    );
  }
}
