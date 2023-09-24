// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reclaimify/utils/dimensions.dart';

class SquareTile extends StatelessWidget {
  final void Function()? onTap;
  final String imagePath;
  final double height;
  const SquareTile(
      {super.key, required this.imagePath, required this.onTap, required this.height});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:SvgPicture.asset(
          imagePath,
          height: height,
        ),
    );
  }
}
