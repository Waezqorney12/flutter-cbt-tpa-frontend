import 'package:flutter/material.dart';

import '../../../core/shared/text_style/text_app_style.dart';
import '../../../core/theme/app_palette.dart';

Widget optionAuthWidget(BuildContext context, {required void Function()? onTap, required String firstText, required String secondText }) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstText,
          style: TextAppStyle.poppinsReguler.copyWith(
            fontSize: 14,
            color: AppPalette.loginTextColor,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            secondText,
            style: TextAppStyle.poppinsSemiBold.copyWith(
              fontSize: 14,
              color: AppPalette.primaryColor,
            ),
          ),
        ),
      ],
    ),
  );
}
