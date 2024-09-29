 // date, count 

 class WeeklyWorkoutStatisticsData {
  final DateTime date;
  int count;
  final int weeksAgo;

  WeeklyWorkoutStatisticsData({
    required this.date,
    required this.count,
  }) : weeksAgo = DateTime.now().difference(date).inDays ~/ 7;

  factory WeeklyWorkoutStatisticsData.fromMap(Map<String, dynamic> map) {
    return WeeklyWorkoutStatisticsData(
      date: DateTime.parse(map['date'] as String),
      count: map['count'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'count': count,
    };
  }
}

