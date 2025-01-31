import 'package:flutter/material.dart';

import 'package:test_potensial/core/shared/positioned/dimensions.dart';
import 'package:test_potensial/core/theme/app_palette.dart';

Positioned iconMember({
  required BuildContext context,
  required int index,
  Widget? icon,
  Color? color,
  double? widht,
  double? right,
}) {
  return Positioned(
    left: (index * (widht ?? 28.0)),
    bottom: Dimensions.height10(context),
    child: CircleAvatar(
      backgroundColor: color ?? AppPalette.black,
      child: icon ??
          const Icon(
            Icons.person_outline,
            color: Colors.black,
          ),
    ),
  );
}
