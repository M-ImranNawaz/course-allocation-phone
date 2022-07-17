class Faculty {
  int id;
  String name;
  String email;
  String password;
  Faculty({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  static Faculty fromJson(json) => Faculty(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password']
      );
}
