import 'package:flutter/material.dart';

import '../data/constants.dart';

class CardContent extends StatelessWidget {
  CardContent({@required this.cardText, this.cardIcon, this.iconColor});

  final String cardText;
  final IconData cardIcon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          cardIcon,
          size: 80.0,
          color: iconColor,
        ),
        SizedBox(height: 15.0),
        Text(
          cardText.toUpperCase(),
          style: kCardTextStyle,
        )
      ],
    );
  }
}
