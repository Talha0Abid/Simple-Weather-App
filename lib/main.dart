import 'package:flutter/material.dart';
import 'HomePage.dart';

void main() {
  runApp(const WatherApp());
}

class WatherApp extends StatelessWidget {
  const WatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      
      home: const WeatherHomePage(),
    );
  }
}

