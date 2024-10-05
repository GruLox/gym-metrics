import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/enums/muscle_group.dart';
import 'package:gym_metrics/screens/exercise_detail_screen.dart'; 
import 'package:gym_metrics/models/exercise.dart'; 

class ExerciseCard extends StatefulWidget {
  const ExerciseCard({
    super.key,
    required this.exercise, 
    this.icon = kExerciseIcon,
    this.isOnExercisesScreen = false, 
  });

  final Exercise exercise; 
  final IconData icon;
  final bool isOnExercisesScreen; 

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isOnExercisesScreen
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseDetailScreen(exercise: widget.exercise),
                ),
              );
            }
          : null,
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.exercise.name,
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.exercise.muscleGroup.muscleGroupToString(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}