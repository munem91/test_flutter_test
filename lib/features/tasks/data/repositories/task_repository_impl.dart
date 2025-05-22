import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_data.dart';

@Injectable(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository {
  final SharedPreferences _prefs;

  TaskRepositoryImpl(this._prefs);

  @override
  Future<List<Task>> getTasksByLevel(int level) async {
    return sampleTasks.where((task) => task.level == level).toList();
  }

  @override
  Future<Task> getTaskById(String id) async {
    final task = sampleTasks.firstWhere(
      (task) => task.id == id,
      orElse: () => throw Exception('Task not found'),
    );
    return task;
  }

  @override
  Future<void> saveProgress(String taskId, bool isCorrect) async {
    final progress = _prefs.getStringList('progress') ?? [];
    progress.add('$taskId:${isCorrect ? '1' : '0'}');
    await _prefs.setStringList('progress', progress);
  }

  @override
  Future<Map<String, dynamic>> getProgress() async {
    final progress = _prefs.getStringList('progress') ?? [];
    final total = progress.length;
    final correct = progress.where((p) => p.endsWith(':1')).length;

    return {
      'total': total,
      'correct': correct,
      'accuracy':
          total > 0 ? (correct / total * 100).toStringAsFixed(1) : '0.0',
    };
  }
}
