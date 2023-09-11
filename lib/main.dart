import 'package:flutter/material.dart';
import 'package:clima/screens/loading_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: LoaderOverlay(
        child: LoadingScreen(),
        useDefaultLoading: false,
        overlayColor: Colors.black,
        overlayWidget: Center(
          child: SpinKitPulse(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
