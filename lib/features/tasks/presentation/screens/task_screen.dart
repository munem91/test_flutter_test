import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import 'package:go_router/go_router.dart';

class TaskScreen extends StatelessWidget {
  final String taskId;

  const TaskScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return BlocProvider(
      create: (context) => TaskBloc(context.read())..add(LoadTask(taskId)),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF3A8DFF),
                    Color(0xFF0A1DBA),
                  ],
                ),
              ),
              child: BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is TaskLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is TaskError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is TaskLoaded) {
                    return Stack(
                      children: [
                        // Градиентный фон
                        Positioned.fill(
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFF3A8DFF),
                                  Color(0xFF0A1DBA),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          right: 0,
                          top: height * 0.52,
                          child: Image.asset(
                            'assets/sky_right.png',
                            // width: width * 0.38,
                            height: height * 0.17,
                            fit: BoxFit.contain,
                          ),
                        ),
                        // Облако слева
                        Positioned(
                          left: 0,
                          top: height * 0.52,
                          child: Image.asset(
                            'assets/sky_left.png',
                            // width: width * 0.38,
                            height: height * 0.17,
                            fit: BoxFit.contain,
                          ),
                        ),

                        // Верхняя картинка

                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Image.asset(
                            'assets/app_detal_three_screen.png',
                            width: width * 0.2,
                            height: height * 0.22,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Нижняя картинка (в самом низу, не перекрывает контент)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Image.asset(
                            'assets/detal_screen_three.png',
                            width: width,
                            height: height * 0.32,
                            fit: BoxFit.cover,
                          ),
                        ),

                        // Контент
                        SafeArea(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.04,
                                  vertical: height * 0.02),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: height * 0.01),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.08,
                                        vertical: height * 0.008),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF8D7),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Text(
                                      '1 level',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        fontSize: width * 0.06,
                                        height: 1.0,
                                        color: const Color(0xFF0A1DBA),
                                        letterSpacing: -0.01 * width * 0.06,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.008),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.08,
                                        vertical: height * 0.008),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF8D7),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Text(
                                      '1 / 10',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        fontSize: width * 0.06,
                                        height: 1.0,
                                        color: const Color(0xFF0A1DBA),
                                        letterSpacing: -0.01 * width * 0.06,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.05),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/medium_three_screen_detail.png',
                                        width: width * 0.9,
                                        height: height * 0.5,
                                        fit: BoxFit.contain,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.04,
                                            vertical: height * 0.04),
                                        child: Text(
                                          state.task.question,
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w800,
                                            fontSize: width * 0.07,
                                            height: 1.13,
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                color: Colors.black
                                                    .withOpacity(0.25),
                                                blurRadius: 4,
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Кнопки-ответы и нижние кнопки внизу
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: height * 0.07,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.08,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GridView.count(
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  mainAxisSpacing: height * 0.014,
                                  crossAxisSpacing: width * 0.04,
                                  childAspectRatio: 2.2,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: state.task.options
                                      .map((option) => SizedBox(
                                            width: width * 0.33,
                                            height: height * 0.07,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xFFED4B4B),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                ),
                                                elevation: 6,
                                              ),
                                              onPressed: () {
                                                context.read<TaskBloc>().add(
                                                      SubmitAnswer(
                                                          state.task.id,
                                                          option),
                                                    );
                                              },
                                              child: Text(
                                                option,
                                                style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: width * 0.065,
                                                  height: 1.0,
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                                SizedBox(height: height * 0.018),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: height * 0.052,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFFE6E6E6),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            elevation: 1,
                                            shadowColor:
                                                Colors.black.withOpacity(0.10),
                                            padding: EdgeInsets.zero,
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            'explain this',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: 'GoormSans',
                                              fontWeight: FontWeight.w500,
                                              fontSize: width * 0.048,
                                              height: 1.0,
                                              color: const Color(0xFF0A1DBA),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: width * 0.03),
                                    Expanded(
                                      child: SizedBox(
                                        height: height * 0.052,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFFE6E6E6),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            elevation: 1,
                                            shadowColor:
                                                Colors.black.withOpacity(0.10),
                                            padding: EdgeInsets.zero,
                                          ),
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'next',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontFamily: 'GoormSans',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: width * 0.048,
                                                  height: 1.0,
                                                  color:
                                                      const Color(0xFF0A1DBA),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(width: width * 0.01),
                                              Icon(Icons.arrow_forward,
                                                  color:
                                                      const Color(0xFF0A1DBA),
                                                  size: width * 0.06),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
