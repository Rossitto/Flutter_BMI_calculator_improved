import 'package:flutter/material.dart';
import '../globals.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({
    this.color = kActiveCardColor,
    this.cardChild,
    this.onPress,
  });
  final Color color;
  final Widget cardChild;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(kCardMargin),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
