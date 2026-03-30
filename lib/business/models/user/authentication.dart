class Authentication {
  String username;
  String password;
  String role;
  String institution;

  Authentication({
    required this.username,
    required this.password,
    required this.role,
    required this.institution,
  });

  factory Authentication.fromJson(Map<String, dynamic> json) => Authentication(
    username: json['username'],
    password: json['password'],
    role: json['role'],
    institution: json['institution'],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "role": role,
    "institution": institution,
  };
}
