import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/states/workout_plan_state.dart';
import 'package:gym_metrics/widgets/my_templates_header.dart';
import 'package:gym_metrics/widgets/quick_start_button.dart';
import 'package:gym_metrics/widgets/workout_plans_list.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  late WorkoutPlanState _workoutState;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _workoutState = Provider.of<WorkoutPlanState>(context, listen: false);
    _workoutState.fetchWorkoutPlans().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _onWorkoutUpdated() {
    setState(() {
      _workoutState.fetchWorkoutPlans();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: kContainerMargin.copyWith(top: 80.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Workout',
                    style: TextStyle(fontSize: 30.0),
                  ),
                  const SizedBox(height: 30.0),
                  const Text(
                    'QUICK START',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 10.0),
                  const QuickStartButton(),
                  const MyTemplatesHeader(),
                  Expanded(
                    child: Consumer<WorkoutPlanState>(
                      builder: (context, workoutState, child) {
                        return WorkoutPlansList(
                          workoutPlans: workoutState.workoutPlans,
                          onWorkoutUpdated: _onWorkoutUpdated,
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
