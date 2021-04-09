import 'package:flutter/material.dart';
import 'package:flutter2/screens/loading_screen.dart';
import 'package:flutter2/screens/location_screen.dart';
import 'screens/test_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      home: WeatherApp(),
    );
  }
}
