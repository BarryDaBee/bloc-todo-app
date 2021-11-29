import 'package:bloc/bloc.dart';
import 'package:bloc_todo_list/data/models/todo.dart';
import 'package:meta/meta.dart';

part 'todo_state.dart';

// class TodoBlocObserver extends BlocObserver {
//   @override
//   void onEvent(Bloc bloc, Object? event) {
//     super.onEvent(bloc, event);
//     print('${bloc.runtimeType} $event');
//   }
//
//   @override
//   void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
//     print('${bloc.runtimeType} $error $stackTrace');
//     super.onError(bloc, error, stackTrace);
//   }
//
//   @override
//   void onChange(BlocBase bloc, Change change) {
//     super.onChange(bloc, change);
//     print('${bloc.runtimeType} $change');
//   }
//
//   @override
//   void onTransition(Bloc bloc, Transition transition) {
//     super.onTransition(bloc, transition);
//     print('${bloc.runtimeType} $transition');
//   }
// }

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
