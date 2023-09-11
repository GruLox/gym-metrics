import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/screens/add_exercise_screen.dart';
import 'package:gym_metrics/widgets/exercise_card.dart';
import 'package:gym_metrics/models/exercise.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({Key? key}) : super(key: key);

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  late Future<List<Exercise>> exercisesFuture;
  List<Exercise> exercises = [];
  List<Exercise> filteredExercises = [];
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    exercisesFuture = getExercises();
  }

  Future<List<Exercise>> getExercises() async {
    final querySnapshot = await db
        .collection('users')
        .doc(auth.currentUser?.uid)
        .collection('exercises')
        .orderBy('nameLowercase')
        .get();

    final exercises = querySnapshot.docs.map((doc) {
      final data = doc.data();
      return Exercise(
        name: data['name'],
        muscleGroup: data['muscleGroup'],
      );
    }).toList();

    return exercises;
  }

  void filterExercises(String query) {
    setState(() {
      filteredExercises = exercises.where((exercise) {
        return exercise.name.toLowerCase().contains(query.toLowerCase()) ||
            exercise.muscleGroup.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: kContainerMargin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                isSearching
                    ? Expanded(
                        child: TextField(
                          autofocus: true,
                          controller: _searchController,
                          onChanged: (value) {
                            // Handle search query
                            filterExercises(value);
                          },
                          decoration: kWhiteInputDecoration.copyWith(
                            icon: const Icon(Icons.search),
                            iconColor: Colors.white,
                          ),
                          style: const TextStyle(color: Colors.black),
                        ),
                      )
                    : IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) =>
                                AddExerciseScreen(addExercise: () {
                              setState(() {
                                exercisesFuture = getExercises();
                              });
                            }),
                            barrierColor: Colors.black.withOpacity(0.5),
                          );
                        },
                      ),
                IconButton(
                  icon: Icon(isSearching ? Icons.close : Icons.search),
                  iconSize: isSearching ? 30.0 : 24,
                  onPressed: () {
                    setState(
                      () {
                        isSearching = !isSearching;
                        filteredExercises = exercises;
                        if (!isSearching) {
                          _searchController.clear();
                        }
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Exercises',
              style: TextStyle(fontSize: 30.0),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: FutureBuilder<List<Exercise>>(
                future: exercisesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display a loading spinner while waiting for data.
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // Display an error message if there was an error.
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    // Display a message when there is no data.
                    return const Text('No exercises found.');
                  } else {
                    // Display the list of exercises.
                    exercises = snapshot.data!;
                    final displayExercises =
                        isSearching ? filteredExercises : exercises;

                    if (displayExercises.isEmpty) {
                      return const Text('No exercises found.');
                    }

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: displayExercises.length,
                      itemBuilder: (context, index) {
                        final exercise = displayExercises[index];
                        return ExerciseCard(
                          name: exercise.name,
                          muscleGroup: exercise.muscleGroup,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
