import 'package:flutter/material.dart';
class ButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final bool isLoading = false;
  ButtonWidget(this.onPressed, this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 8,),
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(title, style: TextStyle(fontSize: 20),),
        )
    );
  }
}
