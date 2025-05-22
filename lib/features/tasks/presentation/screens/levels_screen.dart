import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/task.dart';
import '../../domain/repositories/task_repository.dart';

class LevelsScreen extends StatelessWidget {
  const LevelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mission Levels'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 4, // Number of levels
        itemBuilder: (context, index) {
          final level = index + 1;
          return _LevelCard(
            level: level,
            onTap: () => context.go('/task/$level'),
          );
        },
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  final int level;
  final VoidCallback onTap;

  const _LevelCard({
    required this.level,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Level $level',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              _getLevelDescription(level),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  String _getLevelDescription(int level) {
    switch (level) {
      case 1:
        return 'Basic Flight Operations';
      case 2:
        return 'Intermediate Navigation';
      case 3:
        return 'Advanced Calculations';
      case 4:
        return 'Expert Level';
      default:
        return '';
    }
  }
}
