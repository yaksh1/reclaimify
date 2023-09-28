import 'package:flutter/material.dart';
import 'package:reclaimify/components/input_decoration.dart';

class EmailTextField extends StatelessWidget {
  EmailTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;
  final MyDecoration decor = MyDecoration();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        // The validator receives the text that the user has entered.
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter a valid email';
          }
          return null;
        },
        keyboardType: TextInputType.emailAddress,
        obscureText: false,
        controller: controller,
        enableSuggestions: true,
        autocorrect: false,
        decoration: decor.getDecoration(
            icon: Icons.mail_outline_outlined,
            label: Text("Email"),
            hintText: "Email"));
  }
}
