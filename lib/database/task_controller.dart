import 'package:e_learning/model/task_model.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TaskController extends GetxController {
  static Database? _db;

  var tasks = <TaskModel>[].obs;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDB();
    }
    return _db;
  }

  Future<Database> initDB() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'task_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            title TEXT, 
            description TEXT, 
            isCompleted INTEGER
          )
        ''');
      },
    );
  }

  // Insert Task
  Future<int> addTask(TaskModel task) async {
    var dbClient = await db;
    int result = await dbClient!.insert('tasks', task.toMap());
    loadTasks();
    return result;
  }

  // Retrieve Tasks
  Future<void> loadTasks() async {
    var dbClient = await db;
    List<Map<String, dynamic>> queryResult = await dbClient!.query('tasks');
    tasks
        .assignAll(queryResult.map((data) => TaskModel.fromMap(data)).toList());
  }

  // Update Task
  /*
  Future<int> updateTask(TaskModel task) async {
    var dbClient = await db;
    int result = await dbClient!.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
    loadTasks();
    return result;
  }*/

  // Delete Task
  Future<void> deleteTask(int id) async {
    var dbClient = await db;
    await dbClient!.delete('tasks', where: 'id = ?', whereArgs: [id]);
    loadTasks();
  }
}
