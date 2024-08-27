import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/widgets/custom_search_bar.dart';
import 'package:gym_metrics/models/exercise.dart';
import 'package:gym_metrics/widgets/exercise_list.dart';
import 'package:gym_metrics/states/exercise_state.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({Key? key}) : super(key: key);

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  late ExerciseState _exerciseState;
  List<Exercise> _exercises = [];
  List<Exercise> _filteredExercises = [];
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final exerciseState = Provider.of<ExerciseState>(context, listen: false);
      exerciseState.fetchExercises().then((_) {
        setState(() {
          _exercises = exerciseState.exercises;
          _filteredExercises = _exercises;
        });
      });
    });
  }

  void refreshExercises() {
    _exerciseState.fetchExercises().then((_) {
      setState(() {
        _exercises = _exerciseState.exercises;
        _filteredExercises = _exercises;
      });
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
              child: Consumer<ExerciseState>(
                builder: (context, exerciseState, child) {
                  final exercises = _isSearching
                      ? _filteredExercises
                      : exerciseState.exercises;
                  if (_filteredExercises.isEmpty && _isSearching) {
                    return const Center(
                      child: Text('No exercises found.'),
                    );
                  }
                  else if (exercises.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ExerciseList(exercises: exercises);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
