import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gym_metrics/models/finished_workout.dart';
import 'package:gym_metrics/widgets/best_set_reps_chart.dart';
import 'package:gym_metrics/widgets/chart_card.dart';
import 'package:gym_metrics/widgets/exercise_history_card.dart';
import 'package:gym_metrics/widgets/one_rep_max_chart.dart';
import 'package:gym_metrics/widgets/total_volume_chart.dart';
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
      _history = history.reversed.toList();
      _isLoading = false;
    });
  }

  List<FlSpot> _getOneRepMaxDataPoints() {
    List<FlSpot> dataPoints = [];
    final history = _history;
    for (int i = 0; i < history.length; i++) {
      final workout = history[i];
      final setIndex = workout.exerciseList
          .indexWhere((set) => set.exercise.id == widget.exercise.id);
      if (setIndex != -1) {
        final bestSet = workout.exerciseList[setIndex].bestSet;
        dataPoints.add(FlSpot(i.toDouble(), bestSet.oneRepMax.toDouble()));
      }
    }
    return dataPoints;
  }

  List<FlSpot> _getTotalVolumeDataPoints() {
    List<FlSpot> dataPoints = [];
    final history = _history;
    for (int i = 0; i < history.length; i++) {
      final workout = history[i];
      final setIndex = workout.exerciseList
          .indexWhere((set) => set.exercise.id == widget.exercise.id);
      if (setIndex != -1) {
        final totalVolume = workout.exerciseList[setIndex].sets
            .fold(0, (sum, set) => sum + (set.weight * set.reps));
        dataPoints.add(FlSpot(i.toDouble(), totalVolume.toDouble()));
      }
    }
    return dataPoints;
  }

  List<FlSpot> _getBestSetRepsDataPoints() {
    List<FlSpot> dataPoints = [];
    final history = _history;
    for (int i = 0; i < history.length; i++) {
      final workout = history[i];
      final setIndex = workout.exerciseList
          .indexWhere((set) => set.exercise.id == widget.exercise.id);
      if (setIndex != -1) {
        final bestSet = workout.exerciseList[setIndex].bestSet;
        dataPoints.add(FlSpot(i.toDouble(), bestSet.reps.toDouble()));
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
    final oneRepMaxDataPoints = _getOneRepMaxDataPoints();
    final totalVolumeDataPoints = _getTotalVolumeDataPoints();
    final bestSetRepsDataPoints = _getBestSetRepsDataPoints();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ChartCard(
              title: 'Best Set (est. 1RM)',
              chart: AspectRatio(
                aspectRatio: 16 / 9,
                child: oneRepMaxDataPoints.isEmpty
                    ? const Center(child: Text('No data available'))
                    : OneRepMaxChart(dataPoints: oneRepMaxDataPoints),
              ),
            ),
            const SizedBox(height: 20.0),
            ChartCard(
              title: 'Total Volume (kg)',
              chart: AspectRatio(
                aspectRatio: 16 / 9,
                child: totalVolumeDataPoints.isEmpty
                    ? const Center(child: Text('No data available'))
                    : TotalVolumeChart(dataPoints: totalVolumeDataPoints),
              ),
            ),
            const SizedBox(height: 20.0),
            ChartCard(
              title: 'Best Set (reps)',
              chart: AspectRatio(
                aspectRatio: 16 / 9,
                child: bestSetRepsDataPoints.isEmpty
                    ? const Center(child: Text('No data available'))
                    : BestSetRepsChart(dataPoints: bestSetRepsDataPoints),
              ),
            ),
          ],
        ),
      ),
    );
  }
}