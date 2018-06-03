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

class OnboardingPageState extends State<OnboardingPage> with TickerProviderStateMixin {
  StreamController<SlideUpdate> slideUpdateStream;
  AnimatedPageDragger dragger;

  int activeIndex = 0;
  int nextPageIndex = 1;
  SlideDirection slideDirection = SlideDirection.none;
  double slidePercent = 0.0;
  OnboardingPageState() {
    slideUpdateStream = new StreamController<SlideUpdate>();

    slideUpdateStream.stream.listen((SlideUpdate event) {
      setState(() {
        if (event.updateType == UpdateType.dragging) {
          slideDirection = event.slideDirection;
          slidePercent = event.slidePercent;

          if (slideDirection == SlideDirection.leftToRight) {
            nextPageIndex = activeIndex - 1;
          } else if (slideDirection == SlideDirection.rightToLeft) {
            nextPageIndex = activeIndex + 1;
          } else {
            nextPageIndex = activeIndex;
          }
          nextPageIndex.clamp(0, pages.length - 1);
        } else if (event.updateType == UpdateType.doneDragging) {
          if (slidePercent > 0.5) {
            dragger = new AnimatedPageDragger(
              slideDirection: slideDirection,
              slidePercent: slidePercent,
              transitionGoal: TransitionGoal.open,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
          } else {
            dragger = new AnimatedPageDragger(
              slideDirection: slideDirection,
              slidePercent: slidePercent,
              transitionGoal: TransitionGoal.close,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );

            nextPageIndex = activeIndex;
          }
          dragger.run();
        } else if (event.updateType == UpdateType.animating) {
          slideDirection = event.slideDirection;
          slidePercent = event.slidePercent;
        } else if (event.updateType == UpdateType.doneAnimating) {
          activeIndex = nextPageIndex;
          slideDirection = SlideDirection.none;
          slidePercent = 0.0;
          dragger.dispose();
        }
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
              viewModel: pages[nextPageIndex],
              percentVisible: slidePercent,
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
            canDragLeftToRight: activeIndex > 0,
            canDragRightToLeft: activeIndex < pages.length - 1,
          ),
        ],
      ),
    );
  }
}
