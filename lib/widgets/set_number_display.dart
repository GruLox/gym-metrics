import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';

class SetNumberDisplay extends StatelessWidget {
  final int setNumber;

  const SetNumberDisplay({Key? key, required this.setNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Center(
        child: Text(
          setNumber.toString(),
          style: const TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}