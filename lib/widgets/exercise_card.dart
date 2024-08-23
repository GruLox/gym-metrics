import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';

const kExerciseIcon = Icons.fitness_center;

class ExerciseCard extends StatefulWidget {
  const ExerciseCard({
    super.key,
    required this.name,
    required this.muscleGroup,
    this.icon = kExerciseIcon,
  });

  final String name;
  final String muscleGroup;
  final IconData icon;

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                widget.name,
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              Text(widget.muscleGroup),
            ],
          ),
        ],
      ),
    );
  }
}
