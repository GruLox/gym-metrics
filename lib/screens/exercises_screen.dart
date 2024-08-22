import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/widgets/custom_search_bar.dart';
import 'package:gym_metrics/models/exercise.dart';
import 'package:gym_metrics/widgets/exercise_list.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({Key? key}) : super(key: key);

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  late Future<List<Exercise>> _exercisesFuture;
  List<Exercise> _exercises = [];
  List<Exercise> _filteredExercises = [];
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _exercisesFuture = getExercises();
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

  void refreshExercises() {
    setState(() {
      _exercisesFuture = getExercises();
    });
  }

  void filterExercises(String query) {
    setState(() {
      _filteredExercises = _exercises.where((exercise) {
        final exerciseName = exercise.name.toLowerCase();
        final muscleGroup = exercise.muscleGroup.toLowerCase();
        final searchQuery = query.toLowerCase();
        return exerciseName.contains(searchQuery) ||
            muscleGroup.contains(searchQuery);
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
            CustomSearchBar(
              isSearching: _isSearching,
              searchController: _searchController,
              onSearchChanged: filterExercises,
              onSearchToggled: () {
                setState(() {
                  _isSearching = !_isSearching;
                  _filteredExercises = _exercises;
                  if (!_isSearching) {
                    _searchController.clear();
                  }
                });
              },
              onExerciseAdded: refreshExercises,
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Exercises',
              style: TextStyle(fontSize: 30.0),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: FutureBuilder<List<Exercise>>(
                future: _exercisesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No exercises found.'));
                  } else {
                    _exercises = snapshot.data!;
                    final displayExercises =
                        _isSearching ? _filteredExercises : _exercises;

                    if (displayExercises.isEmpty) {
                      return const Center(child: Text('No exercises found.'));
                    }

                    return ExerciseList(exercises: displayExercises);
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
