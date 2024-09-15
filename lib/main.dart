import 'package:flutter/material.dart';
import 'package:gym_metrics/screens/edit_finished_workout_screen.dart';
import 'package:gym_metrics/states/exercise_state.dart';
import 'package:gym_metrics/states/finished_workout_state.dart';
import 'package:provider/provider.dart';
import 'package:gym_metrics/firebase/firebase_initializer.dart';
import 'package:gym_metrics/screens/active_workout_screen.dart';
import 'package:gym_metrics/screens/add_workout_plan_screen.dart';
import 'package:gym_metrics/screens/edit_workout_plan_screen.dart';
import 'package:gym_metrics/screens/exercise_selection_screen.dart';
import 'package:gym_metrics/screens/login_screen.dart';
import 'package:gym_metrics/screens/main_screen.dart';
import 'package:gym_metrics/screens/register_screen.dart';
import 'package:gym_metrics/screens/settings_screen.dart';
import 'package:gym_metrics/screens/workout_plan_start_screen.dart';
import 'package:gym_metrics/screens/history_screen.dart';
import 'package:gym_metrics/screens/home_screen.dart';
import 'package:gym_metrics/screens/exercises_screen.dart';
import 'package:gym_metrics/screens/workout_screen.dart';
import 'package:gym_metrics/states/user_state.dart';
import 'package:gym_metrics/states/workout_plan_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserState()),
        ChangeNotifierProvider(create: (_) => WorkoutPlanState()),
        ChangeNotifierProvider(create: (_) => ExerciseState()),
        ChangeNotifierProvider(create: (_) => FinishedWorkoutState()),
      ],
      child: const MyApp(),
    ),
  );
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
        '/history': (context) => HistoryScreen(),
        '/workout': (context) => const WorkoutScreen(),
        '/add-workout-plan': (context) => const AddWorkoutPlanScreen(),
        '/edit-workout-plan': (context) => const EditWorkoutPlanScreen(),
        '/edit-finished-workout': (context) => EditFinishedWorkoutScreen(),
        '/workout-plan-start': (context) => const WorkoutPlanStartScreen(),
        '/active_workout': (context) => const ActiveWorkoutScreen(),
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
