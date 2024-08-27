import 'package:gym_metrics/screens/add_exercise_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/models/weightlifting_set.dart';
import 'package:gym_metrics/models/exercise.dart';
import 'package:gym_metrics/widgets/selectable_exercise_card.dart';
import 'package:gym_metrics/states/exercise_state.dart';

class ExerciseSelectionScreen extends StatefulWidget {
  const ExerciseSelectionScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseSelectionScreen> createState() =>
      _ExerciseSelectionScreenState();
}

class _ExerciseSelectionScreenState extends State<ExerciseSelectionScreen> {
  late final ExerciseState _exerciseState;
  List<Exercise> _exercises = [];
  List<Exercise> _filteredExercises = [];
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  List<Exercise> _selectedExercises = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _exerciseState = Provider.of<ExerciseState>(context, listen: false);
      refreshExercises();
    });
  }

  void selectionCallback(Exercise exercise) {
    setState(() {
      if (_selectedExercises.contains(exercise)) {
        _selectedExercises.remove(exercise);
      } else {
        _selectedExercises.add(exercise);
      }
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

  void addExercisesToPlan() {
    final newExercises = _selectedExercises.map((exercise) {
      return WeightliftingSet(exercise: exercise);
    }).toList();

    Navigator.pop(context, newExercises);
  }

  void refreshExercises() {
    _exerciseState.fetchExercises().then((_) {
      setState(() {
        _exercises = _exerciseState.exercises;
        _filteredExercises = _exercises;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          _isSearching
              ? Expanded(
                  child: TextField(
                    autofocus: true,
                    controller: _searchController,
                    onChanged: (value) {
                      // Handle search query
                      filterExercises(value);
                    },
                    decoration: kWhiteInputDecoration,
                    style: const TextStyle(color: Colors.black),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => AddExerciseScreen(addExercise: () {
                        setState(() {
                          refreshExercises();
                        });
                      }),
                      barrierColor: Colors.black.withOpacity(0.5),
                    );
                  },
                ),
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            iconSize: _isSearching ? 30.0 : 24.0,
            onPressed: () {
              setState(
                () {
                  _isSearching = !_isSearching;
                  _filteredExercises = _exercises;
                  if (!_isSearching) {
                    _searchController.clear();
                  }
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          addExercisesToPlan();
        },
        child: const Icon(Icons.check),
      ),
      body: Container(
        margin: kContainerMargin.copyWith(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Exercises',
              style: TextStyle(fontSize: 30.0),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: Consumer<ExerciseState>(
                builder: (context, exerciseState, child) {
                  if (_filteredExercises.isEmpty && _isSearching) {
                    return const Center(
                      child: Text('No exercises found.'),
                    );
                  } else if (_filteredExercises.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: _filteredExercises.length,
                    itemBuilder: (context, index) {
                      final exercise = _filteredExercises[index];
                      return SelectableExerciseCard(
                        name: exercise.name,
                        muscleGroup: exercise.muscleGroup,
                        selectionCallback: () => selectionCallback(exercise),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

      // AppBar(
      //   actions: [
      //     CustomSearchBar(
      //       isSearching: _isSearching,
      //       searchController: _searchController,
      //       onSearchChanged: filterExercises,
      //       onSearchToggled: () {
      //         setState(() {
      //           _isSearching = !_isSearching;
      //           _filteredExercises = _exercises;
      //           if (!_isSearching) {
      //             _searchController.clear();
      //           }
      //         });
      //       },
      //       onExerciseAdded: refreshExercises,
      //     ),
      //   ],
      // ),