import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/models/exercise.dart';
import 'package:gym_metrics/states/exercise_state.dart';
import 'package:gym_metrics/widgets/exercise_list.dart';

abstract class BaseExerciseScreen extends StatefulWidget {
  const BaseExerciseScreen({Key? key}) : super(key: key);

  @override
  State<BaseExerciseScreen> createState() => _BaseExerciseScreenState();

  PreferredSizeWidget buildAppBar(BuildContext context);
  Widget buildFloatingActionButton(BuildContext context);
  String getTitle();
}

class _BaseExerciseScreenState extends State<BaseExerciseScreen> {
  late ExerciseState _exerciseState;
  List<Exercise> _exercises = [];
  List<Exercise> _filteredExercises = [];
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _exerciseState = Provider.of<ExerciseState>(context, listen: false);
      refreshExercises();
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
        final muscleGroup = exercise.muscleGroup;
        final searchQuery = query.toLowerCase();
        return exerciseName.contains(searchQuery) ||
            muscleGroup.toString().contains(searchQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.buildAppBar(context),
      floatingActionButton: widget.buildFloatingActionButton(context),
      body: Container(
        margin: kContainerMargin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            Text(
              widget.getTitle(),
              style: const TextStyle(fontSize: 30.0),
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
                  } else if (exercises.isEmpty) {
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