import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
            appBar: AppBar(
              title: const Text("I am poor"),
              centerTitle: true,
              backgroundColor: Colors.blueGrey[900],
            ),
            body: const Center(
              child: Image(image: AssetImage("images/coal.png")),
            )));
  }
}
