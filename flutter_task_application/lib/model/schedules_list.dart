class Schedules {
  final int id;
  final String name;
  final String description;
  final int admin;
  final String startTime;
  final String endTime;
  final List<dynamic>? users;

  const Schedules(
      {required this.id,
      required this.name,
      required this.description,
      required this.admin,
      required this.startTime,
      required this.endTime,
      this.users});

  factory Schedules.fromJson(Map<String, dynamic> json) {
    return Schedules(
        id: json['id'] as int,
        name: json['name'] as String,
        description: json['description'] as String,
        admin: json['admin'] as int,
        startTime: json['startTime'] as String,
        endTime: json['endTime'] as String,
        users: json['users']);
  }
}

// Model for Userlist
class SchedulesList {
  final List<Schedules> programs;

  const SchedulesList({
    required this.programs,
  });

  // Factory constructor to create Userlist from JSON
  factory SchedulesList.fromJson(Map<String, dynamic> json) {
    return SchedulesList(
      // Parse each entry in the users list as an userList object
      programs: (json['programList'] as List<dynamic>)
          .map((item) => Schedules.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
