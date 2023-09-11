import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              "Magic 8 Ball",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black,
          ),
          body: MagicEightBall(),
        ),
      ),
    );

class MagicEightBall extends StatefulWidget {
  const MagicEightBall({Key key}) : super(key: key);

  @override
  State<MagicEightBall> createState() => _MagicEightBallState();
}

class _MagicEightBallState extends State<MagicEightBall> {
  int answerNumber = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          child: Image.asset("images/ball$answerNumber.png"),
          onPressed: () async {
            setState(() {
              answerNumber = Random().nextInt(5) + 1;
            });
          },
        ),
      ],
    );
  }
}
