part of 'todo_cubit.dart';

@immutable
abstract class TaskListState {
  final List<Todo> todos;

  const TaskListState(this.todos);

  int get noOfCompletedTasks {
    var number = 0;
    for (var element in todos) {
      if (element.isDone) number++;
    }
    return number;
  }
}

class TaskInitialState extends TaskListState {
  TaskInitialState() : super([]);
}

class NewTaskAddedState extends TaskListState {
  final List<Todo> todos;

  const NewTaskAddedState([this.todos = const []]) : super(todos);
}

class TaskRemovedState extends TaskListState {
  final List<Todo> todos;
  final Todo removedTask;
  const TaskRemovedState(this.todos, this.removedTask) : super(todos);
}

class TaskUpdatedState extends TaskListState {
  final List<Todo> todos;
  final Todo updatedTask;
  const TaskUpdatedState(this.todos, this.updatedTask) : super(todos);
}
