import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:flutter_svg/flutter_svg.dart'; // больше не нужен
import 'dart:math' as math;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    // Центр ray burst совпадает с носом самолёта (чуть выше нижней границы)
    final rayCenter = Offset(width / 2, height - height * 0.19 - height * 0.11);
    return Scaffold(
      body: Stack(
        children: [
          // Фон #0A1DBA
          Container(color: const Color(0xFF0A1DBA)),

          // Ray burst (фон)
          Positioned.fill(
            child: CustomPaint(
              painter: _RayBurstPainter(
                center: rayCenter,
                rays: 70,
                color: const Color(0x9906AEE6),
                thickness: width * 0.012,
                length: width * 0.95,
              ),
            ),
          ),
          // Облака (sky.png) только снизу (фон)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(
              'assets/sky.png',
              width: width,
              height: height * 0.23,
              fit: BoxFit.cover,
            ),
          ),
          // Контент (логотип, кнопки, самолёт) — только через Column
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: height * 0.08), // паддинг сверху
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  child: Image.asset(
                    'assets/flight_math.png',
                    width: width * 0.92,
                    height: height * 0.17,
                    fit: BoxFit.contain,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                  child: _MenuButton(
                    text: 'Start Mission',
                    width: width * 0.8,
                    fontSize: width * 0.07,
                    onPressed: () => context.go('/levels'),
                  ),
                ),
                SizedBox(height: height * 0.025),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                  child: _MenuButton(
                    text: 'How to Play',
                    width: width * 0.8,
                    fontSize: width * 0.07,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('How to Play'),
                          content: const SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('🎯 Mission Types:'),
                                SizedBox(height: 8),
                                Text('• Time Calculations'),
                                Text('• Direction and Angles'),
                                Text('• Fuel Consumption'),
                                Text('• Cargo Balance'),
                                SizedBox(height: 16),
                                Text('📝 How to Play:'),
                                SizedBox(height: 8),
                                Text('1. Select a mission level'),
                                Text('2. Read the task carefully'),
                                Text('3. Choose the correct answer'),
                                Text('4. Get explanations if needed'),
                                Text('5. Track your progress'),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Got it!'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: height * 0.025),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                  child: _MenuButton(
                    text: 'My Progress',
                    width: width * 0.8,
                    fontSize: width * 0.07,
                    onPressed: () => context.go('/progress'),
                  ),
                ),
                const Spacer(),
                // Самолёт (plane.png) теперь часть контента, не перекрывает кнопки
                Image.asset(
                  'assets/plane.png',
                  width: width * 0.84,
                  height: height * 0.26,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final String text;
  final double width;
  final double fontSize;
  final VoidCallback onPressed;

  const _MenuButton({
    required this.text,
    required this.width,
    required this.fontSize,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.55),
                offset: const Offset(0, 12),
                blurRadius: 24,
              ),
            ],
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFF3A3A),
                Color(0xFFB71C1C),
              ],
            ),
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              padding: const EdgeInsets.symmetric(vertical: 22),
              textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: fontSize,
                letterSpacing: 0.5,
              ),
            ),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}

class _RayBurstPainter extends CustomPainter {
  final Offset center;
  final int rays;
  final Color color;
  final double thickness;
  final double length;
  _RayBurstPainter({
    required this.center,
    required this.rays,
    required this.color,
    required this.thickness,
    required this.length,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < rays; i++) {
      final angle = (math.pi * 2 / rays) * i;
      final x = center.dx + length * math.cos(angle);
      final y = center.dy + length * math.sin(angle);
      canvas.drawLine(center, Offset(x, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

int selectedLevel = 0;
