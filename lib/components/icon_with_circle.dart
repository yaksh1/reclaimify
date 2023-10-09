import 'package:flutter/material.dart';
import 'package:reclaimify/utils/colors.dart';

class IconWithCircle extends StatelessWidget {
  const IconWithCircle({
    super.key,
    required this.icon,
    this.color = AppColors.slateGrey,
    this.iconSize = 24,  this.padding=6,
  });

  final IconData icon;
  final Color color;
  final double padding;
  final double iconSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadiusDirectional.circular(50)),
      child: Icon(
        icon,
        color: color,
        size: iconSize,
      ),
    );
  }
}
