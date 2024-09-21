import 'package:flutter/material.dart';

class CompletionIcon extends StatelessWidget {
  final bool isLocked;
  final bool isCompleted;
  final VoidCallback onPressed;

  const CompletionIcon({
    Key? key,
    required this.isLocked,
    required this.isCompleted,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return IconButton(
      iconSize: 40.0,
      icon: Icon(
        isLocked ? Icons.lock : Icons.check_box,
        color: isCompleted ? const Color(0xFF20ba68) : Colors.white,
      ),
      onPressed: onPressed,
    );
  }
}
