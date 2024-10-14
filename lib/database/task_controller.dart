import 'package:e_learning/model/task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  static Database? _db;
  var tasks = <TaskModel>[].obs; // Observable untuk melacak task

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
      version: 3,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            isCompleted INTEGER,
            image TEXT
          )
        ''');
      },
    );
  }

  // Retrieve a task by title
  Future<TaskModel?> getTaskByTitle(String title) async {
    var dbClient = await db;

    if (dbClient == null) {
      print('ERROR: Database is not initialized!');
      return null;
    }

    print('DEBUG: Querying database for task with title: $title...');

    try {
      List<Map<String, dynamic>> queryResult = await dbClient!.query(
        'tasks',
        where: 'title = ?',
        whereArgs: [title],
      );
      
      if (queryResult.isNotEmpty) {
        print('DEBUG: Task found in database with title: $title');
        return TaskModel.fromMap(queryResult.first);
      } else {
        print('DEBUG: No task found in database for title: $title');
        return null;
      }
    } catch (e) {
      print('ERROR: Error querying the database: $e');
      return null;
    }
  }

  // Update the saved status of a task
  Future<void> updateTaskStatus(int id, int isCompleted) async {
    var dbClient = await db;
    await dbClient!.update(
      'tasks',
      {'isCompleted': isCompleted},
      where: 'id = ?',
      whereArgs: [id],
    );
    loadTasks(); // Refresh task setelah update
  }

  // Add a task to the database
  Future<int> addTask(TaskModel task) async {
  var dbClient = await db;

  TaskModel? existingTask = await getTaskByTitle(task.title);
  
  if (existingTask != null) {
    print('DEBUG: Task "${task.title}" already exists, updating isCompleted to: ${task.isCompleted}');
    int updateResult = await dbClient!.update(
      'tasks',
      {'isCompleted': task.isCompleted ? 1 : 0},
      where: 'id = ?',
      whereArgs: [existingTask.id],
    );
    print('DEBUG: Task "${task.title}" updated in database with result: $updateResult');
    await loadTasks();  // Pastikan untuk memuat ulang data setelah update
    return updateResult;
  } else {
    print('DEBUG: Adding new task "${task.title}" to the database with isCompleted status: ${task.isCompleted}');
    int insertResult = await dbClient!.insert('tasks', task.toMap());
    print('DEBUG: Task "${task.title}" added to database with result: $insertResult');
    await loadTasks();  // Muat ulang data setelah menambah task baru
    return insertResult;
  }
}


  // Load all tasks from the database
  Future<void> loadTasks() async {
    var dbClient = await db;
    List<Map<String, dynamic>> queryResult = await dbClient!.query('tasks');
    tasks.assignAll(queryResult.map((data) => TaskModel.fromMap(data)).toList());
  }

  // Filter saved tasks
  List<TaskModel> getSavedTasks() {
    return tasks.where((task) => task.isCompleted).toList();
  }

  // Delete a task from the database
  Future<void> deleteTask(int id) async {
    var dbClient = await db;
    await dbClient!.delete('tasks', where: 'id = ?', whereArgs: [id]);
    loadTasks(); // Reload tasks after deletion
  }
}
