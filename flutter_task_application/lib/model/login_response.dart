class Authorities {
  final String authority;

  const Authorities({required this.authority});

  factory Authorities.fromJson(Map<String, dynamic> json) {
    return Authorities(authority: json['authority'] as String);
  }
}

class LoginResponse {
  final String accessToken;
  final String username;
  final String email;
  final int id;
  final List<Authorities> authorities;

  const LoginResponse({
    required this.accessToken,
    required this.username,
    required this.id,
    required this.authorities,
    required this.email,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['accessToken'] as String,
      username: json['username'] as String,
      id: json['id'] as int,
      email: json['email'] as String,
      // Parse each entry in the authorities list as an Authorities object
      authorities: (json['authorities'] as List<dynamic>)
          .map((auth) => Authorities.fromJson(auth as Map<String, dynamic>))
          .toList(),
    );
  }
}
