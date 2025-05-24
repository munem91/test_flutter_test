import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/di/injection.dart';
import 'features/tasks/data/repositories/task_repository_impl.dart';
import 'features/tasks/domain/repositories/task_repository.dart';
import 'features/tasks/presentation/screens/home_screen.dart';
import 'features/tasks/presentation/screens/levels_screen.dart';
import 'features/tasks/presentation/screens/task_screen.dart';
import 'features/tasks/presentation/screens/progress_screen.dart';
import 'features/settings/presentation/screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  await configureDependencies();

  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TaskRepository>(
          create: (context) => TaskRepositoryImpl(prefs),
        ),
      ],
      child: MaterialApp.router(
        title: 'FlightMath',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          textTheme: GoogleFonts.interTextTheme().copyWith(
            headlineLarge: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 32,
              height: 1.0,
              letterSpacing: 0,
            ),
            headlineMedium: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              height: 1.0,
              letterSpacing: 0,
            ),
            headlineSmall: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              height: 1.0,
              letterSpacing: 0,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              textStyle: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 8,
              shadowColor: Colors.black.withOpacity(0.3),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
        routerConfig: _router,
      ),
    );
  }
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/levels',
      builder: (context, state) => const LevelsScreen(),
    ),
    GoRoute(
      path: '/task/:id',
      builder: (context, state) =>
          TaskScreen(taskId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/progress',
      builder: (context, state) => const ProgressScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
