import 'package:flutterassignement/database/database_helper.dart';
import 'package:flutterassignement/object_models/task_obj.dart';

class TaskRepository {
  final dbHelper = DatabaseHelper();

  // Insert a task into the database
  Future<int> insertTask(TaskObj task) async {
    final db = await dbHelper.database;
    return db.insert('tasks', task.toMap());
  }

  // Get all tasks from the database
  Future<List<TaskObj>> getTasks() async {
    final db = await dbHelper.database;
    final result = await db.query('tasks');
    return result.map((map) => TaskObj.fromMap(map)).toList();
  }

  // Get a single task by ID
  Future<TaskObj?> getTaskById(int id) async {
    final db = await dbHelper.database;
    final result = await db.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return TaskObj.fromMap(result.first);
    }
    return null;
  }

  // Update a task in the database
  Future<int> updateTask(TaskObj task) async {
    final db = await dbHelper.database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  // Delete a task by ID
  Future<int> deleteTask(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete all tasks in the database
  Future<int> deleteAllTasks() async {
    final db = await dbHelper.database;
    return await db.delete('tasks');
  }
}
