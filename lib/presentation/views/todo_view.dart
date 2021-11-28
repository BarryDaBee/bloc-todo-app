import 'package:bloc_todo_list/business_logic/cubits/todo_cubit.dart';
import 'package:bloc_todo_list/data/models/todo.dart';
import 'package:bloc_todo_list/presentation/shared/colors.dart';
import 'package:bloc_todo_list/presentation/shared/spacer.dart';
import 'package:bloc_todo_list/presentation/widgets/todo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoView extends StatefulWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  final TextEditingController _taskTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<TodoCubit, TaskListState>(
        listener: (context, state) {
          if (state is TaskRemovedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text("Task \"${state.removedTask.subject}\" removed"),
                duration: const Duration(milliseconds: 500),
              ),
            );
          } else if (state is NewTaskAddedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: AppColors.purple,
                content: Text("Task added successfully"),
                duration: Duration(milliseconds: 500),
              ),
            );
          }
          // else if(state is TaskUpdatedState){
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       backgroundColor: AppColors.purple,
          //       content: Text("Task state changed"),
          //       duration: Duration(milliseconds: 500),
          //     ),
          //   );
          // }
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          children: [
            marginY(76),
            Text(
              "Nov 28, 2021",
              style: Theme.of(context).textTheme.headline1,
            ),
            marginY(10),
            BlocBuilder<TodoCubit, TaskListState>(
              builder: (context, state) {
                return Text(
                  " ${state.todos.length - state.noOfCompletedTasks} incomplete, ${state.noOfCompletedTasks} completed",
                  style: Theme.of(context).textTheme.subtitle1,
                );
              },
            ),
            marginY(34),
            BlocBuilder<TodoCubit, TaskListState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Text("All tasks",
                            style: Theme.of(context).textTheme.headline3),
                      ],
                    ),
                    marginY(20),
                    ...List.generate(
                      state.todos.length,
                      (index) => Dismissible(
                        key: UniqueKey(),
                        child: TodoWidget(
                          todo: state.todos[index],
                          onChanged: (_) {
                            context.read<TodoCubit>().toggleDone(index);
                          },
                        ),
                        onDismissed: (_) {
                          context.read<TodoCubit>().removeTask(index);
                        },
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.purple,
        child: Icon(Icons.add, size: 25),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) {
                return BlocProvider.value(
                  value: context.read<TodoCubit>(),
                  child: BottomSheet(
                    builder: (_) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            marginY(20),
                            Row(
                              children: [
                                const Icon(
                                  Icons.add_circle,
                                  color: AppColors.purple,
                                ),
                                marginX(20),
                                Text(
                                  "Add a new Task",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                        fontSize: 24,
                                      ),
                                ),
                              ],
                            ),
                            marginY(20),
                            TextField(
                              controller: _taskTextController,
                              style: Theme.of(context).textTheme.headline3,
                              decoration: const InputDecoration(
                                labelText: "Task description",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            marginY(20),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom +
                                          10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: AppColors.purple,
                                  fixedSize: const Size.fromHeight(40),
                                ),
                                onPressed: () {
                                  if (_taskTextController
                                      .value.text.isNotEmpty) {
                                    Todo newTodo = Todo(
                                        subject:
                                            _taskTextController.value.text);
                                    context.read<TodoCubit>().addTask(newTodo);
                                    _taskTextController.clear();
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text(
                                  "Done!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    onClosing: () {},
                  ),
                );
              });
        },
      ),
    );
  }
}
