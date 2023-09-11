import 'package:flutter/material.dart';

class WorkoutPlanCard extends StatelessWidget {
  const WorkoutPlanCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Push', style: TextStyle(fontSize: 20.0)),
              PopupMenuButton(
                padding: EdgeInsets.zero,
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem(
                      child: Text('Delete'),
                    ),
                  ];
                },
                child: const Icon(Icons.more_vert),
              ),
            ],
          ),
          const SizedBox(height: 5.0),
          const Text(
            'Last performed: 2 days ago',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 10.0),
          const Text(
            '3 x Bench Press',
            style: TextStyle(color: Colors.grey),
          ),
          const Text(
            '3 x Triceps Pushdown',
            style: TextStyle(color: Colors.grey),
          ),
          const Text(
            '4 x Lateral Raise',
            style: TextStyle(color: Colors.grey),
          ),
          const Text(
            '3 x Chest Dip',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
