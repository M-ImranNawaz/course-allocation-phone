class Course {
  int id;
  String name;
  String code;
  String department;
  String program;
  String creditHours;
  String semester;
  Course({
    required this.id,
    required this.name,
    required this.code,
    required this.department,
    required this.program,
    required this.creditHours,
    required this.semester,
  });

  static Course fromJson(json) => Course(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      department: json['department'],
      program: json['program'],
      creditHours: json['creditHours'],
      semester: json['semester']);
}
