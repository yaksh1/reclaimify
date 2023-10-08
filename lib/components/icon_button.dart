import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclaimify/utils/colors.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      elevation: 0,
      label: Text(
        text,
        style: TextStyle(color: AppColors.darkGrey,
        fontWeight: FontWeight.w600,
        fontSize: 16),), // <-- Text
      backgroundColor: AppColors.lightMainColor2,
      icon: Icon(
        icon,color: AppColors.mainColor,
        ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
    );
  }
}
