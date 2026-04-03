class User {
  int? id_admin;
  String? username;
  String? email;
  String? token;
  String? fullname;
  String? role;
  String? institution;

  User({
    this.id_admin,
    this.username,
    this.email,
    this.token,
    this.role,
    this.fullname,
    this.institution,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id_admin: json['id_admin'],
    username: json['username'],
    email: json['email'],
    token: json['token'],
    role: json['role'],
    fullname: json['fullname'],
    institution: json['institution'],
  );

  Map<String, dynamic> toJson() => {
    'id_admin': id_admin,
    'username': username,
    'email': email,
    'token': token,
    'role': role,
    'fullname': fullname,
    'institution': institution,
  };
}
