import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/states/finished_workout_state.dart';
import 'package:gym_metrics/widgets/history_card.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final FinishedWorkoutState _finishedWorkoutState = FinishedWorkoutState();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _finishedWorkoutState.fetchFinishedWorkouts().then((_) {
      setState(() {
        _isLoading = false;
      });
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
            const Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.calendar_month_outlined, size: 30.0),
            ),
            const Text('History', style: TextStyle(fontSize: 40.0)),
            const SizedBox(height: 20.0),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Consumer<FinishedWorkoutState>(
                    builder: (context, finishedWorkoutState, child) {
                      if (finishedWorkoutState.finishedWorkouts.isEmpty) {
                        return const Center(
                            child: Text('No history data available.'));
                      }
                      return Flexible(
                        child: SingleChildScrollView(
                          child: Column(
                            children: finishedWorkoutState.finishedWorkouts
                                .map((data) =>
                                    HistoryCard(finishedWorkout: data))
                                .toList(),
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
