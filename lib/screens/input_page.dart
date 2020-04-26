import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../globals.dart';
import '../components/gender_card.dart';
import 'results_page.dart';
import '../components/calculate_button.dart';
import '../components/round_icon_button.dart';
import '../calculator_brain.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender;
  bool isMetric = false;
  int heightInCM = 180;
  int heightInInches = 70;
  int weightInKilos = 60;
  int weightInPounds = 132;
  int age = 25;

  // this function will be passed a child
  void refresh(Gender genderTapped) {
    setState(() {
      selectedGender = genderTapped;
    });
  }

  void changeStandards() {
    setState(() {
      isMetric = !isMetric;
      // convert values
      if (isMetric) {
        heightInCM = (heightInInches * 2.54).round();
        weightInKilos = (weightInPounds / 2.205).round();
      } else {
        heightInInches = (heightInCM / 2.54).round();
        weightInPounds = (weightInKilos * 2.205).round();
      }
      if (heightInCM > kMaxCM) heightInCM = kMaxCM.toInt();
      if (heightInCM < kMinCM) heightInCM = kMinCM.toInt();
      if (heightInInches > kMaxInches) heightInInches = kMaxInches.toInt();
      if (heightInInches < kMinInches) heightInInches = kMinInches.toInt();
      if (weightInKilos > kMaxKilos) weightInKilos = kMaxKilos;
      if (weightInKilos < kMinKilos) weightInKilos = kMinKilos;
      if (weightInPounds > kMaxPounds) weightInPounds = kMaxPounds;
      if (weightInPounds < kMinPounds) weightInPounds = kMinPounds;
    });
  }

  Row heightText() {
    if (isMetric) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          Text(
            heightInCM.toString(),
            style: kItemTextStyle,
          ),
          Text(
            'cm',
            style: kLabelTextStyle,
          ),
        ],
      );
    } else {
      int feet = (heightInInches ~/ 12).toInt();
      int inches = (heightInInches % 12);
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          Text(
            feet.toString(),
            style: kItemTextStyle,
          ),
          Text(
            'ft',
            style: kLabelTextStyle,
          ),
          Text(
            inches.toString(),
            style: kItemTextStyle,
          ),
          Text(
            'in',
            style: kLabelTextStyle,
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GenderCard(
                    refreshParent: refresh,
                    currentGender: selectedGender,
                    gender: Gender.male,
                  ),
                ),
                Expanded(
                  child: GenderCard(
                    refreshParent: refresh,
                    currentGender: selectedGender,
                    gender: Gender.female,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ReusableCard(
              onPress: changeStandards,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'HEIGHT',
                    style: kLabelTextStyle,
                  ),
                  heightText(),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: kSliderActiveColor,
                      inactiveTrackColor: kSliderInactiveColor,
                      overlayColor: selectedGender == Gender.male
                          ? kMaleLightColor
                          : kFemaleLightColor,
                      thumbColor: selectedGender == Gender.male
                          ? kMaleColor
                          : kFemaleColor,
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 30.0),
                    ),
                    child: Slider(
                      value: isMetric
                          ? heightInCM.toDouble()
                          : heightInInches.toDouble(),
                      min: isMetric ? kMinCM : kMinInches,
                      max: isMetric ? kMaxCM : kMaxInches,
                      onChanged: (double newValue) {
                        setState(() {
                          if (isMetric) {
                            heightInCM = newValue.round();
                          } else {
                            heightInInches = newValue.round();
                          }
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    onPress: changeStandards,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'WEIGHT',
                          style: kLabelTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              isMetric
                                  ? weightInKilos.toString()
                                  : weightInPounds.toString(),
                              style: kItemTextStyle,
                            ),
                            Text(
                              isMetric ? 'k' : 'lbs',
                              style: kLabelTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              callBack: () {
                                setState(() {
                                  if (isMetric) {
                                    if (weightInKilos > kMinKilos)
                                      weightInKilos -= 1;
                                  } else {
                                    if (weightInPounds > kMinPounds)
                                      weightInPounds -= 1;
                                  }
                                });
                              },
                              longCallBack: () {
                                setState(() {
                                  if (isMetric) {
                                    weightInKilos -= 22;
                                    if (weightInKilos < kMinKilos)
                                      weightInKilos = kMinKilos;
                                  } else {
                                    weightInPounds -= 50;
                                    if (weightInPounds < kMinPounds)
                                      weightInPounds = kMinPounds;
                                  }
                                });
                              },
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              callBack: () {
                                setState(() {
                                  if (isMetric) {
                                    if (weightInKilos < kMaxKilos)
                                      weightInKilos++;
                                  } else {
                                    if (weightInPounds < kMaxPounds)
                                      weightInPounds++;
                                  }
                                });
                              },
                              longCallBack: () {
                                setState(() {
                                  if (isMetric) {
                                    weightInKilos += 22;
                                    if (weightInKilos > kMaxKilos)
                                      weightInKilos = kMaxKilos;
                                  } else {
                                    weightInPounds += 50;
                                    if (weightInPounds > kMaxPounds)
                                      weightInPounds = kMaxPounds;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'AGE',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: kItemTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              callBack: () {
                                setState(() {
                                  age--;
                                  if (age < kMinAge) age = kMinAge;
                                });
                              },
                              longCallBack: () {
                                setState(() {
                                  age -= 20;
                                  if (age < kMinAge) age = kMinAge;
                                });
                              },
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              callBack: () {
                                setState(() {
                                  age++;
                                  if (age > kMaxAge) age = kMaxAge;
                                });
                              },
                              longCallBack: () {
                                setState(() {
                                  age += 20;
                                  if (age > kMaxAge) age = kMaxAge;
                                });
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          CalculateButton(
            selectedGender: selectedGender,
            text: 'CALCULATE',
            onPressed: () {
              if (isMetric) {
                CalculatorBrain bmi = CalculatorBrain(
                    height: heightInCM,
                    weight: weightInKilos,
                    isMetric: isMetric);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultsPage(
                      selectedGender: selectedGender,
                      bmiResult: bmi.calculateBMI(),
                      resultText: bmi.getResult(),
                      interpretation: bmi.getInterpretation(),
                    ),
                  ),
                );
              } else {
                CalculatorBrain bmi = CalculatorBrain(
                    height: heightInInches,
                    weight: weightInPounds,
                    isMetric: isMetric);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultsPage(
                      selectedGender: selectedGender,
                      bmiResult: bmi.calculateBMI(),
                      resultText: bmi.getResult(),
                      interpretation: bmi.getInterpretation(),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
