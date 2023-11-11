import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclaimify/components/input_decoration.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/dimensions.dart';
import 'package:reclaimify/utils/validators.dart';

class TextFormDescription extends StatelessWidget {
  TextFormDescription({
    super.key,
    required this.label,
    required this.hintText,
    required this.obscureText,
    this.controller,
    this.keyboardType = TextInputType.text,
    required this.helperText,
  });

  final MyDecoration decor = MyDecoration();

  final String label;
  final String hintText;
  final String helperText;
  final bool obscureText;

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  double height10 = Dimensions.height10;
  double radius10 = Dimensions.radius10;
  double width10 = Dimensions.width10;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // The validator receives the text that the user has entered.
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required.';
        }else if(value.length>50){
          return "Maximum length of description should be 50 characters";
        }
        return null;
        
      },

      keyboardType: TextInputType.text,
      obscureText: obscureText,
      controller: controller,
      enableSuggestions: true,
      autocorrect: false,
      decoration: InputDecoration(
        helperText: helperText,
        helperStyle: TextStyle(
          color: AppColors.slateGrey,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.slateGrey,
        ),
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide:
                BorderSide(color: AppColors.slateGrey.withOpacity(0.6))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide:
                BorderSide(color: AppColors.slateGrey.withOpacity(0.6))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: AppColors.primaryBlack)),
      ),
    );
  }
}
