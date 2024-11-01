import 'package:e_learning/model/task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  static Database? _db;
  var tasks = <TaskModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks(); 
  }

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

  Future<void> loadTasks() async {
    var dbClient = await db;
    List<Map<String, dynamic>> queryResult = await dbClient!.query('tasks');
    tasks
        .assignAll(queryResult.map((data) => TaskModel.fromMap(data)).toList());
  }

  Future<TaskModel?> getTaskByTitle(String title) async {
    var dbClient = await db;

    if (dbClient == null) {
      return null;
    }

    List<Map<String, dynamic>> queryResult = await dbClient!.query(
      'tasks',
      where: 'title = ?',
      whereArgs: [title],
    );

    if (queryResult.isNotEmpty) {
      return TaskModel.fromMap(queryResult.first);
    } else {
      return null;
    }
  }

  Future<void> updateTaskStatus(int id, int isCompleted) async {
    var dbClient = await db;
    await dbClient!.update(
      'tasks',
      {'isCompleted': isCompleted},
      where: 'id = ?',
      whereArgs: [id],
    );
    loadTasks();
  }

  Future<int> addTask(TaskModel task) async {
    var dbClient = await db;

    TaskModel? existingTask = await getTaskByTitle(task.title);

    if (existingTask != null) {
      int updateResult = await dbClient!.update(
        'tasks',
        {'isCompleted': task.isCompleted ? 1 : 0},
        where: 'id = ?',
        whereArgs: [existingTask.id],
      );
      await loadTasks();
      return updateResult;
    } else {
      int insertResult = await dbClient!.insert('tasks', task.toMap());
      await loadTasks();
      return insertResult;
    }
  }

  List<TaskModel> getSavedTasks() {
    return tasks.where((task) => task.isCompleted).toList();
  }

  Future<void> deleteTask(int id) async {
    var dbClient = await db;
    await dbClient!.delete('tasks', where: 'id = ?', whereArgs: [id]);
    loadTasks();
  }
}
