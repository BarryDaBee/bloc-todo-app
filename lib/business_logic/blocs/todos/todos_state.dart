part of 'todos_bloc.dart';

@immutable
abstract class TodosState {}

class Todos extends TodosState {
  final List<Todo> todos;

  Todos({this.todos = const []});
}
