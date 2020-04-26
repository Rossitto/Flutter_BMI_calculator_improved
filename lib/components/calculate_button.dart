import 'package:flutter/material.dart';
import '../globals.dart';

class CalculateButton extends StatelessWidget {
  const CalculateButton({
    @required this.selectedGender,
    @required this.text,
    @required this.onPressed,
  });

  final Gender selectedGender;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Center(
          child: Text(
            text,
            style: kLargeButtonStyle,
          ),
        ),
        color: selectedGender == Gender.male ? kMaleColor : kFemaleColor,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(bottom: 20.0),
        width: double.infinity,
        height: kBottomContainHeight,
      ),
    );
  }
}
