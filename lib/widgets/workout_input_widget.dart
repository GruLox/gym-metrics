import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';

class WorkoutInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final int startingData;
  final void Function(String) onSubmitted;


  const WorkoutInputWidget({Key? key, required this.controller, required this.startingData, required this.onSubmitted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 35.0,
          width: 70.0,
          child: TextField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            controller: controller,
            style: const TextStyle(color: Colors.black),
            decoration: kWhiteInputDecoration.copyWith(
              hintText: startingData.toString(),
            ),
            onSubmitted: onSubmitted,
          ),
        ),
      ],
    );
  }
}