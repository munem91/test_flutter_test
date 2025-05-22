import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/models/task.dart';
import '../../domain/repositories/task_repository.dart';

// Events
abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTask extends TaskEvent {
  final String taskId;

  const LoadTask(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class SubmitAnswer extends TaskEvent {
  final String taskId;
  final String answer;

  const SubmitAnswer(this.taskId, this.answer);

  @override
  List<Object> get props => [taskId, answer];
}

// States
abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final Task task;

  const TaskLoaded(this.task);

  @override
  List<Object> get props => [task];
}

class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc(this.repository) : super(TaskInitial()) {
    on<LoadTask>(_onLoadTask);
    on<SubmitAnswer>(_onSubmitAnswer);
  }

  Future<void> _onLoadTask(LoadTask event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final task = await repository.getTaskById(event.taskId);
      emit(TaskLoaded(task));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onSubmitAnswer(
      SubmitAnswer event, Emitter<TaskState> emit) async {
    try {
      final task = await repository.getTaskById(event.taskId);
      final isCorrect = task.correctAnswer == event.answer;
      await repository.saveProgress(event.taskId, isCorrect);
      emit(TaskLoaded(task));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
