import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gym_metrics/models/finished_workout.dart';
import 'package:gym_metrics/widgets/exercise_history_card.dart';
import 'package:gym_metrics/widgets/one_rep_max_chart.dart';
import 'package:provider/provider.dart';
import 'package:gym_metrics/models/exercise.dart';
import 'package:gym_metrics/states/finished_workout_state.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final Exercise exercise;

  const ExerciseDetailScreen({Key? key, required this.exercise})
      : super(key: key);

  @override
  _ExerciseDetailScreenState createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  bool _isLoading = true;
  List<FinishedWorkout> _history = [];

  @override
  void initState() {
    super.initState();
    _fetchExerciseHistory();
  }

  void _fetchExerciseHistory() async {
    final finishedWorkoutState =
        Provider.of<FinishedWorkoutState>(context, listen: false);
    await finishedWorkoutState.fetchFinishedWorkouts();

    final history = finishedWorkoutState.finishedWorkouts.where((workout) {
      return workout.exerciseList
          .any((set) => set.exercise.id == widget.exercise.id);
    }).toList();

    setState(() {
      _history = history;
      _isLoading = false;
    });
  }

  List<FlSpot> _getOneRepMaxDataPoints() {
    List<FlSpot> dataPoints = [];
    // history is sorted by date in descending order
    final history = _history.reversed.toList();
    for (int i = 0; i < history.length; i++) {
      final workout = history[i];
      final setIndex = workout.exerciseList.indexWhere((set) => set.exercise.id == widget.exercise.id);
      if (setIndex != -1) {
        final bestSet = workout.exerciseList[setIndex].bestSet;
        dataPoints.add(FlSpot(i.toDouble(), bestSet.oneRepMax.toDouble()));
      }
    }
    return dataPoints;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.exercise.name),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'History'),
              Tab(text: 'Diagrams'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildHistoryTab(),
            _buildDiagramsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryTab() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
        itemCount: _history.length,
        itemBuilder: (context, index) {
          final workout = _history[index];
          final setIndex = workout.exerciseList
              .indexWhere((set) => set.exercise.id == widget.exercise.id);
          return ExerciseHistoryCard(
              finishedWorkout: workout, setIndex: setIndex);
        },
      ),
    );
  }

  Widget _buildDiagramsTab() {
    final dataPoints = _getOneRepMaxDataPoints();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: dataPoints.isEmpty
          ? const Center(child: Text('No data available'))
          : OneRepMaxChart(dataPoints: dataPoints),
    );
  }
}
