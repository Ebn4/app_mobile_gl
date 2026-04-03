class Authentication {
  String email;
  String password;
  String role;
  String institution;

  Authentication({
    required this.email,
    required this.password,
    required this.role,
    required this.institution,
  });

  factory Authentication.fromJson(Map<String, dynamic> json) => Authentication(
    email: json['email'],
    password: json['password'],
    role: json['role'],
    institution: json['institution'],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "role": role,
    "institution": institution,
  };
}
