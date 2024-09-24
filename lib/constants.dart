import 'package:flutter/material.dart';

const kContainerMargin = EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0);

const Color kPrimaryColor = Color(0xFF0244A1);

const Color kAvatarBackgroundColor = Color.fromARGB(255, 40, 46, 58);

const kExerciseIcon = Icons.fitness_center;

const kWhiteInputDecoration = InputDecoration(
  hintText: 'Exercise name',
  hintStyle: TextStyle(color: Colors.grey),
  filled: true,
  fillColor: Colors.white,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide.none,
  ),
  contentPadding: EdgeInsets.all(10.0),
);

const kMonths = {
  1: 'January',
  2: 'February',
  3: 'March',
  4: 'April',
  5: 'May',
  6: 'June',
  7: 'July',
  8: 'August',
  9: 'September',
  10: 'October',
  11: 'November',
  12: 'December',
};

const kDays = {
  1: 'Monday',
  2: 'Tuesday',
  3: 'Wednesday',
  4: 'Thursday',
  5: 'Friday',
  6: 'Saturday',
  7: 'Sunday',
};
