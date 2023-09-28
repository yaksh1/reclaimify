import 'package:flutter/material.dart';
import 'package:reclaimify/components/input_decoration.dart';

class NameTextField extends StatelessWidget {
  NameTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;
  final MyDecoration decor = MyDecoration();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        // The validator receives the text that the user has entered.
        obscureText: false,
        controller: controller,
        enableSuggestions: true,
        autocorrect: false,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        decoration: decor.getDecoration(
            icon: Icons.person, label: Text("Name"), hintText: "Name"));
  }
}
