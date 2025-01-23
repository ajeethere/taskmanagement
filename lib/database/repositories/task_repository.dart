import 'package:flutterassignement/database/database_helper.dart';
import 'package:flutterassignement/object_models/task_obj.dart';

class TaskRepository{
  final dbHelper = DatabaseHelper();

  Future<int> insertTask(TaskObj task) async {
    final db = await dbHelper.database;
    return db.insert('tasks', task.toMap());
  }

  Future<List<TaskObj>> getTasks() async {
    final db = await dbHelper.database;
    final result = await db.query('tasks');
    return result.map((map) => TaskObj.fromMap(map)).toList();
  }
}