import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';

final db = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

class AddWorkoutPlanScreen extends StatefulWidget {
  const AddWorkoutPlanScreen({
    super.key,
  });


  @override
  State<AddWorkoutPlanScreen> createState() => _AddWorkoutPlanScreenState();
}

class _AddWorkoutPlanScreenState extends State<AddWorkoutPlanScreen> {
  String muscleGroup = 'None';
  final TextEditingController _nameController = TextEditingController();

  void addExercise() async {
    await db
        .collection('users')
        .doc(auth.currentUser?.uid)
        .collection('exercises')
        .add({
      'name': _nameController.text,
      'nameLowercase': _nameController.text.toLowerCase(),
      'muscleGroup': muscleGroup,
    });
    Future.delayed(Duration.zero, () {
      // widget.addExercise();
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a New Plan', style: TextStyle(fontSize: 25.0)),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: addExercise,
          ),
        ],
      ),
      body: Container(
        margin: kContainerMargin.copyWith(top: 0.0),
        padding: const EdgeInsets.only(
          top: 20.0,
          bottom: 30.0,
        ),
        color: const Color(0xFF101319),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20.0),
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.black),
              decoration: kWhiteInputDecoration.copyWith(
                hintText: 'Workout Name',
              ),),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/select-exercises');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Add Exercise',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
