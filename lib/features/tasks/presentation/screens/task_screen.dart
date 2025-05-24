import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';

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
        backgroundColor: const Color(0xFF0A1DBA),
        body: BlocBuilder<TaskBloc, TaskState>(
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
                  // Верхняя картинка
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/app_detal_three_screen.png',
                      width: width,
                      height: height * 0.23,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Средняя картинка
                  Positioned(
                    top: height * 0.21,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/medium_three_screen_detail.png',
                      width: width,
                      height: height * 0.19,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Нижняя картинка
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
                      child: Column(
                        children: [
                          SizedBox(height: height * 0.03),
                          // 1 level
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
                                fontSize: width * 0.06, // ~24px на 400px ширины
                                height: 1.0,
                                color: const Color(0xFF0A1DBA),
                                letterSpacing: -0.01 * width * 0.06,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          // 1/10
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
                          SizedBox(height: height * 0.03),
                          // Вопрос
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.08),
                            child: Text(
                              state.task.question,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: width * 0.07, // ~28px
                                height: 1.1,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: height * 0.04),
                          // Кнопки-ответы (2 в ряд)
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.04),
                            child: GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              mainAxisSpacing: height * 0.018,
                              crossAxisSpacing: width * 0.04,
                              childAspectRatio: 2.2,
                              physics: const NeverScrollableScrollPhysics(),
                              children: state.task.options
                                  .map((option) => SizedBox(
                                        width: width * 0.38,
                                        height: height * 0.09,
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
                                                      state.task.id, option),
                                                );
                                          },
                                          child: Text(
                                            option,
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                              fontSize: width * 0.08, // ~32px
                                              height: 1.0,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                          SizedBox(height: height * 0.03),
                          // Нижние кнопки
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: height * 0.03,
                                left: width * 0.06,
                                right: width * 0.06),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: height * 0.065,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        elevation: 4,
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        'explain this',
                                        style: TextStyle(
                                          fontFamily: 'GoormSans',
                                          fontWeight: FontWeight.w400,
                                          fontSize: width * 0.06, // ~24px
                                          height: 1.0,
                                          color: const Color(0xFF0A1DBA),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: width * 0.04),
                                Expanded(
                                  child: SizedBox(
                                    height: height * 0.065,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        elevation: 4,
                                      ),
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'next',
                                            style: TextStyle(
                                              fontFamily: 'GoormSans',
                                              fontWeight: FontWeight.w400,
                                              fontSize: width * 0.06, // ~24px
                                              height: 1.0,
                                              color: const Color(0xFF0A1DBA),
                                            ),
                                          ),
                                          SizedBox(width: width * 0.01),
                                          Icon(Icons.arrow_forward,
                                              color: const Color(0xFF0A1DBA),
                                              size: width * 0.07),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
    );
  }
}
