import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  static void showErrorDialog(
      {String title = 'Error', String description = 'Something went wrong'}) {
    Get.dialog(Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Get.textTheme.headline4,
            ),
            const SizedBox(height: 4,),
            Text(
              description,
              textAlign: TextAlign.center,
              style: Get.textTheme.headline6,
            ),
            const SizedBox(height: 4,),
            ElevatedButton(
              onPressed: () {
                if (Get.isDialogOpen!) Get.back();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    ));
  }

  //show Loading
  static void showLoading(String message) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(
                height: 5,
              ),
              Text(message),
            ],
          ),
        ),
      ),
    );
  }

  //hide Loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}
