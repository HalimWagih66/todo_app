import 'package:flutter/material.dart';
import 'package:todo_app/database/models/task.dart';

class TaskProvider extends ChangeNotifier{
  late Task task;

  void changeTask(Task task){
    this.task = task;
  }
}