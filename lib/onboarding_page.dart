import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: new BoxConstraints(minHeight: double.INFINITY, minWidth: double.INFINITY),
        color: Colors.white,
        child: WelcomingPage(),
      ),
    );
  }
}

class WelcomingPage extends StatelessWidget {
  final Function onFABPressed;
  WelcomingPage({onFABPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: new EdgeInsets.all(64.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Pasta',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.teal,
                  fontSize: 48.0,
                ),
              ),
              Text(
                'Welcome to Pasta!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.teal.shade400,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
          FloatingActionButton(
            onPressed: onFABPressed,
            child: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
