import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/task_controller.dart';
import 'package:task_manager/pages/task_view_page.dart';
import 'add_edit_task_page.dart';
import 'settings_page.dart';

class TaskHomePage extends StatelessWidget {
  final TaskController taskController = Get.find();

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
            child: SizedBox(
              height: 1000.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Filter Tasks',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Priority: '),
                      Obx(
                        () => Container(
                          height: 100.h,
                          width: 400.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                          ),
                          child: Center(
                            child: DropdownButton<String>(
                              alignment: Alignment.center,
                              underline: Container(),
                              value:
                                  taskController.selectedPriorityFilter.value,
                              items: taskController.availablePrioritiesFilter
                                  .map((priority) {
                                return DropdownMenuItem(
                                  value: priority,
                                  child: Text(priority),
                                );
                              }).toList(),
                              onChanged: (value) {
                                taskController.selectedPriorityFilter.value =
                                    value!;
                              },
                              iconDisabledColor: Theme.of(context).primaryColor,
                              iconEnabledColor: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Date: '),
                      Obx(
                        () => Container(
                          height: 100.h,
                          width: 400.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                          ),
                          child: Center(
                            child: DropdownButton<String>(
                              underline: Container(),
                              value: taskController.selectedDateFilter.value,
                              items: taskController.availableDateFilter
                                  .map((date) {
                                return DropdownMenuItem(
                                  alignment: Alignment.center,
                                  value: date,
                                  child: Text(date),
                                );
                              }).toList(),
                              onChanged: (value) {
                                taskController.selectedDateFilter.value =
                                    value!;
                              },
                              iconDisabledColor: Theme.of(context).primaryColor,
                              iconEnabledColor: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Status: '),
                      Obx(
                        () => Container(
                          height: 100.h,
                          width: 400.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.r),
                              border: Border.all(
                                  color: Theme.of(context).primaryColor)),
                          child: Center(
                            child: DropdownButton<String>(
                              alignment: Alignment.center,
                              underline: Container(),
                              value: taskController.selectedStatusFilter.value,
                              items: taskController.availableStatusFilter
                                  .map((status) {
                                return DropdownMenuItem(
                                  value: status,
                                  child: Text(status),
                                );
                              }).toList(),
                              onChanged: (value) {
                                taskController.selectedStatusFilter.value =
                                    value!;
                              },
                              iconDisabledColor: Theme.of(context).primaryColor,
                              iconEnabledColor: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      taskController
                          .generateFilterQuery(); // Apply the filters.
                      Get.back();
                    },
                    child: Container(
                      height: 180.h,
                      width: 480.w,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6.0, // Shadow blur
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      alignment: Alignment.center, // Center the text
                      child: const Text(
                        'Apply Filters',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task Manager',
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.filter_alt_sharp,
            ),
            onPressed: () {
              _showFilterDialog(context);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
            ),
            onPressed: () {
              Get.to(
                () => SettingsPage(),
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        final tasks = taskController.tasks;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: tasks.isEmpty
                  ? Center(
                      child: Text('No Tasks!',
                          style: Theme.of(context).textTheme.bodyLarge),
                    )
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return Dismissible(
                          key: Key(task.id.toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(),
                          secondaryBackground: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 100.w),
                            color: Colors.red,
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                          onDismissed: (direction) {
                            taskController.deleteTask(task.id!);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Task deleted!')),
                            );
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 50.w, vertical: 30.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.r),
                            ),
                            elevation: 4,
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 50.w, vertical: 25.h),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TaskDetailPage(task: task),
                                  ),
                                );
                              },
                              title: Text(task.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  20.verticalSpace,
                                  Text(
                                    '${task.priority} Priority',
                                    style: TextStyle(
                                        color: task.priority == 'High'
                                            ? Colors.red
                                            : task.priority == 'Low'
                                                ? Colors.green
                                                : Colors.orange,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 55.sp),
                                  ),
                                  Text(
                                    'Date: ${task.date.toString().split('T').first}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  Text(
                                    'Time: ${task.date.toString().split('T').last.split('.').first}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      Get.to(
                                        () => AddTaskBottomSheet(id: task.id!),
                                      );
                                    },
                                  ),
                                  Checkbox(
                                    value: task.completed == 1,
                                    checkColor: Colors.white,
                                    activeColor: Colors.deepPurple,
                                    onChanged: (value) {
                                      taskController.updateTask(
                                        task.id!,
                                        {'completed': value! ? 1 : 0},
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => AddTaskBottomSheet());
        },
        label: const Text(
          'Add Task',
        ),
        icon: const Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
