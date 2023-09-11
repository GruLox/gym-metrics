import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: kContainerMargin,
        child: Center(
          child: Text('History'),
        ),
      ),
    );
  }
}
