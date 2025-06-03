import 'package:flutter/material.dart';
import '../domain/entities/player.dart';

class WinningLinePainter extends CustomPainter {
  final List<int> winningLine;
  final double fieldSize;
  final Player winner;

  WinningLinePainter(this.winningLine, this.fieldSize, this.winner);

  @override
  void paint(Canvas canvas, Size size) {
    final cellSize = fieldSize / 3;
    final paint = Paint()
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Цвет линии в зависимости от победителя
    paint.color = winner == Player.x
        ? Colors.blueAccent.withOpacity(0.7)
        : Colors.pinkAccent.withOpacity(0.7);

    // Стиль линии (сплошная или пунктирная) можно добавить опционально
    final Path path = Path();
    Offset start = _getPointFromIndex(winningLine[0], cellSize);
    Offset end = _getPointFromIndex(winningLine[2], cellSize);

    path.moveTo(start.dx, start.dy);
    path.lineTo(end.dx, end.dy);

    canvas.drawPath(path, paint);
  }

  Offset _getPointFromIndex(int index, double cellSize) {
    int row = index ~/ 3;
    int col = index % 3;
    double x = col * cellSize + cellSize / 2;
    double y = row * cellSize + cellSize / 2;
    return Offset(x, y);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
