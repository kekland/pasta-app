import 'dart:async';

import 'package:flutter/material.dart';
import 'pager_indicator.dart';

class PageDragger extends StatefulWidget {
  final StreamController<SlideUpdate> slideUpdateStream;

  PageDragger({this.slideUpdateStream});
  @override
  _PageDraggerState createState() => new _PageDraggerState();
}

class _PageDraggerState extends State<PageDragger> {
  static const FULL_TRANSITION_PX = 300.0;

  Offset dragStart;
  SlideDirection slideDirection;
  double slidePercent;

  onDragStart(DragStartDetails details) {
    dragStart = details.globalPosition;
  }

  onDragUpdate(DragUpdateDetails details) {
    if (dragStart != null) {
      final newPosition = details.globalPosition;
      final dx = dragStart.dx - newPosition.dx;

      if (dx > 0.0) {
        slideDirection = SlideDirection.rightToLeft;
      } else if (dx < 0.0) {
        slideDirection = SlideDirection.leftToRight;
      } else {
        slideDirection = SlideDirection.none;
      }

      slidePercent = (dx / FULL_TRANSITION_PX).abs().clamp(0.0, 1.0);
      widget.slideUpdateStream.add(new SlideUpdate(UpdateType.dragging, slideDirection, slidePercent));

      //print("Dragging $slideDirection at $slidePercent%");
    }
  }

  onDragEnd(DragEndDetails details) {
      widget.slideUpdateStream.add(new SlideUpdate(UpdateType.doneDragging, slideDirection, slidePercent));
    dragStart = null;
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onHorizontalDragStart: onDragStart,
      onHorizontalDragUpdate: onDragUpdate,
      onHorizontalDragEnd: onDragEnd,
    );
  }
}

enum UpdateType {
  dragging,
  doneDragging,
}

class SlideUpdate {
  final slideDirection;
  final slidePercent;
  final updateType;

  SlideUpdate(this.updateType, this.slideDirection, this.slidePercent);
}
