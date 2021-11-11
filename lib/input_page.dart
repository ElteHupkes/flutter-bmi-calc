import 'package:bmi_calculator/result_page.dart';
import 'package:bmi_calculator/shared_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  static const MAX_AGE = 140;
  static const MIN_AGE = 1;
  static const MIN_WEIGHT = 3;
  static const MAX_WEIGHT = 500;
  static const MIN_HEIGHT = 30;
  static const MAX_HEIGHT = 280;

  //#region State
  bool _male = false;
  int _heightCm = 170;
  int _age = 19;
  int _weight = 75;
  //#endregion

  /// Returns entry label style
  TextStyle getLabelStyle(BuildContext context) {
    return Theme.of(context).textTheme.caption!.copyWith(
          fontSize: 18,
        );
  }

  /// Returns entry value style
  TextStyle getValueStyle(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(fontSize: 48);
  }

  /// Callback to update the age
  void _updateAge(bool increment) {
    if (increment && _age < MAX_AGE) {
      _age++;
    } else if (!increment && _age > MIN_AGE) {
      _age--;
    }
  }

  /// Callback to update the weight
  void _updateWeight(bool increment) {
    if (increment && _age < MAX_WEIGHT) {
      _weight++;
    } else if (!increment && _age > MIN_WEIGHT) {
      _weight--;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BMI CALCULATOR')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Row 1
          Expanded(
            child: Row(
              children: [
                // "Male" selector button
                ReusableCard(
                  child: _cardButton(context, true),
                ),
                // "Female" selector button
                ReusableCard(
                  child: _cardButton(context, false),
                ),
              ],
            ),
          ),

          // Height selector (row 2)
          ReusableCard(
            child: _heightSelector(context),
          ),

          // Weight / Age selectors (row 3)
          Expanded(
            child: Row(
              children: [
                ReusableCard(
                  child: _plusMinus(
                      context, 'WEIGHT (kg)', _weight, _updateWeight),
                ),
                ReusableCard(
                  child: _plusMinus(context, 'AGE', _age, _updateAge),
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
                          height: _heightCm, weight: _weight, age: _age)));
            },
          )
        ],
      ),
    );
  }

  void _updateGender(bool isMale) {
    setState(() => _male = isMale);
  }

  /// Creates the male / female button widgets
  Widget _cardButton(BuildContext context, bool male) {
    return CardButton(
      currentMale: _male,
      male: male,
      update: _updateGender,
    );
  }

  /// Creates the height selector widget
  Widget _heightSelector(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final labelStyle = getLabelStyle(context);

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
                '$_heightCm',
                style: tt.headline6!.copyWith(fontSize: 48),
              ),
              Text('cm', style: labelStyle)
            ],
          ),
          Slider(
            value: _heightCm.toDouble(),
            onChanged: (v) => setState(() {
              _heightCm = v.toInt();
            }),
            min: MIN_HEIGHT.toDouble(),
            max: MAX_HEIGHT.toDouble(),
          )
        ],
      ),
    );
  }

  /// Returns an increase / decrease widget
  Widget _plusMinus(
      BuildContext context, String label, int value, Function(bool) change) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(label, style: getLabelStyle(context)),
        Text('$value', style: getValueStyle(context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _pmButton(context, false, () => setState(() => change(false))),
            _pmButton(context, true, () => setState(() => change(true))),
          ],
        )
      ],
    );
  }

  /// Plus / minus button for use inside [_plusMinus].
  Widget _pmButton(BuildContext context, bool add, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Theme.of(context).dividerColor,
          onPrimary: getLabelStyle(context).color,
          shape: CircleBorder(),
          padding: EdgeInsets.all(8),
          elevation: 0),
      child: Icon(
        add ? Icons.add : Icons.remove,
        size: 36,
      ),
      onPressed: onPressed,
    );
  }
}

/// Card Male / Female button widget
class CardButton extends StatelessWidget {
  final bool currentMale;
  final bool male;
  final Function(bool) update;

  const CardButton({
    Key? key,
    required this.currentMale,
    required this.male,
    required this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedColor = theme.colorScheme.onBackground.withOpacity(0.1);
    final isActive = currentMale == male;
    final text = male ? 'MALE' : 'FEMALE';
    final icon = male ? Icons.male : Icons.female;
    var onPrimary = isActive
        ? theme.textTheme.bodyText1!.color
        : theme.textTheme.caption!.color;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(0),
          primary: isActive ? selectedColor : Colors.transparent,
          onPrimary: onPrimary,
          elevation: 0),
      onPressed: () => update(male),
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
  }
}
