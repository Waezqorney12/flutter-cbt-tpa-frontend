import 'package:flutter/material.dart';

import '../../theme/app_palette.dart';
import '../positioned/dimensions.dart';

Widget containerShadow(BuildContext context, {required Widget widget}) {
  return Container(
      width: Dimensions.screenWidht(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            spreadRadius: 2,
            color: AppPalette.black.withOpacity(.4),
          )
        ],
        color: Colors.white,
      ),
      child: widget);
}
