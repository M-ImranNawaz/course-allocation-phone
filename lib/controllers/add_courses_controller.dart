import 'package:course_allocation_phone/controllers/base_controller.dart';
import 'package:course_allocation_phone/helper/dialog_helper.dart';
import 'package:course_allocation_phone/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../contstants.dart';
import '../models/course.dart';
import '../services/base_client.dart';

class AddCoursesController extends GetxController with BaseController {
  List<Course> coursesList = [];
  TextEditingController queryC = TextEditingController();
  var sCount = 0.obs;
  int count = 4;
  List selectedCourses = [].obs;
  var showSearchField = false.obs;
  List searchedList = [].obs;
  var showSend = false.obs;

  filterData(value) {
    searchedList = coursesList.where((element) {
      return element.name
          .toString()
          .toLowerCase()
          .contains(value.toString().toLowerCase());
    }).toList();
  }

  sendPrefCourses() async {
    var jsonData = {
      "faculty_id": facultyId.toString(),
      "pref_1": selectedCourses.elementAt(0).id.toString(),
      "pref_2": selectedCourses.elementAt(1).id.toString(),
      "pref_3": selectedCourses.elementAt(2).id.toString(),
      "pref_4": selectedCourses.elementAt(3).id.toString(),
    };

    showLoading();
    BaseClient baseClient = BaseClient();
    var response = await baseClient
        .post(kBaseUrl, 'addpreferences', jsonData)
        .catchError(handleError);
    hideLoading();

    if (response['message']
        .toString()
        .contains('Your Preferences Already Exists')) {
      DialogHelper.showErrorDialog(
          description: 'Your Preferences Are Already Exists');
    } else {
      DialogHelper.showErrorDialog(
          title: 'Success', description: 'Data Sent Successfully');
    }
    if (response == null) return [];
    //print(response);
  }

  getData() async {
    BaseClient baseClient = BaseClient();
    var response =
        await baseClient.get(kBaseUrl, 'courses').catchError(handleError);
    if (response == null) return [];
    searchedList = coursesList;
    return response.map<Course>(Course.fromJson).toList();
  }

  void addCourses(course) {
    if (selectedCourses.isNotEmpty) {
      showSend.value = true;
    }
    if (selectedCourses.length < 4) {
      for (var element in selectedCourses) {
        if (element.code == course.code) {
          DialogHelper.showErrorDialog(description: "Course is already Exist");
          return;
        }
      }
      selectedCourses.insert(0, course);
    } else {
      DialogHelper.showErrorDialog(description: "You can add only 4 courses");
    }
  }

  void removeSelectedCourses(index) {
    selectedCourses.removeAt(index);
    if (selectedCourses.isEmpty) {
      showSend.value = false;
    }
  }
}
