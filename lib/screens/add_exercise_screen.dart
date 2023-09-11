import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';

final db = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

class AddExerciseScreen extends StatefulWidget {
  AddExerciseScreen({super.key, required this.addExercise});

  final Function addExercise;

  @override
  State<AddExerciseScreen> createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
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
      widget.addExercise();
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 60.0,
          left: 30.0,
          right: 30.0,
          bottom: 30.0,
        ),
        color: const Color(0xFF101319),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add Exercise',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30.0, color: Colors.white),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.black),
              decoration: kWhiteInputDecoration,
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                const Text('Muscle Group'),
                const Spacer(),
                DropdownButton(
                    value: muscleGroup,
                    items: const [
                      DropdownMenuItem(
                        value: 'None',
                        child: Text('None'),
                      ),
                      DropdownMenuItem(
                        value: 'Core',
                        child: Text('Core'),
                      ),
                      DropdownMenuItem(
                        value: 'Arms',
                        child: Text('Arms'),
                      ),
                      DropdownMenuItem(
                        value: 'Back',
                        child: Text('Back'),
                      ),
                      DropdownMenuItem(
                        value: 'Chest',
                        child: Text('Chest'),
                      ),
                      DropdownMenuItem(
                        value: 'Legs',
                        child: Text('Legs'),
                      ),
                      DropdownMenuItem(
                        value: 'Shoulders',
                        child: Text('Shoulders'),
                      ),
                    ],
                    onChanged: (selectedItem) {
                      setState(() {
                        muscleGroup = selectedItem!;
                      });
                    }),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: addExercise,
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
