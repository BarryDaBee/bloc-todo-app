import 'package:bloc/bloc.dart';
import 'package:bloc_todo_list/data/models/todo.dart';
import 'package:meta/meta.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(const TodoState([]));

  addTodo(Todo todo) {
    List<Todo> newTodos = List.from(state.todos);
    newTodos.add(todo);
    emit(
      TodoState(
        newTodos,
      ),
    );
  }

  toggleDone(int index) {
    state.todos[index].toggleDone();
    emit(TodoState(state.todos));
  }
}
