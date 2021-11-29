import 'dart:async';
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
  DateTime _dateTime = DateTime.now();
  late final Timer timer;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(days: 1), (timer) {
      setState(() {
        _dateTime = DateTime.now();
      });
    });
    super.initState();
  }

  String getCurrentDate() {
    int dayIndex = _dateTime.day;
    int monthIndex = _dateTime.month;
    int year = _dateTime.year;

    List<String> months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return "${months[monthIndex - 1]} $dayIndex, $year";
  }

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
            marginY(56),
            Text(
              getCurrentDate(),
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
            marginY(15),
            const Divider(
              height: 4,
              thickness: 1,
            ),
            marginY(15),
            BlocBuilder<TodoCubit, TaskListState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Text("All",
                            style: Theme.of(context).textTheme.headline3),
                      ],
                    ),
                    marginY(20),
                    if (state.todos.isEmpty)
                      Text(
                        "Click \"+\" to add a new task",
                        style: Theme.of(context).textTheme.headline3,
                      )
                    else
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
                          background: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.delete, color: Colors.white),
                                marginX(20),
                                Text(
                                  "Delete",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                        color: Colors.white,
                                        fontSize: 24,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          secondaryBackground: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Delete",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                        color: Colors.white,
                                        fontSize: 24,
                                      ),
                                ),
                                marginX(20),
                                const Icon(Icons.delete, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.purple,
        child: const Icon(Icons.add, size: 25),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) {
                return BlocProvider.value(
                  value: context.read<TodoCubit>(),
                  child: BottomSheet(
                    backgroundColor: Colors.white,
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

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
