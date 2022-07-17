
import 'package:course_allocation_phone/controllers/login_controller.dart';
import 'package:course_allocation_phone/contstants.dart';
import 'package:course_allocation_phone/views/widgets/passwordfield_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
//import '../../services/notificaton_service.dart';
import '../widgets/button_widget.dart';
import '../widgets/textformfield_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  late LoginController controller;
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          //LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
    
    controller = LoginController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue[100],
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3.3,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/icon.png', width: 100),
                    const Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 50,
                        color: kKfueitGreen,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Form(
              key: controller.formKey,
              child: Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const Text(
                        'SIGN IN',
                        style: TextStyle(
                            color: kKfueitblue,
                            fontSize: 40,
                            fontWeight: FontWeight.w500),
                      ),
                      TextFormFieldWidget(
                          controller: controller.nameC,
                          icon: Icons.person,
                          label: 'User Name',
                          validator: (value) {
                            if (value.length < 5) {
                              return 'User Name is Too Short';
                            }
                          }),
                      PasswordField(controller: controller),
                      Container(
                        child: controller.isLoading.value == false
                            ? ButtonWidget(
                                () {
                                  controller.validation();
                                },
                                'Login',
                              )
                            : const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
