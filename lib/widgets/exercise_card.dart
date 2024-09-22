import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/enums/muscle_group.dart';
import 'package:gym_metrics/screens/exercise_detail_screen.dart'; // Import the ExerciseDetailScreen
import 'package:gym_metrics/models/exercise.dart'; // Import the Exercise model

const kExerciseIcon = Icons.fitness_center;

class ExerciseCard extends StatefulWidget {
  const ExerciseCard({
    super.key,
    required this.exercise, // Use Exercise model instead of individual fields
    this.icon = kExerciseIcon,
  });

  final Exercise exercise; // Use Exercise model
  final IconData icon;

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExerciseDetailScreen(exercise: widget.exercise),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: kAvatarBackgroundColor,
              radius: 30.0,
              child: Icon(
                widget.icon,
                size: 30.0,
              ),
            ),
            const SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.exercise.name,
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Text(widget.exercise.muscleGroup.muscleGroupToString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}