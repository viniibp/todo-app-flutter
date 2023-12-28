class Task {
  final int? id;

  final String description;
  final DateTime executionDate;
  bool? ended = false;

  Task({
    required this.description,
    required this.executionDate,
    this.ended,
    this.id,
  });

  factory Task.fromSqfliteDatabase(Map<String, dynamic> map) => Task(
        id: map['id'] ?? 0,
        description: map['description'] ?? '',
        executionDate: DateTime.fromMillisecondsSinceEpoch(
          map['executionTime'],
        ),
        ended: map['ended'] == 0 ? false : true,
      );
}
