import 'package:bmi_calculator/shared_widgets.dart';
import 'package:flutter/material.dart';

class ResultCategory {
  final double minRange;
  final double maxRange;
  final Color color;
  final String name;

  const ResultCategory(this.minRange, this.maxRange, this.color, this.name);
  bool inRange(double bmi) => bmi >= minRange && bmi < maxRange;
}

final resultCategories = [
  ResultCategory(
      double.negativeInfinity, 16.0, Colors.red[900]!, 'SEVERELY UNDERWEIGHT'),
  ResultCategory(16.0, 17, Colors.red[700]!, 'MODERATELY UNDERWEIGHT'),
  ResultCategory(16.0, 18.5, Colors.orange[300]!, 'UNDERWEIGHT'),
  ResultCategory(18.5, 25, Colors.green, 'NORMAL'),
  ResultCategory(25.0, 30, Colors.orange[300]!, 'OVERWEIGHT'),
  ResultCategory(30, 35, Colors.red[400]!, 'CLASS 1 OBESE'),
  ResultCategory(35, 40, Colors.red[700]!, 'CLASS 2 OBESE'),
  ResultCategory(40, double.infinity, Colors.red[900]!, 'CLASS 3 OBESE'),
];

class ResultPage extends StatelessWidget {
  final int height;
  final int weight;
  final int age;

  const ResultPage(
      {Key? key, required this.height, required this.weight, required this.age})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hm = height / 100.0;
    final bmi = weight.toDouble() / (hm * hm);

    return Scaffold(
      appBar: AppBar(title: Text('BMI CALCULATOR')),
      body: Column(
        children: [
          SizedBox(height: 24),
          Text(
            'Your Result',
            style: Theme.of(context).textTheme.headline3!.copyWith(
                color: Theme.of(context).textTheme.bodyText1!.color,
                fontWeight: FontWeight.bold),
          ),
          ReusableCard(
            child: ResultCard(bmi: bmi),
          ),
          BottomButton(
            onPressed: () => Navigator.pop(context),
            text: 'RE-CALCULATE YOUR BMI',
          )
        ],
      ),
    );
  }
}

class ResultCard extends StatelessWidget {
  final double bmi;

  const ResultCard({Key? key, required this.bmi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    var cat = resultCategories.firstWhere((c) => c.inRange(bmi));

    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              cat.name,
              style: tt.headline5!.copyWith(
                color: cat.color,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              bmi.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 96,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Normal BMI range:',
              style: tt.caption!.copyWith(fontSize: 24),
            ),
            SizedBox(height: 8),
            Text(
              '18,5 - 25 kg/m2',
              style: TextStyle(fontSize: 24),
            )
          ],
        ),
      ),
    );
  }
}
