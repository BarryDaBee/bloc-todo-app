class Todo {
  bool isDone;
  String subject;
  String category;

  Todo(
      {this.isDone = false,
      this.subject = "random todo",
      this.category = "Unknown"});

  void toggleDone() => isDone = !isDone;
}
