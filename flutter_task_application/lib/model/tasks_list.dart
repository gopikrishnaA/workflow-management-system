class Task {
  final int id;
  final String name;
  final String description;
  final int managerId;
  final String startTime;
  final String deadline;
  final String? status;
  final List<dynamic>? users;

  const Task(
      {required this.id,
      required this.name,
      required this.description,
      required this.managerId,
      required this.startTime,
      required this.deadline,
      this.users,
      this.status});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'] as int,
        name: json['name'] as String,
        description: json['description'] as String,
        managerId: json['managerId'] as int,
        startTime: json['startTime'] as String,
        deadline: json['deadline'] as String,
        status: json['status'] as String,
        users: json['users']);
  }
}

class TasksList {
  final List<Task> taskList;

  const TasksList({
    required this.taskList,
  });

  factory TasksList.fromJson(Map<String, dynamic> json) {
    return TasksList(
      // Parse each entry in the users list as an userList object
      taskList: (json['taskList'] as List<dynamic>)
          .map((item) => Task.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
