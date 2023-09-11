import 'package:flutter/material.dart';

const kContainerMargin = EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0);

const Color kPrimaryColor = Color(0xFF0244A1);

const kWhiteInputDecoration = InputDecoration(
  hintText: 'Exercise name',
  hintStyle: TextStyle(color: Colors.grey),
  filled: true,
  fillColor: Colors.white,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide.none,
  ),
);
