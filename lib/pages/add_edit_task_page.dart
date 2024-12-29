import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/task_controller.dart';
import 'package:task_manager/models/task_model.dart';

class AddTaskBottomSheet extends StatelessWidget {
  final int? id;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final TaskController taskController = Get.find();

  AddTaskBottomSheet({super.key, this.id}) {
    if (id != null) {
      final taskIndex =
          taskController.tasks.indexWhere((task) => task.id == id);
      if (taskIndex != -1) {
        final task = taskController.tasks[taskIndex];
        titleController.text = task.title;
        descriptionController.text = task.description;
        taskController.selectedPriority.value = task.priority;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Add Task',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 70.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: Theme.of(context).textTheme.bodyLarge),
                ),
                50.verticalSpace,
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: Theme.of(context).textTheme.bodyLarge),
                ),
                80.verticalSpace,
                Obx(() {
                  return DropdownButtonFormField<String>(
                    value: taskController.selectedPriority.value,
                    items: taskController.availablePriorities.map((priority) {
                      return DropdownMenuItem(
                        value: priority,
                        child: Text(priority),
                      );
                    }).toList(),
                    onChanged: (value) {
                      taskController.selectedPriority.value = value!;
                    },
                    decoration: InputDecoration(
                        labelText: 'Priority',
                        labelStyle: Theme.of(context).textTheme.bodyLarge),
                  );
                }),
                150.verticalSpace,
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      final title = titleController.text.trim();
                      final description = descriptionController.text.trim();
                      final priority = taskController.selectedPriority.value;
                      if (title.isEmpty || description.isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Title and Description cannot be empty.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return;
                      }
                      final task = TaskModel(
                        id: id,
                        title: title,
                        description: description,
                        priority: priority,
                        date: DateTime.now().toIso8601String(),
                        completed: 0,
                      );

                      if (id == null) {
                        taskController.addTask(task.toMap());
                      } else {
                        taskController.updateTask(id!, task.toMap());
                      }
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
                      alignment: Alignment.center,
                      child: Text(
                        id == null ? 'Add Task' : 'Update Task',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
