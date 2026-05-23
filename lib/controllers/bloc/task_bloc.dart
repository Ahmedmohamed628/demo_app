import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../models/task_model.dart';

part 'task_event.dart';

part 'task_state.dart';

//todo: with function method

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<AddTaskEvent>(_addTask);

    on<RemoveTaskEvent>(_removeTask);

    on<ToggleTaskEvent>(_toggleTask);
  }

  FutureOr<void> _addTask(AddTaskEvent event, Emitter<TaskState> emit) {
    final task = TaskModel(
      id: const Uuid().v4(),
      title: event.title,
      isCompleted: false,
    );
    //spread operator for creating new list (new instance)
    emit(UpdateTask([...state.tasksList, task]));
  }

  FutureOr<void> _removeTask(RemoveTaskEvent event, Emitter<TaskState> emit) {
    final List<TaskModel> newList =
        state.tasksList.where((task) => task.id != event.id).toList();
    emit(UpdateTask(newList));
  }

  FutureOr<void> _toggleTask(ToggleTaskEvent event, Emitter<TaskState> emit) {
    final List<TaskModel> newList =
        state.tasksList.map((task) {
          return task.id == event.id ? task.copyWith(
              isCompleted: !task.isCompleted) : task;
        }).toList();
    emit(UpdateTask(newList));
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    try {
      final List<dynamic> taskList = json['taskList'];
      final List<TaskModel> tasks = taskList.map((e) => TaskModel.fromJson(e))
          .toList();
      return UpdateTask(tasks);
    } catch (e) {
      return null;
    }

    // return UpdateTask((json['taskList'] as List<dynamic>).map((e) => TaskModel.fromJson(e)).toList());
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return {
      'taskList': state.tasksList.map((task) => task.toJson(),).toList()
    };
  }
}

//todo: with constructor method
//import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:uuid/uuid.dart';
//
// import '../../models/task_model.dart';
//
// part 'task_event.dart';
// part 'task_state.dart';
//
// class TaskBloc extends Bloc<TaskEvent, TaskState> {
//   TaskBloc() : super(TaskInitial()) {
//     on<AddTaskEvent>((event, emit) {
//       final task = TaskModel(id: const Uuid().v4(), title: event.title, isCompleted: false,);
//       //spread operator for creating new list (new instance)
//       emit(UpdateTask([...state.tasksList, task]));
//     });
//
//     on<RemoveTaskEvent>((event, emit) {
//       final List<TaskModel> newList = state.tasksList.where((task) => task.id != event.id).toList();
//       emit(UpdateTask(newList));
//     });
//
//     on<ToggleTaskEvent>((event, emit) {
//       final List<TaskModel> newList = state.tasksList.map((task) {
//         return task.id == event.id ? task.copyWith(isCompleted: !task.isCompleted) : task;
//       }).toList();
//       emit(UpdateTask(newList));
//     });
//   }
// }
