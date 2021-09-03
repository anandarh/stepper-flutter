import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedCalendarIcon extends StatefulWidget {
  const AnimatedCalendarIcon({Key? key}) : super(key: key);

  @override
  _AnimatedCalendarIconState createState() => _AnimatedCalendarIconState();
}

class _AnimatedCalendarIconState extends State<AnimatedCalendarIcon> {
  final _animationDuration = Duration(milliseconds: 1500);
  late Timer _timer;
  double _animatedCircleSize = 70;
  double _size = 70;

  @override
  void initState() {
    _timer = Timer.periodic(_animationDuration, (timer) => _changeColor());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          AnimatedContainer(
            duration: _animationDuration,
            width: _animatedCircleSize,
            height: _animatedCircleSize,
            decoration: new BoxDecoration(
              color: Colors.white54,
              shape: BoxShape.circle,
            ),
          ),
          Card(
            shape: CircleBorder(),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.event,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _changeColor() {
    final newSize = _animatedCircleSize == 70.0 ? 0.0 : 70.0;
    setState(() {
      _animatedCircleSize = newSize;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
