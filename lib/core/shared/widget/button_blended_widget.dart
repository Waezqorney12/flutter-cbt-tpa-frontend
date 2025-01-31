import 'package:flutter/material.dart';
import 'package:test_potensial/core/utils/extension_utils.dart';

import '../../theme/app_palette.dart';
import '../positioned/dimensions.dart';
import '../text_style/text_app_style.dart';

Widget buttonBlendedWidget({
  required String text,
  required void Function()? onTap,
  required BuildContext context,
  Color? color,
  Color? blendColor,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: text.length > 33 ? null : 72,
      width: Dimensions.screenWidht(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: color ?? AppPalette.primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 8,
            width: (Dimensions.widht336(context) - Dimensions.widht5(context)),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white.withOpacity(.2),
            ),
          ).paddingOnly(left: 10),
          Text(
            text,
            style: TextAppStyle.montserratMedium.copyWith(
              fontSize: 16,
              color: Colors.white,
            ),
          ).paddingSymmetric(horizontal: 15, vertical: 3),
          Container(
            height: 8,
            width: (Dimensions.widht336(context) - Dimensions.widht5(context)),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: blendColor?.withOpacity(.4) ?? AppPalette.blendPrimaryDark.withOpacity(0.4),
            ),
          ).paddingOnly(left: 10),
        ],
      ),
    ),
  );
}
