// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final double? height;
  const SquareTile({super.key, required this.imagePath, this.height = 60});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(15),
      height: height,
      child: SvgPicture.asset(imagePath),
    );
  }
}
