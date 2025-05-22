import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

enum TaskType { timeCalculation, directionAngle, fuelConsumption, cargoBalance }

@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String question,
    required List<String> options,
    required String correctAnswer,
    required TaskType type,
    required int level,
    String? explanation,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
