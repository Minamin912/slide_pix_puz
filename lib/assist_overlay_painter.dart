import 'package:flutter/material.dart';

class AssistOverlayPainter extends CustomPainter {
  final List<List<int>> currentGrid;
  final double gridSize;

  AssistOverlayPainter({
    required this.currentGrid,
    required this.gridSize,
  });

  // Define a list of vibrant colors for the columns
  static const List<Color> _columnColors = [
    Colors.redAccent,
    Colors.orangeAccent,
    Colors.amberAccent,
    Colors.lightGreenAccent,
    Colors.cyanAccent,
    Colors.purpleAccent,
    Colors.pinkAccent,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    if (currentGrid.isEmpty) return;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    int rows = currentGrid.length;
    int cols = currentGrid[0].length;

    for (int x = 0; x < cols; x++) {
      Color color = _columnColors[x % _columnColors.length];
      Paint linePaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0
        ..strokeCap = StrokeCap.round;

      int startY = -1;
      for (int y = 0; y < rows; y++) {
        bool isFill = currentGrid[y][x] == 1;
        
        if (isFill) {
          if (startY == -1) startY = y;
        } else {
          if (startY != -1) {
            _drawLineAndText(canvas, x, startY, y - 1, linePaint, color, textPainter);
            startY = -1;
          }
        }
      }
      // Check for segment at the end of the column
      if (startY != -1) {
        _drawLineAndText(canvas, x, startY, rows - 1, linePaint, color, textPainter);
      }
    }
  }

  void _drawLineAndText(Canvas canvas, int x, int startY, int endY, Paint paint, Color color, TextPainter textPainter) {
    double centerX = x * gridSize + gridSize / 2;
    double topY = startY * gridSize + (gridSize * 0.1); // Slight padding
    double bottomY = (endY + 1) * gridSize - (gridSize * 0.1);

    // Draw Line
    canvas.drawLine(Offset(centerX, topY), Offset(centerX, bottomY), paint);

    // Draw Text
    int count = endY - startY + 1;
    double fontSize = gridSize * 0.8;
    if (count >= 10) fontSize = gridSize * 0.6;

    textPainter.text = TextSpan(
      text: count.toString(),
      style: TextStyle(
        color: color, // Text color matches line color
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        shadows: const [
          Shadow(blurRadius: 3, color: Colors.black, offset: Offset(1, 1)),
        ],
      ),
    );
    textPainter.layout();
    
    // Center the text vertically within the segment
    double centerSegmentY = topY + (bottomY - topY) / 2;
    
    // Draw text centered on the line
    double textX = centerX - textPainter.width / 2;
    double textY = centerSegmentY - textPainter.height / 2;
    
    textPainter.paint(canvas, Offset(textX, textY));
  }

  @override
  bool shouldRepaint(covariant AssistOverlayPainter oldDelegate) {
    return true; 
  }
}
