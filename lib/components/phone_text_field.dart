import 'package:flutter/material.dart';
import 'package:reclaimify/components/input_decoration.dart';

class PhoneTextField
 extends StatelessWidget {
   PhoneTextField({
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
            return 'Enter a valid phone number';
          }
          return null;
        },
        keyboardType: TextInputType.phone,
        obscureText: false,
        controller: controller,
        enableSuggestions: true,
        autocorrect: false,
        decoration: decor.getDecoration(
            icon: Icons.phone,
            label: const Text("Phone"),
            hintText: "Phone"));
    
  }
}