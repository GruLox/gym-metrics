import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gym_metrics/screens/exercise_selection_screen.dart';
import 'package:gym_metrics/screens/login_screen.dart';
import 'package:gym_metrics/screens/main_screen.dart';
import 'package:gym_metrics/screens/register_screen.dart';
import 'package:gym_metrics/screens/settings_screen.dart';
import 'firebase_options.dart';

import 'package:gym_metrics/screens/history_screen.dart';
import 'package:gym_metrics/screens/home_screen.dart';
import 'package:gym_metrics/screens/exercises_screen.dart';
import 'package:gym_metrics/screens/workout_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/home': (context) => const HomeScreen(),
        '/history': (context) => const HistoryScreen(),
        '/workout': (context) => const WorkoutScreen(),
        '/exercises': (context) => const ExercisesScreen(),
        '/select-exercises': (context) => const ExerciseSelectionScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF081316),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.purple,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          ),
        ),

      ),
      debugShowCheckedModeBanner: false,
      title: 'GymMetrics',
    );
  }
}

