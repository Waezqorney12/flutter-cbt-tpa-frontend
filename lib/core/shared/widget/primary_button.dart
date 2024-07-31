import 'package:flutter/material.dart';

import '../text_style/text_app_style.dart';

Widget primaryButton(
  BuildContext context, {
  required String text,
  required void Function()? onTap,
}) {
  return ElevatedButton(
    onPressed: onTap,
    child: Text(
      text,
      style: TextAppStyle.poppinsMedium.copyWith(
        fontSize: 16,
        color: Colors.white,
      ),
    ),
  );
}
