import 'package:course_allocation_phone/contstants.dart';
import 'package:course_allocation_phone/main.dart';
import 'package:get/get.dart';
import 'base_controller.dart';
import '../services/base_client.dart';

class ACController extends GetxController with BaseController {
  Map aCourses = {};
  List courses = [];
  getData() async {
    BaseClient baseClient = BaseClient();
    var response = await baseClient.post(kBaseUrl, 'getacbyid',
        {"faculty": facultyName.toString()}).catchError(handleError);
    if (response == null) return [];
    aCourses = response;
    print('name is: $facultyName');
    extractCourses();
  }

  extractCourses() {
    String course = aCourses['Allocated Courses']['courses'].toString();
    course = course.substring(1, course.length - 1);
    courses = course.split(',');
  }
}
