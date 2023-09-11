import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

void main() => runApp(XylophoneApp());

void playSound(int counter) {
  final player = AudioCache();
  player.play("note$counter.wav");
}

Expanded builButton(Color noteColor, int soundNumber) {
  return Expanded(
    child: TextButton(
      style: TextButton.styleFrom(
        backgroundColor: noteColor,
      ),
      onPressed: () {
        playSound(soundNumber);
      },
    ),
  );
}

class XylophoneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            builButton(Colors.red, 1),
            builButton(Colors.orange, 2),
            builButton(Colors.yellow, 3),
            builButton(Colors.green, 4),
            builButton(Colors.teal, 5),
            builButton(Colors.blue, 6),
            builButton(Colors.purple, 7),
          ],
        )),
      ),
    );
  }
}
