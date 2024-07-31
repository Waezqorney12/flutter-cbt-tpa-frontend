import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/shared/text_style/text_app_style.dart';
import '../../../core/theme/app_palette.dart';

Widget thirdPartyButton(
  BuildContext context, {
  required double widht,
  required String image,
  required String text,
  required Function()? onPressed,
}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      height: 60,
      width: widht,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: SvgPicture.asset(
              image,
              height: 25,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              text,
              style: TextAppStyle.poppinsMedium.copyWith(
                fontSize: 16,
                color: AppPalette.loginTextColor,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
