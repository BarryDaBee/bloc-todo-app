import 'package:bloc_todo_list/business_logic/cubits/todo_cubit.dart';
import 'package:bloc_todo_list/data/models/todo.dart';
import 'package:bloc_todo_list/presentation/shared/spacer.dart';
import 'package:bloc_todo_list/presentation/widgets/todo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoView extends StatelessWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 17),
        children: [
          marginY(76),
          Text(
            "March 9, 2020",
            style: Theme.of(context).textTheme.headline1,
          ),
          marginY(10),
          Text(
            "5 incomplete, 5 completed",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          marginY(34),
          BlocBuilder<TodoCubit, TodoState>(
            builder: (context, state) {
              return Column(
                children: [
                  Row(
                    children: [
                      Text("Incomplete",
                          style: Theme.of(context).textTheme.headline3),
                    ],
                  ),
                  marginY(20),
                  ...List.generate(
                    state.todos.length,
                    (index) => TodoWidget(
                      todo: state.todos[index],
                      onChanged: (_) {
                        context.read<TodoCubit>().toggleDone(index);
                      },
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF515CC6),
        child: const Icon(Icons.add),
        onPressed: () {
          context.read<TodoCubit>().addTodo(Todo());
        },
      ),
    );
  }
}
