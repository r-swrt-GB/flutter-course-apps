import 'package:bmi_calculator/pages/results_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../calculations/./calculator_brain.dart';
import '../components/bottom_button.dart';
import '../components/reusable_card.dart';
import '../components/reusable_icon.dart';
import '../components/round_icon_button.dart';
import '../data/constants.dart';

enum PickedGender { male, female, none }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Color maleActiveIconColour = Colors.blue;
  Color femaleActiveIconColour = Color.fromARGB(255, 233, 30, 182);
  PickedGender activeGender = PickedGender.none;
  int userHeight = 175;
  int weight = 60;
  int age = 20;

  updatedHeight(int height) {
    setState(() {
      userHeight = height;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
        backgroundColor: kActiveCardColour,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        activeGender == PickedGender.male
                            ? activeGender = PickedGender.none
                            : activeGender = PickedGender.male;
                      });
                    },
                    child: ReusableCard(
                        colour: activeGender == PickedGender.male
                            ? kActiveCardColour
                            : kInactiveCardColour,
                        cardChild: CardContent(
                          cardText: "Male",
                          cardIcon: FontAwesomeIcons.mars,
                          iconColor: activeGender == PickedGender.male
                              ? maleActiveIconColour
                              : Colors.white,
                        )),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        activeGender == PickedGender.female
                            ? activeGender = PickedGender.none
                            : activeGender = PickedGender.female;
                      });
                    },
                    child: ReusableCard(
                      colour: activeGender == PickedGender.female
                          ? kActiveCardColour
                          : kInactiveCardColour,
                      cardChild: CardContent(
                        cardText: "Female",
                        cardIcon: FontAwesomeIcons.venus,
                        iconColor: activeGender == PickedGender.female
                            ? femaleActiveIconColour
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ReusableCard(
                colour: kActiveCardColour,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Height',
                      style: kCardTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          userHeight.toString(),
                          style: kDisplayText,
                        ),
                        Text(
                          'cm',
                          style: kCardTextStyle,
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          thumbColor: kBottomContainerColour,
                          overlayColor: kBottomContainerColour,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 11.0)),
                      child: Slider(
                        value: userHeight.toDouble(),
                        onChanged: (newHeight) =>
                            updatedHeight(newHeight.toInt()),
                        min: 120.00,
                        max: 225.00,
                        thumbColor: kBottomContainerColour,
                        activeColor: Colors.white,
                        inactiveColor: Colors.grey,
                      ),
                    )
                  ],
                )),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'WEIGHT',
                          style: kCardTextStyle,
                        ),
                        Text(
                          weight.toString(),
                          style: kDisplayText,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundCircleButton(
                                icon: Icon(FontAwesomeIcons.plus),
                                onPressed: () {
                                  setState(() {
                                    weight++;
                                  });
                                }),
                            SizedBox(width: 10.0),
                            RoundCircleButton(
                                icon: Icon(FontAwesomeIcons.minus),
                                onPressed: () {
                                  setState(() {
                                    weight--;
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'AGE',
                          style: kCardTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: kDisplayText,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundCircleButton(
                                icon: Icon(FontAwesomeIcons.plus),
                                onPressed: () {
                                  setState(() {
                                    age++;
                                  });
                                }),
                            SizedBox(width: 10.0),
                            RoundCircleButton(
                                icon: Icon(FontAwesomeIcons.minus),
                                onPressed: () {
                                  setState(() {
                                    age--;
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomButton(
            buttonText: 'CALCULATE',
            onTap: () {
              CalculatorBrain calculatorBrain =
                  CalculatorBrain(height: userHeight, weight: weight);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ResultsPage(
                        bmi: calculatorBrain.calculateBMI(),
                        result: calculatorBrain.getResult(),
                        interpretation: calculatorBrain.getInterpretaion(),
                        range: calculatorBrain.getRange(),
                        resultColor: calculatorBrain.getResultColor());
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
