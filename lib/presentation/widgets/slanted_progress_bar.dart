import 'package:flutter/material.dart';

class SlantedProgressBar extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const SlantedProgressBar({
    super.key,
    required this.width,
    this.height = 6,
    this.color = Colors.redAccent,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: SlantedClipper(),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(6),
            bottomRight: Radius.circular(6),
          ),
        ),
      ),
    );
  }
}

class SlantedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = size.height / 2; // Keep bottom corners rounded
    Path path = Path();
    path.moveTo(radius, size.height); // Start after left rounding
    path.lineTo(
      size.width - radius,
      size.height,
    ); // Move to right rounding start
    path.lineTo(size.width, 0); // Slanted top-right
    path.lineTo(0, 0); // Top-left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// **Usage Example:**
Widget buildSlantedBar() {
  return SlantedProgressBar(width: 150);
}
