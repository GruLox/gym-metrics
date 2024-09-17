import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';

class RepsInput extends StatelessWidget {
  final TextEditingController controller;
  final int startingReps;

  const RepsInput({Key? key, required this.controller, required this.startingReps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10.0),
        SizedBox(
          height: 35.0,
          width: 70.0,
          child: TextField(
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            controller: controller,
            style: const TextStyle(color: Colors.black),
            decoration: kWhiteInputDecoration.copyWith(
              hintText: startingReps.toString(),
            ),
          ),
        ),
      ],
    );
  }
}
