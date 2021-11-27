import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_todo_list/data/models/todo.dart';
import 'package:meta/meta.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(Todos()) {
    on<TodosEvent>((event, emit) {
      if (event is TodoAdded) {
        emit(Todos());
      }
    });
  }
}
