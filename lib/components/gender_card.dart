import 'package:flutter/material.dart';
import '../globals.dart';
import 'card_content.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GenderCard extends StatelessWidget {
  GenderCard({
    this.currentGender,
    this.refreshParent,
    this.gender,
  });

  final Gender currentGender;
  final Function refreshParent;
  final Gender gender;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => refreshParent(gender),
      child: Container(
        child: CardContent(
          icon: gender == Gender.male
              ? FontAwesomeIcons.mars
              : FontAwesomeIcons.venus,
          label: gender == Gender.male ? 'MALE' : 'FEMALE',
        ),
        margin: EdgeInsets.all(kCardMargin),
        decoration: BoxDecoration(
          color:
              currentGender == gender ? kActiveCardColor : kInactiveCardColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
