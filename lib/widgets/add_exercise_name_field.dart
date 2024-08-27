import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';

class AddExerciseNameField extends StatelessWidget {
  final TextEditingController controller;

  const AddExerciseNameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: kWhiteInputDecoration,
    );
  }
}