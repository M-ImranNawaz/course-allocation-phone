import 'dart:convert';

class PrefCourse {
  int facultyId;
  String pref_1;
  String pref_2;
  String pref_3;
  String pref_4;

  PrefCourse({
    required this.facultyId,
    required this.pref_1,
    required this.pref_2,
    required this.pref_3,
    required this.pref_4,
  });

  Map<String, dynamic> toMap() {
    return {
      'facultyId': facultyId,
      'pref_1': pref_1,
      'pref_2': pref_2,
      'pref_3': pref_3,
      'pref_4': pref_4,
    };
  }

  factory PrefCourse.fromMap(Map<String, dynamic> map) {
    return PrefCourse(
      facultyId: map['facultyId']?.toInt() ?? 0,
      pref_1: map['pref_1'] ?? '',
      pref_2: map['pref_2'] ?? '',
      pref_3: map['pref_3'] ?? '',
      pref_4: map['pref_4'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PrefCourse.fromJson(String source) => PrefCourse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PrefCourse(facultyId: $facultyId, pref_1: $pref_1, pref_2: $pref_2, pref_3: $pref_3, pref_4: $pref_4)';
  }

}
