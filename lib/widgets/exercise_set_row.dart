import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';

class ExerciseSetRow extends StatefulWidget {
  const ExerciseSetRow({
    super.key,
    required this.setNumber,
    this.isLocked = false,
    required this.onSetDismissedCallback,
  });

  final bool isLocked;
  final int setNumber;
  final Function(int) onSetDismissedCallback;

  @override
  State<ExerciseSetRow> createState() => _ExerciseSetRowState();
}

class _ExerciseSetRowState extends State<ExerciseSetRow> {
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _isCompleted ? const Color(0xFF11664a) : Colors.transparent,
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          widget.onSetDismissedCallback(widget.setNumber);
        },
        background: Container(
          color: Colors.red,
          child: const Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.delete, color: Colors.white),
              ],
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.setNumber.toString(),
                    style: const TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('-'),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 35.0,
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black),
                      decoration: kWhiteInputDecoration.copyWith(
                        hintText: '0',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5.0),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 35.0,
                    child: TextField(
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(color: Colors.black),
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
                      color: _isCompleted ? const Color(0xFF20ba68) : Colors.white),
                  onPressed: () {
                    setState(() {
                      if (!widget.isLocked) _isCompleted = !_isCompleted;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
