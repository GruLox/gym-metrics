import 'package:gym_metrics/mixins/exercise_management_mixin.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/widgets/custom_search_bar.dart';
import 'package:gym_metrics/widgets/exercise_list.dart';
import 'package:gym_metrics/states/exercise_state.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({Key? key}) : super(key: key);

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen>
    with ExerciseManagementMixin {
  bool _isSearching = false;
  final _searchController = TextEditingController();

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
                  filteredExercises = exercises;
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
                      ? filteredExercises
                      : exerciseState.exercises;
                  if (filteredExercises.isEmpty && _isSearching) {
                    return const Center(
                      child: Text('No exercises found.'),
                    );
                  } else if (exercises.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ExerciseList(exercises: exercises, isOnExercisesScreen: true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
