import 'package:flutter/material.dart';
import 'page_transformer.dart';

class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: new BoxConstraints(minHeight: double.INFINITY, minWidth: double.INFINITY),
        color: Colors.white,
        child: PageTransformer(
          pageViewBuilder: (context, pageVisibilityResolver) {
            return new PageView.builder(
              itemBuilder: (context, index) {
                final pageVisibility = pageVisibilityResolver.resolvePageVisibility(index);

                // Use these two properties to transform your "Hello World" text widget!
                // In this example, the text widget fades in and out of view, since we use
                // the visibleFraction property, which can be between 0.0 - 1.0.
                final position = pageVisibility.pagePosition;
                final visibleFraction = pageVisibility.visibleFraction;

                return new Opacity(
                  opacity: visibleFraction,
                  child: new Text('Hello World!'),
                );
              },
            );
          },
        ),
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
