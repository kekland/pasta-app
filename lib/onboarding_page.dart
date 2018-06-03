import 'package:flutter/material.dart';
import 'page.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          new Page(
            viewModel: pages[0],
            percentVisible: 1.0,
          ),
          new PageReveal(
            revealPercent: 1.0,
            child: new Page(
              viewModel: pages[1],
              percentVisible: 1.0,
            ),
          ),
          new PagerIndicator(
            viewModel: PagerIndicatorViewModel(
              pages: pages,
              activeIndex: 1,
              slideDirection: SlideDirection.rightToLeft,
              slidePercent: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
