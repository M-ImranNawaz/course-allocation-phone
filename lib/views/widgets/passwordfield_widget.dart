import 'package:flutter/material.dart';

import '../../controllers/login_controller.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LoginController controller;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obsecText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please fill Necessary Field';
          } else if (value.length < 5) {
            return 'Password is Too Short';
          }
          return null;
        },
        controller: widget.controller.passwordC,
        obscureText: obsecText,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.password),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                obsecText = !obsecText;
              });
            },
            child: obsecText == true
                ? const Icon(
                    Icons.visibility,
                    //color: Colors.black,
                  )
                : const Icon(
                    Icons.visibility_off,
                    // color: Colors.black,
                  ),
          ),
          labelText: 'Password',
        ),
      ),
    );
  }
}
