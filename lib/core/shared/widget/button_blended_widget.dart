import 'package:flutter/material.dart';

import '../../theme/app_palette.dart';
import '../positioned/dimensions.dart';
import '../text_style/text_app_style.dart';

Widget buttonBlendedWidget({
  required String text,
  required void Function()? onTap,
  required BuildContext context,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 50,
      width: Dimensions.screenWidht(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppPalette.primaryColor,
      ),
      child: Column(
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
              color: AppPalette.blendPrimaryLight.withOpacity(.2),
            ),
          ),
          Text(
            text,
            style: TextAppStyle.montserratMedium.copyWith(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          Container(
            height: 8,
            width: (Dimensions.widht336(context) - Dimensions.widht5(context)),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: AppPalette.blendPrimaryDark.withOpacity(0.4),
            ),
          ),
        ],
      ),
    ),
  );
}
