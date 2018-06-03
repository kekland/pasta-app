import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new OnboardingPageState();
  }
}

class OnboardingPageState extends State<OnboardingPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          new Container(
            color: Colors.blue,
            child: Column(
              children: [
                Icon(
                  Icons.access_alarm,
                  size: 200.0,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
