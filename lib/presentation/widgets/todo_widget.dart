import 'package:bloc_todo_list/data/models/todo.dart';
import 'package:bloc_todo_list/presentation/shared/spacer.dart';
import 'package:flutter/material.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({Key? key, required this.todo, this.onChanged})
      : super(key: key);
  final Todo todo;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          //fillColor: const Color(0xFF2B2D37),
          focusColor: const Color(0xFF2B2D37),
          activeColor: const Color(0xFF2B2D37),

          value: todo.isDone,
          onChanged: (value) {
            onChanged?.call(value!);
          },
        ),
        marginX(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Upload 1099-R to Turbo Tax",
              style: Theme.of(context).textTheme.headline4,
            ),
            marginY(5),
            Text(
              "Finance",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        )
      ],
    );
  }
}
