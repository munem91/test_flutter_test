import '../models/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasksByLevel(int level);
  Future<Task> getTaskById(String id);
  Future<void> saveProgress(String taskId, bool isCorrect);
  Future<Map<String, dynamic>> getProgress();
}
