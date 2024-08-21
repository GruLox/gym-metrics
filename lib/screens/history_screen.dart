import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: kContainerMargin,
        child: Scaffold(
          body: Container(
            margin: kContainerMargin,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('History', style: TextStyle(fontSize: 30.0)),
                SizedBox(height: 20.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5.0),
                      Text(
                        'Push',
                        style: const TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        'September 1',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            '10m',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Icon(
                            Icons.monitor_weight_outlined,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            '100kg',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Icon(Icons.emoji_events_outlined, color: Colors.grey),
                          const SizedBox(width: 5.0),
                          Text(
                            '3 PRs',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
