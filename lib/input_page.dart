import 'package:bmi_calculator/result_page.dart';
import 'package:bmi_calculator/shared_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/bmi_data.dart';

class InputPage extends StatefulWidget {
  /// Returns entry label style
  static TextStyle getLabelStyle(BuildContext context) {
    return Theme.of(context).textTheme.caption!.copyWith(
          fontSize: 18,
        );
  }

  /// Returns entry value style
  static TextStyle getValueStyle(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(fontSize: 48);
  }

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BMI CALCULATOR')),
      body: ChangeNotifierProvider<BMIData>(
        create: (context) => BMIData(),
        builder: (context, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Row 1
              Expanded(
                child: Row(
                  children: [
                    // "Male" selector button
                    ReusableCard(
                      child: CardButton(gender: Gender.male),
                    ),
                    // "Female" selector button
                    ReusableCard(
                      child: CardButton(gender: Gender.female),
                    ),
                  ],
                ),
              ),

              // Height selector (row 2)
              ReusableCard(
                child: HeightSelector(),
              ),

              // Weight / Age selectors (row 3)
              Expanded(
                child: Row(
                  children: [
                    ReusableCard(
                        child: IncrDecr(
                            label: 'WEIGHT (kg)',
                            getter: (m) => m.weight,
                            setter: (m, v) => m.setWeight(v))
                        // child: _plusMinus(
                        //     context, 'WEIGHT (kg)', _weight, _updateWeight),
                        ),
                    ReusableCard(
                      child: IncrDecr(
                          label: 'AGE',
                          getter: (m) => m.age,
                          setter: (m, v) => m.setAge(v)),
                    ),
                  ],
                ),
              ),
              BottomButton(
                text: 'CALCULATE YOUR BMI',
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (ctx) => ResultPage(
                        model: Provider.of<BMIData>(context, listen: false),
                      ),
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}

/// Widget to increment / decrement a single value
class IncrDecr extends StatelessWidget {
  final Function(BMIData, int) setter;
  final int Function(BMIData) getter;
  final String label;

  const IncrDecr(
      {Key? key,
      required this.setter,
      required this.getter,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BMIData>(
      builder: (context, model, child) {
        final value = getter(model);

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(label, style: InputPage.getLabelStyle(context)),
            Text('$value', style: InputPage.getValueStyle(context)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                incrDecrButton(context, model, false),
                incrDecrButton(context, model, true),
              ],
            )
          ],
        );
      },
    );
  }

  /// Creates a single plus or minus button
  Widget incrDecrButton(BuildContext context, BMIData model, bool add) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).dividerColor,
        onPrimary: InputPage.getLabelStyle(context).color,
        shape: CircleBorder(),
        padding: EdgeInsets.all(8),
        elevation: 0,
      ),
      child: Icon(
        add ? Icons.add : Icons.remove,
        size: 36,
      ),
      onPressed: () => setter(model, getter(model) + (add ? 1 : -1)),
    );
  }
}

/// Height selector widget
class HeightSelector extends StatelessWidget {
  const HeightSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BMIData>(builder: (context, model, child) {
      final tt = Theme.of(context).textTheme;
      final labelStyle = InputPage.getLabelStyle(context);

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('HEIGHT', style: labelStyle),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '${model.height}',
                  style: tt.headline6!.copyWith(fontSize: 48),
                ),
                Text('cm', style: labelStyle)
              ],
            ),
            Slider(
              value: model.height.toDouble(),
              onChanged: (v) => model.setHeight(v.toInt()),
              min: BMIData.MIN_HEIGHT.toDouble(),
              max: BMIData.MAX_HEIGHT.toDouble(),
            )
          ],
        ),
      );
    });
  }
}

/// Card Male / Female button widget
class CardButton extends StatelessWidget {
  final Gender gender;

  const CardButton({
    Key? key,
    required this.gender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedColor = theme.colorScheme.onBackground.withOpacity(0.1);
    final text = gender == Gender.male ? 'MALE' : 'FEMALE';
    final icon = gender == Gender.male ? Icons.male : Icons.female;

    return Consumer<BMIData>(builder: (context, model, child) {
      final isActive = model.gender == gender;
      var onPrimary = isActive
          ? theme.textTheme.bodyText1!.color
          : theme.textTheme.caption!.color;

      return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(0),
            primary: isActive ? selectedColor : Colors.transparent,
            onPrimary: onPrimary,
            elevation: 0),
        onPressed: () => model.setGender(gender),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 72,
              color: onPrimary,
            ),
            SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      );
    });
  }
}
