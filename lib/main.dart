import 'package:bloc_todo_list/business_logic/cubits/todo_cubit.dart';
import 'package:bloc_todo_list/presentation/shared/theme.dart';
import 'package:bloc_todo_list/presentation/views/todo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF141419),
        textTheme: darkTextTheme,
      ),
      theme: ThemeData(
        textTheme: lightTextTheme,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => TodoCubit(),
        child: const TodoView(),
      ),
    );
  }
}
