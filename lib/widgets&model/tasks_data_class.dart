class TaskData {
  String id;
  String task;
  String description;
  bool isDone;
  DateTime selectedtime;

  TaskData(
      {required this.id,
      required this.task,
      required this.description,
      required this.isDone,
      required this.selectedtime});
}
