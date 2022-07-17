import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String label;
  final bool? c;
  final Function validator;
  final Function? setIcon;
  const TextFormFieldWidget(
      {required this.controller,
      required this.icon,
      required this.label,
      this.c,
      required this.validator,
      this.setIcon});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) return 'Please fill Necessary Field';
          return validator(value);
        },
        textInputAction: TextInputAction.next,
        controller: controller,
        autofillHints: const [AutofillHints.email],
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          prefixIcon: Icon(icon),
          labelText: label,
        ),
      ),
    );
  }
}
