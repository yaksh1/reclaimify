import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reclaimify/components/input_decoration.dart';

class PasswordTextField extends StatelessWidget {
  PasswordTextField({super.key, required this.controller, required this.labelText, required this.hintText});

  final TextEditingController controller;
  final MyDecoration decor = MyDecoration();
  final String labelText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        // The validator receives the text that the user has entered.
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter a valid password';
          }
          return null;
        },
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        controller: controller,
        enableSuggestions: false,
        autocorrect: false,
        decoration: decor.getDecoration(
            icon: PhosphorIcons.duotone.lock,
            label: Text(labelText),
            hintText: hintText));
  }
}
