import 'package:course_allocation_phone/controllers/base_controller.dart';
import 'package:course_allocation_phone/helper/dialog_helper.dart';
import 'package:course_allocation_phone/models/faculty.dart';
import 'package:course_allocation_phone/views/pages/allocated_courses.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../services/base_client.dart';
import '../contstants.dart';

class LoginController extends GetxController with BaseController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var obsecText = false.obs;
  var isLoading = false.obs;

  List<Faculty> faculty = [];

  TextEditingController nameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  validation() async {
    var form = formKey.currentState;
    if (form!.validate()) {
      login();
    } 
  }

  login() async {
    BaseClient baseClient = BaseClient();
    showLoading();
    var response = await baseClient.post(kBaseUrl, 'loginfaculty', {
      'email': nameC.text,
      'password': passwordC.text
    }).catchError(handleError);
    hideLoading();
    if (response
        .toString()
        .contains('These credentials do not match our records.')) {
      DialogHelper.showErrorDialog(description: response.toString());
    }
    if (response == null) {
      DialogHelper.showErrorDialog(
          description: 'Please Provide Correct Credentials');
    }
    if (response != null) {
      faculty = response.map<Faculty>(Faculty.fromJson).toList();
      prefs.setInt('facultyId', faculty.first.id);
      prefs.setString('facultyName', faculty.first.name);
      facultyId = faculty.first.id;
      facultyName = faculty.first.name;
      Get.off(() => const AllocatedCourses());
    }
  }
}
