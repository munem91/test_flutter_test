import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/task_repository.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Progress'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: context.read<TaskRepository>().getProgress(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final progress = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ProgressCard(
                  title: 'Total Tasks',
                  value: progress['total'].toString(),
                  icon: Icons.assignment,
                ),
                const SizedBox(height: 16),
                _ProgressCard(
                  title: 'Correct Answers',
                  value: progress['correct'].toString(),
                  icon: Icons.check_circle,
                ),
                const SizedBox(height: 16),
                _ProgressCard(
                  title: 'Accuracy',
                  value: '${progress['accuracy']}%',
                  icon: Icons.percent,
                ),
                const SizedBox(height: 32),
                Text(
                  _getMotivationalMessage(progress['accuracy']),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getMotivationalMessage(String accuracy) {
    final accuracyValue = double.parse(accuracy);
    if (accuracyValue >= 90) {
      return 'You\'re a Captain! 🎖️';
    } else if (accuracyValue >= 70) {
      return 'You\'re a Co-Pilot! 🎯';
    } else if (accuracyValue >= 50) {
      return 'You\'re a Flight Student! 📚';
    } else {
      return 'Keep practicing! 🚀';
    }
  }
}

class _ProgressCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _ProgressCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
