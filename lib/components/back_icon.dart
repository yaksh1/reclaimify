import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reclaimify/utils/colors.dart';

class BackIcon extends StatelessWidget {
  const BackIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: Icon(
        PhosphorIcons.duotone.caretCircleLeft,
        color: AppColors.primaryBlack,
        size: 40,
      ),
    );
  }
}
