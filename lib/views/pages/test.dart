import 'package:flutter/material.dart';

class FormationDisplay extends StatelessWidget {
  const FormationDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Stack(
        children: [
          // Field markings
          _buildFieldMarkings(),

          // Players
          _buildPlayerPosition('Edouard Mendy', '16', 0.5, 0.1),
          _buildPlayerPosition('Cesar Azpilicueta', '28', 0.15, 0.3),
          _buildPlayerPosition('Trevoh Chalobah', '14', 0.38, 0.3),
          _buildPlayerPosition('Thiago Silva', '6', 0.62, 0.3),
          _buildPlayerPosition('Marc Cucurella', '32', 0.85, 0.3),
          _buildPlayerPosition('Ruben Loftus-Cheek', '12', 0.25, 0.5),
          _buildPlayerPosition('Jorginho', '5', 0.5, 0.5),
          _buildPlayerPosition('Mason Mount', '19', 0.75, 0.5),
          _buildPlayerPosition('Raheem Sterling', '17', 0.25, 0.7),
          _buildPlayerPosition('Kai Havertz', '29', 0.5, 0.7),
          _buildPlayerPosition('Pierre-E.Aubameyang', '9', 0.75, 0.7),

          // Formation text
          const Positioned(
            top: 10,
            left: 10,
            child: Text(
              'Chelsea: 4-3-3',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldMarkings() {
    return CustomPaint(
      painter: FieldPainter(),
      size: Size.infinite,
    );
  }

  Widget _buildPlayerPosition(String name, String number, double x, double y) {
    return Positioned(
      left: x * 100,
      top: y * 100,
      child: Column(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          Text(
            name,
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class FieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw field outline
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Draw center circle
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 50, paint);

    // Draw penalty areas
    canvas.drawRect(const Rect.fromLTWH(0, 0, 150, 100), paint);
    canvas.drawRect(
        Rect.fromLTWH(size.width - 150, size.height - 100, 150, 100), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
