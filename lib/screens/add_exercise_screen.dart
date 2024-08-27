import 'package:flutter/material.dart';
import 'package:gym_metrics/models/exercise.dart';
import 'package:gym_metrics/widgets/add_exercise_button.dart';
import 'package:gym_metrics/widgets/add_exercise_header.dart';
import 'package:gym_metrics/widgets/add_exercise_name_field.dart';
import 'package:gym_metrics/widgets/muscle_group_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:gym_metrics/states/exercise_state.dart';

class AddExerciseScreen extends StatefulWidget {
  const AddExerciseScreen({super.key, required this.addExercise});

  final Function addExercise;

  @override
  State<AddExerciseScreen> createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  String _muscleGroup = 'None';
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void addExercise() async {
    final exerciseState = Provider.of<ExerciseState>(context, listen: false);
    final newExercise = Exercise(
      id: '',
      name: _nameController.text,
      nameLowercase: _nameController.text.toLowerCase(),
      muscleGroup: _muscleGroup,
    );

    try {
      await exerciseState.addExercise(newExercise);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add exercise: $e')),
      );
    }
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
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).viewInsets.bottom,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AddExerciseHeader(),
                const SizedBox(height: 20.0),
                AddExerciseNameField(controller: _nameController),
                const SizedBox(height: 20.0),
                MuscleGroupDropdown(
                    muscleGroup: _muscleGroup,
                    onChanged: (String? selectedItem) {
                      setState(() {
                        _muscleGroup = selectedItem ?? 'None';
                      });
                    }),
                const SizedBox(height: 20.0),
                AddExerciseButton(onPressed: addExercise),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
