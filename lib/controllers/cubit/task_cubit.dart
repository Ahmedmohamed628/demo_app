import 'package:demo_project/models/task_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'task_state.dart';

class TaskCubit extends HydratedCubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  //1st function
  addTask({required String title}) {
    final task = TaskModel(
      id: const Uuid().v4(),
      title: title,
      isCompleted: false,
    );
    //spread operator for creating new list (new instance)
    emit(UpdateTask([...state.tasksList, task]));
  }

  //2nd function
  removeTask(String id) {
    final List<TaskModel> newList =
        state.tasksList.where((task) => task.id != id).toList();
    emit(UpdateTask(newList));
  }

  //3rd function
  toggleTask(String id) {
    final List<TaskModel> newList =
        state.tasksList.map((task) {
          return task.id == id
              ? task.copyWith(isCompleted: !task.isCompleted)
              : task;
        }).toList();

    emit(UpdateTask(newList));
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    try {
      final List<dynamic> taskList = json['taskList'];
      final List<TaskModel> task = taskList.map((e) => TaskModel.fromJson(e))
          .toList();
      return UpdateTask(task);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return {
      'taskList': state.tasksList.map((task) => task.toJson()).toList(),
    };
  }
}
