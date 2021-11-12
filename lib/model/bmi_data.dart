import 'package:flutter/foundation.dart';

class BMIData with ChangeNotifier {
  static const MAX_AGE = 140;
  static const MIN_AGE = 1;
  static const MIN_WEIGHT = 3;
  static const MAX_WEIGHT = 500;
  static const MIN_HEIGHT = 30;
  static const MAX_HEIGHT = 280;

  /// Height in cm
  int get height => _height;
  int _height = 170;
  void setHeight(int v) => n(() => _height = v.clamp(MIN_HEIGHT, MAX_HEIGHT));

  /// Weight in kg
  int get weight => _weight;
  int _weight = 75;
  void setWeight(int v) => n(() => _weight = v.clamp(MIN_WEIGHT, MAX_WEIGHT));

  /// Age in years
  int get age => _age;
  int _age = 20;
  void setAge(int v) => n(() => _age = v.clamp(MIN_AGE, MAX_AGE));

  /// Gender
  Gender get gender => _gender;
  Gender _gender = Gender.female;
  void setGender(Gender v) => n(() => _gender = v);

  void n(VoidCallback v) {
    v();
    notifyListeners();
  }
}

enum Gender { male, female }
