import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LevelsScreen extends StatefulWidget {
  const LevelsScreen({super.key});

  @override
  State<LevelsScreen> createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  int selectedLevel = 1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    // Координаты кружков (примерно, подгоняй под референс)
    final List<Offset> levelPositions = [
      Offset(width * 0.4, height * 0.94), // 1
      Offset(width * 0.55, height * 0.85), // 2
      Offset(width * 0.73, height * 0.77), // 3
      Offset(width * 0.7, height * 0.63), // 4
      Offset(width * 0.50, height * 0.57), // 5
      Offset(width * 0.5, height * 0.39), // 6
      Offset(width * 0.7, height * 0.28), // 7
      Offset(width * 0.6, height * 0.17), // 8
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Фон
          Positioned.fill(
            child: Image.asset(
              'assets/bckfg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Самолёт
          Positioned(
            top: height * 0.01,
            left: width * 0.01,
            right: width * 0.01,
            child: Image.asset(
              'assets/plane_two_screen.png',
              width: width * 0.95,
              fit: BoxFit.contain,
            ),
          ),
          // Надпись Choose level
          Positioned(
            top: height * 0.03,
            left: width * 0.13,
            right: width * 0.13,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: height * 0.012),
              decoration: BoxDecoration(
                color: const Color(0xFFFF3A3A),
                borderRadius: BorderRadius.circular(32),
              ),
              child: Center(
                child: Text(
                  'Choose level',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: width * 0.10, // ~40px на 400px ширины
                    height: 1.0,
                    color: Colors.white,
                    letterSpacing: 0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          // Кружки уровней
          ...List.generate(8, (i) {
            final isSelected = selectedLevel == (i + 1);
            return Positioned(
              left: levelPositions[i].dx - width * 0.09,
              top: levelPositions[i].dy - width * 0.09,
              child: GestureDetector(
                onTap: () {
                  setState(() => selectedLevel = i + 1);
                  Future.delayed(const Duration(milliseconds: 200), () {
                    context.go('/task/${i + 1}');
                  });
                },
                child: Container(
                  width: width * 0.18,
                  height: width * 0.18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: isSelected
                        ? const LinearGradient(
                            colors: [
                              Color(0xFF3A8DFF), // Активный цвет (пример)
                              Color(0xFF0057B8),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )
                        : const LinearGradient(
                            colors: [
                              Color(0xFFACB4BC),
                              Color(0xFF61676D),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.18),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      fontFamily: 'GoormSans', // если нет — заменить на похожий
                      fontWeight: FontWeight.w400,
                      fontSize: width * 0.09, // ~36px на 400px ширины
                      height: 1.0,
                      color: Colors.white,
                      letterSpacing: 0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
