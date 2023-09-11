import 'dart:math';

import 'package:flutter/material.dart';

class CalculatorBrain {
  CalculatorBrain({this.height, this.weight});

  final int weight;
  final int height;

  double _bmi;

  String calculateBMI() {
    this._bmi = weight / pow((height / 100), 2);
    return this._bmi.toStringAsFixed(1);
  }

  getResult() {
    if (this._bmi >= 25) {
      return 'Overweight';
    } else if (this._bmi >= 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  getInterpretaion() {
    if (this._bmi >= 25) {
      return 'You have an higher body weight than normal. Try to exercise more.';
    } else if (this._bmi >= 18.5) {
      return 'You have a nromal body weight. Well done!';
    } else {
      return 'You have a lower than normal body weight. Try to eat more.';
    }
  }

  getRange() {
    if (this._bmi >= 25) {
      return 'Overweight BMI range (25 to 29.9), and obese BMI range (30 or more)';
    } else if (this._bmi >= 18.5) {
      return 'Normal BMI range (18.5 to 24.9)';
    } else {
      return 'Underweight BMI range (under 18.5 kg/m2)';
    }
  }

  getResultColor() {
    if (this._bmi >= 25) {
      return Colors.red;
    } else if (this._bmi >= 18.5) {
      return Color(0xFF24D876);
    } else {
      return Colors.blue;
    }
  }
}
