import 'package:flutter/material.dart';

/// Create a background from a path clip.
class BackgroundClipper extends StatefulWidget {
  const BackgroundClipper({Key? key, this.color}) : super(key: key);

  /// The color to paint behind the [child].
  final Color? color;

  @override
  _BackgroundClipperState createState() => _BackgroundClipperState();
}

class _BackgroundClipperState extends State<BackgroundClipper> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipPath(
      clipper: Clipper(),
      child: Container(
        width: size.width,
        height: size.height,
        color: widget.color,
      ),
    );
  }
}


class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 200);
    path.quadraticBezierTo(-20, -40, 0, 200);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}