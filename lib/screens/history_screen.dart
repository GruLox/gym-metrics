import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/models/history_data.dart';
import 'package:gym_metrics/widgets/history_card.dart';

class HistoryScreen extends StatelessWidget {
  final List<HistoryData> _historyData;
  final bool _isLoading;
  final String? _errorMessage;

  const HistoryScreen(
      {super.key,
      required List<HistoryData> historyData,
      bool isLoading = false,
      String? errorMessage})
      : _errorMessage = errorMessage,
        _isLoading = isLoading,
        _historyData = historyData;

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
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_errorMessage != null)
              Center(child: Text(_errorMessage!))
            else if (_historyData.isEmpty)
              const Center(child: Text('No history data available.'))
            else
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: _historyData
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
