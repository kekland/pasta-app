import 'package:flutter/material.dart';
import 'home_page.dart';
import 'registration_page.dart';
import 'onboarding_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Pasta',
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: new OnboardingPage(),
    );
  }
}
