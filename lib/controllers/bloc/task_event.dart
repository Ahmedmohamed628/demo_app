part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final String title;

  AddTaskEvent({required this.title});
}

class RemoveTaskEvent extends TaskEvent {
  final String id;

  RemoveTaskEvent({required this.id});
}

class ToggleTaskEvent extends TaskEvent {
  final String id;

  ToggleTaskEvent({required this.id});
}
