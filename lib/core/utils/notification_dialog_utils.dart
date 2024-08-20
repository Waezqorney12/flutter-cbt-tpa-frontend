import 'package:flutter/cupertino.dart';

import '../shared/text_style/text_app_style.dart';
import '../theme/app_palette.dart';

void notificationDialog({required BuildContext context, required void Function()? onTap, required String text}) {
  showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(
        'Warning',
        style: TextAppStyle.urbanistBold.copyWith(fontSize: 16),
      ),
      content: Text(
        textAlign: TextAlign.center,
        text,
        style: TextAppStyle.urbanistMedium.copyWith(fontSize: 14),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Tidak',
            style: TextAppStyle.urbanistSemiBold,
          ),
        ),
        CupertinoDialogAction(
          onPressed: onTap,
          child: Text(
            'Ya',
            style: TextAppStyle.urbanistSemiBold.copyWith(color: AppPalette.primaryColor),
          ),
        ),
      ],
    ),
  );
}
