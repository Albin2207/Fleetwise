import 'package:flutter/material.dart';
import 'package:fleetwise_app/provider/dashboard_provider.dart';

class DashboardGradientContainer extends StatelessWidget {
  final Widget child;
  final TabSelection selectedTab;

  const DashboardGradientContainer({
    super.key,
    required this.child,
    required this.selectedTab,
  });

  @override
  Widget build(BuildContext context) {
    // Choose background color and pattern based on selected tab
    Color topColor;
    Color gridLineColor;

    switch (selectedTab) {
      case TabSelection.yesterday:
        topColor = const Color.fromARGB(255, 161, 121, 110); // deep brown
        gridLineColor = const Color.fromARGB(255, 139, 117, 108);
        break;
      case TabSelection.today:
        topColor = const Color(0xFF1A53A1);
        gridLineColor = const Color(0xFF2A65B5);
        break;
      case TabSelection.monthly:
        topColor = const Color(0xFF0A5E4C);
        gridLineColor = const Color(0xFF1A6E5C);
        break;
    }

    return Container(
      height: 680,
      // Creating the gradient that transitions from color to black
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment(
            0,
            -0.8,
          ), 
          colors: [topColor, Colors.black],
          stops: const [0, 1],
        ),
      ),
      child: Stack(
        children: [
          // Grid pattern covering the gradient area
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment(0, -0.6),
                colors: [Colors.white, Colors.transparent],
                stops: const [
                  0.4,
                  1.0,
                ], // Grid fades out slightly before the color
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: CustomPaint(
              size: Size.infinite,
              painter: GridPainter(gridLineColor),
            ),
          ),

          // Content
          child,
        ],
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final Color gridLineColor;

  GridPainter(this.gridLineColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = gridLineColor
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke;

    // Draw horizontal grid lines
    double y = 0;
    final gridSize = 24.0;

    while (y < size.height) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      y += gridSize;
    }

    // Draw vertical grid lines
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      x += gridSize;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
