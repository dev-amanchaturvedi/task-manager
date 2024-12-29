import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/utils/constants.dart';
import 'package:task_manager/utils/database_helper.dart';

class TaskController extends GetxController {
  RxList<TaskModel> tasks = <TaskModel>[].obs;
  late Database database;
  RxList<String> availablePriorities = ['Low', 'Medium', 'High'].obs;
  RxString selectedPriority = 'Low'.obs;
  RxList<String> availablePrioritiesFilter =
      ['All', 'Low', 'Medium', 'High'].obs;
  RxString selectedPriorityFilter = 'All'.obs;
  RxList<String> availableDateFilter = ['Default', 'Latest', 'Oldest'].obs;
  RxString selectedDateFilter = 'Default'.obs;
  RxList<String> availableStatusFilter = ['All', 'Completed', 'Pending'].obs;
  RxString selectedStatusFilter = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    // initDatabase();
  }

  Future<void> initDatabase() async {
    database = await DatabaseHelper().database;
    loadTasks(getAllDataQuery);
  }

  Future<void> loadTasks(String query) async {
    final List<Map<String, dynamic>> loadedTasks =
        await database.rawQuery(query);
    final List<TaskModel> allTasks =
        loadedTasks.map((map) => TaskModel.fromMap(map)).toList();
    tasks.assignAll(allTasks);
  }

  Future<void> addTask(Map<String, dynamic> task) async {
    await database.insert('tasks', task);
    loadTasks('SELECT * FROM tasks');
  }

  Future<void> updateTask(int id, Map<String, dynamic> updates) async {
    await database.update('tasks', updates, where: 'id = ?', whereArgs: [id]);
    loadTasks(getAllDataQuery);
  }

  Future<void> deleteTask(int id) async {
    await database.delete('tasks', where: 'id = ?', whereArgs: [id]);
    loadTasks(getAllDataQuery);
  }

  Future<void> generateFilterQuery() async {
    String query = "SELECT * FROM tasks WHERE 1=1";

    if (selectedPriorityFilter.value != 'All') {
      query += " AND priority = '${selectedPriorityFilter.value}'";
    }

    if (selectedStatusFilter.value != 'All') {
      final statusValue = selectedStatusFilter.value == 'Completed' ? 1 : 0;
      query += " AND completed = $statusValue";
    }

    if (selectedDateFilter.value == 'Oldest' ||
        selectedDateFilter.value == 'Default') {
      query += " ORDER BY date ASC";
    } else if (selectedDateFilter.value == 'Latest') {
      query += " ORDER BY date DESC";
    }

    query += ", completed DESC";
    await loadTasks(query);
  }
}
