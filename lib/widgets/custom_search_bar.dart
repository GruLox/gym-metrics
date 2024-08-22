import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/screens/add_exercise_screen.dart';

class CustomSearchBar extends StatelessWidget {
  final bool isSearching;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onSearchToggled;
  final VoidCallback onExerciseAdded;

  const CustomSearchBar({
    super.key,
    required this.isSearching,
    required this.searchController,
    required this.onSearchChanged,
    required this.onSearchToggled,
    required this.onExerciseAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        isSearching
            ? Expanded(
                child: TextField(
                  autofocus: true,
                  controller: searchController,
                  onChanged: onSearchChanged,
                  decoration: kWhiteInputDecoration.copyWith(
                    icon: const Icon(Icons.search),
                    iconColor: Colors.white,
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => AddExerciseScreen(addExercise: () {
                      // Refresh exercises
                      onExerciseAdded();
                    }),
                    barrierColor: Colors.black.withOpacity(0.5),
                  );
                },
              ),
        IconButton(
          icon: Icon(isSearching ? Icons.close : Icons.search),
          iconSize: isSearching ? 30.0 : 24,
          onPressed: onSearchToggled,
        ),
      ],
    );
  }
}
