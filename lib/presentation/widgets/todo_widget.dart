import 'package:bloc_todo_list/data/models/todo.dart';
import 'package:bloc_todo_list/presentation/shared/colors.dart';
import 'package:bloc_todo_list/presentation/shared/spacer.dart';
import 'package:flutter/material.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({Key? key, required this.todo, this.onChanged})
      : super(key: key);
  final Todo todo;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Theme(
            data: ThemeData(unselectedWidgetColor: AppColors.purple),
            child: SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                activeColor: Colors.green,
                value: todo.isDone,
                onChanged: (value) {
                  onChanged?.call(value!);
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
          marginX(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                todo.subject,
                style: Theme.of(context).textTheme.headline4,
              ),
              marginY(5),
              Text(
                todo.isDone ? "Completed" : "Pending",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: todo.isDone ? Colors.green : AppColors.purple,
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
