import 'dart:async';

import 'package:flutter/material.dart';
import 'page.dart';
import 'page_dragger.dart';
import 'page_reveal.dart';
import 'pager_indicator.dart';

final pages = [
  new PageViewModel(
    color: Colors.teal,
    heroIcon: Icons.cloud,
    title: 'Saving in cloud',
    body: 'You can save all your pastas in cloud and download them on any device!',
    pagerIcon: Icons.cloud,
  ),
  new PageViewModel(
    color: Colors.lightBlue,
    heroIcon: Icons.image,
    title: 'Images',
    body: 'You can also attach images into your pastas!',
    pagerIcon: Icons.image,
  ),
  new PageViewModel(
    color: Colors.lime,
    heroIcon: Icons.share,
    title: 'Sharing',
    body: 'You can share your pastas with your friends, coworker, or even with your cat!',
    pagerIcon: Icons.share,
  ),
];

class OnboardingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new OnboardingPageState();
  }
}

class OnboardingPageState extends State<OnboardingPage> {
  StreamController<SlideUpdate> slideUpdateStream;

  int activeIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  double slidePercent = 0.0;
  OnboardingPageState() {
    slideUpdateStream = new StreamController<SlideUpdate>();

    slideUpdateStream.stream.listen((SlideUpdate event) {
      setState(() {
        slideDirection = event.slideDirection;
        slidePercent = event.slidePercent;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          new Page(
            viewModel: pages[activeIndex],
            percentVisible: 1.0 - slidePercent,
          ),
          new PageReveal(
            revealPercent: slidePercent,
            child: new Page(
              viewModel: pages[1],
              percentVisible: 1.0,
            ),
          ),
          new PagerIndicator(
            viewModel: PagerIndicatorViewModel(
              pages: pages,
              activeIndex: activeIndex,
              slideDirection: slideDirection,
              slidePercent: slidePercent,
            ),
          ),
          new PageDragger(
            slideUpdateStream: slideUpdateStream,
          ),
        ],
      ),
    );
  }
}
