class Todo {
  bool isDone;
  String subject;

  Todo({
    this.isDone = false,
    this.subject = "random todo",
  });

  void toggleDone() => isDone = !isDone;

  @override
  String toString() {
    return "(subject: $subject, isDone: $isDone)";
    super.toString();
  }
}
