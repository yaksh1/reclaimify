import 'package:flutter/material.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/dimensions.dart';

class TextForm extends StatelessWidget {
  TextForm({
    super.key,
    required this.label,
    required this.hintText,
    required this.icon,
    required this.obscureText,
    required this.autocorrect,
    required this.enabledSuggestions,
    this.controller,
    this.keyboardType = TextInputType.text,
  });

  final Widget? label;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final bool autocorrect;
  final bool enabledSuggestions;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  double height10 = Dimensions.height10;
  double radius10 = Dimensions.radius10;
  double width10 = Dimensions.width10;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      enableSuggestions: enabledSuggestions,
      autocorrect: autocorrect,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: Icon(
          icon,
          size: height10 * 2.5,
          color: AppColors.mainColor,
        ),
        label: label,
        labelStyle: TextStyle(color: AppColors.primaryBlack),
        hintText: hintText,
        fillColor: AppColors.grey,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius10 * 1.6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: AppColors.primaryBlack, width: width10 * 0.1),
          borderRadius: BorderRadius.circular(radius10 * 1.6),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}
