import 'package:bmi_calculator/result_page.dart';
import 'package:flutter/material.dart';
import 'input_page.dart';

final baseColor = Color(0xff0a0e21);
final containerColor = Color(0xff1d1e33);

void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData.from(
      colorScheme: ColorScheme.dark(
        primary: Color(0xFFD73459),
        onPrimary: Colors.white,
        background: baseColor,
        surface: containerColor,
      ),
      textTheme: Typography.whiteMountainView.apply(
        displayColor: Colors.white70,
        bodyColor: Colors.white,
      ),
    );

    final theme = baseTheme.copyWith(
      scaffoldBackgroundColor: baseColor,
      applyElevationOverlayColor: false,
      appBarTheme: baseTheme.appBarTheme.copyWith(
        elevation: 4,
        backgroundColor: baseTheme.backgroundColor,
      ),
    );

    return MaterialApp(
      theme: theme,
      home: InputPage(),
      // home: ResultPage(height: 170, weight: 80, age: 23),
    );
  }
}
