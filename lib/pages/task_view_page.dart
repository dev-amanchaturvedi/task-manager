import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_manager/models/task_model.dart';

class TaskDetailPage extends StatelessWidget {
  final TaskModel task;

  const TaskDetailPage({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Task Details',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(task.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
              Center(
                child: SizedBox(
                  width: 800.w,
                  child: const Divider(
                    color: Colors.grey,
                  ),
                ),
              ),
              50.verticalSpace,
              Row(
                children: [
                  Text('Description:',
                      style: Theme.of(context).textTheme.bodySmall),
                  40.horizontalSpace,
                  Expanded(
                    child: Text(task.description,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ],
              ),
              50.verticalSpace,
              Row(children: [
                Text('Priority:', style: Theme.of(context).textTheme.bodySmall),
                150.horizontalSpace,
                Text(
                  task.priority,
                  style: TextStyle(
                    fontSize: 18,
                    color: task.priority == 'High'
                        ? Colors.red
                        : task.priority == 'Medium'
                            ? Colors.orange
                            : Colors.green,
                  ),
                ),
              ]),
              50.verticalSpace,
              Row(
                children: [
                  Text('Date:', style: Theme.of(context).textTheme.bodySmall),
                  220.horizontalSpace,
                  Text(task.date.split('T').first,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              50.verticalSpace,
              Row(
                children: [
                  Text('Time:', style: Theme.of(context).textTheme.bodySmall),
                  220.horizontalSpace,
                  Text(task.date.split('T').last.split('.').first,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              50.verticalSpace,
              Row(
                children: [
                  Text('Completed:',
                      style: Theme.of(context).textTheme.bodySmall),
                  50.horizontalSpace,
                  Icon(
                    task.completed == 1 ? Icons.check_circle : Icons.cancel,
                    color: task.completed == 1 ? Colors.green : Colors.red,
                    size: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
