import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';

class ExerciseSetRow extends StatefulWidget {
  const ExerciseSetRow({
    super.key,
    required this.setNumber,
    this.isLocked = false,
  });

  final bool isLocked;
  final int setNumber;

  @override
  State<ExerciseSetRow> createState() => _ExerciseSetRowState();
}

class _ExerciseSetRowState extends State<ExerciseSetRow> {
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _isCompleted ? Color(0xFF11664a) : Colors.transparent,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.setNumber.toString(),
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('-'),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                SizedBox(height: 10.0),
                Container(
                  height: 35.0,
                  child: TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                    decoration: kWhiteInputDecoration.copyWith(
                      hintText: '0',
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 5.0),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                SizedBox(height: 10.0),
                Container(
                  height: 35.0,
                  child: TextField(
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(color: Colors.black),
                    decoration: kWhiteInputDecoration.copyWith(
                      hintText: '0',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: IconButton(
                iconSize: 40.0,
                icon: Icon(widget.isLocked ? Icons.lock : Icons.check_box,
                    color: _isCompleted ? Color(0xFF20ba68) : Colors.white),
                onPressed: () {
                  setState(() {
                    _isCompleted = !_isCompleted;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
