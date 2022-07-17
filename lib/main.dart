//import 'package:course_allocation_phone/services/notificaton_service.dart';
import 'package:course_allocation_phone/views/pages/allocated_courses.dart';
import 'package:course_allocation_phone/views/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
int facultyId = -1;
String facultyName = "null";

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await initDb();
  //LocalNotificationService.initialize();
  runApp(const MyApp());
}

initDb() async {
  prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('facultyId')) {
    facultyId = prefs.getInt('facultyId')!;
    facultyName = prefs.getString('facultyName')!;
  }
  print(facultyId);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final int myColor = 0xFF22B24C;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'KFUEIT Smart Course Allocation App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(myColor, {
          50: Color(myColor),
          100: Color(myColor),
          200: Color(myColor),
          300: Color(myColor),
          400: Color(myColor),
          500: Color(myColor),
          600: Color(myColor),
          700: Color(myColor),
          800: Color(myColor),
          900: Color(myColor),
        }),
      ),
      home: facultyId == -1 ? const LoginPage() : const AllocatedCourses(),
    );
  }
}
