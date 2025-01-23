class TaskObj {
  static const String tableName = 'tasks';

  int? id;
  String name;
  String? description;
  String? priority;
  String? dueDate;

  TaskObj({
    this.id,
    required this.name,
    this.description,
    this.priority,
    this.dueDate,
  });
  // Create a Task object from a Map
  factory TaskObj.fromMap(Map<String, dynamic> map) {
    return TaskObj(
      id: map['id'] as int?,
      name: map['name'] as String,
      description: map['description'] as String?,
      priority: map['priority'] as String?,
      dueDate: map['dueDate'] as String?,
    );
  }
  // Convert a Task object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'priority': priority,
      'dueDate': dueDate,
    };
  }

  // SQL table creation query for Task
  static String createTableQuery() {
    return '''
      CREATE TABLE $tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT,
        priority TEXT,
        dueDate TEXT
      )
    ''';
  }
}
