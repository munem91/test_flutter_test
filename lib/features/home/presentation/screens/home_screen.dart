import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FlightMath')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/levels'),
              child: const Text('Start Mission'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/how-to-play'),
              child: const Text('How to Play'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/progress'),
              child: const Text('My Progress'),
            ),
          ],
        ),
      ),
    );
  }
}
