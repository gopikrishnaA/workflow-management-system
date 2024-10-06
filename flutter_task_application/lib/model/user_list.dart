class User {
  final int id;
  final String name;
  final String username;
  final String email;

  const User(
      {required this.id,
      required this.name,
      required this.username,
      required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
    );
  }
}

class Userlist {
  final List<User> users;

  const Userlist({
    required this.users,
  });

  factory Userlist.fromJson(Map<String, dynamic> json) {
    return Userlist(
      // Parse each entry in the users list as an userList object
      users: (json['userList'] as List<dynamic>)
          .map((auth) => User.fromJson(auth as Map<String, dynamic>))
          .toList(),
    );
  }
}
