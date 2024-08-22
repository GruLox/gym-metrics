import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/models/history_data.dart';
import 'package:gym_metrics/widgets/history_card.dart';

class HistoryScreen extends StatelessWidget {
  final List<HistoryData> historyData;
  final bool isLoading;
  final String? errorMessage;

  const HistoryScreen(
      {super.key,
      required this.historyData,
      this.isLoading = false,
      this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: kContainerMargin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.calendar_month_outlined, size: 30.0),
            ),
            const Text('History', style: TextStyle(fontSize: 40.0)),
            const SizedBox(height: 20.0),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (errorMessage != null)
              Center(child: Text(errorMessage!))
            else if (historyData.isEmpty)
              const Center(child: Text('No history data available.'))
            else
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: historyData
                        .map((data) => HistoryCard(data: data))
                        .toList(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
