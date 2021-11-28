import 'package:bloc/bloc.dart';
import 'package:bloc_todo_list/data/models/todo.dart';
import 'package:meta/meta.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TaskListState> {
  TodoCubit() : super(TaskInitialState());

  addTask(Todo todo) {
    List<Todo> newTodos = List.from(state.todos);
    newTodos.add(todo);
    emit(
      NewTaskAddedState(
        newTodos,
      ),
    );
  }

  removeTask(int index) {
    List<Todo> newTodos = List.from(state.todos);
    newTodos.removeAt(index);
    emit(TaskRemovedState(newTodos, state.todos[index]));
  }

  toggleDone(int index) {
    state.todos[index].toggleDone();
    emit(TaskUpdatedState(state.todos, state.todos[index]));
  }
}
