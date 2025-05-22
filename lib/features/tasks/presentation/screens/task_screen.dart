import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';

class TaskScreen extends StatelessWidget {
  final String taskId;

  const TaskScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(context.read())..add(LoadTask(taskId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flight Task'),
        ),
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is TaskError) {
              return Center(child: Text(state.message));
            }
            if (state is TaskLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      state.task.question,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 24),
                    ...state.task.options.map((option) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<TaskBloc>().add(
                                    SubmitAnswer(state.task.id, option),
                                  );
                            },
                            child: Text(option),
                          ),
                        )),
                    if (state.task.explanation != null) ...[
                      const SizedBox(height: 24),
                      Text(
                        'Explanation:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(state.task.explanation!),
                    ],
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
