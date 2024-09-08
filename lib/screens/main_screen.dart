import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/models/history_data.dart';
import 'package:gym_metrics/models/workout_plan.dart';
import 'package:gym_metrics/screens/exercises_screen.dart';
import 'package:gym_metrics/screens/history_screen.dart';
import 'package:gym_metrics/screens/home_screen.dart';
import 'package:gym_metrics/screens/workout_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  static final List<Widget> _screens = [
    const HomeScreen(),
    HistoryScreen(
      historyData: [
        HistoryData(
          title: 'Push',
          date: 'September 1',
          duration: '10m',
          weight: '100kg',
          prs: '3 PRs',
        ),
        HistoryData(
          title: 'Pull',
          date: 'September 2',
          duration: '15m',
          weight: '120kg',
          prs: '5 PRs',
        ),
        HistoryData(
          title: 'Legs',
          date: 'September 3',
          duration: '20m',
          weight: '150kg',
          prs: '7 PRs',
        ),
      ],
    ),
    const WorkoutScreen(),
    const ExercisesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
            {};

    final ValueNotifier<bool> isMinimizedNotifier =
        args['isMinimizedNotifier'] as ValueNotifier<bool>? ??
            ValueNotifier(false);

    final WorkoutPlan workoutPlan = args['workoutPlan'] as WorkoutPlan? ??
        WorkoutPlan(
          id: '',
          name: '',
          exerciseList: [],
        );

    if (FirebaseAuth.instance.currentUser == null) {
      Future.delayed(Duration.zero, () {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      });
      return const CircularProgressIndicator();
    }

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Exercises',
          ),
        ],
      ),
      bottomSheet: ValueListenableBuilder<bool>(
        valueListenable: isMinimizedNotifier,
        builder: (context, isMinimized, child) {
          if (isMinimized) {
            return InkWell(
              onTap: () {
                isMinimizedNotifier.value = false;
                Navigator.pushNamed(
                  context,
                  '/active_workout',
                  arguments: workoutPlan,
                );
              },
              child: Container(
                height: 60.0,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 21, 40, 45),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          workoutPlan.name,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('0:00'),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
