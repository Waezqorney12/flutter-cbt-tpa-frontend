import 'package:flutter/material.dart';
import 'package:test_potensial/core/utils/extension_utils.dart';
import 'package:test_potensial/features/teacher/kelas_teacher/presentation/kelas_teacher_controller.dart';

import '../../../../core/shared/positioned/dimensions.dart';
import '../../../../core/shared/text_style/text_app_style.dart';
import '../../../profile/Widget/box_shadow.dart';

Container card(
    {required BuildContext context,
    BoxShadow? boxShadow,
    required String title,
    required String subTitle,
    Color? subTitleColor,
    void Function()? onTap,
    bool? isClickable = false,
    bool? isTitle = false,
    IconCard? iconCard}) {
  return Container(
    width: Dimensions.screenWidht(context),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      boxShadow: [boxShadow ?? shadow()],
    ),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(
            iconCard?.iconic ?? Icons.help_outline,
            color: Colors.white,
          ),
        ).paddingAll(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.length > 33 ? '${title.substring(0, 32)}...' : title,
              style: isTitle == true ? TextAppStyle.poppinsMedium : TextAppStyle.poppinsReguler,
            ),
            Text(
              subTitle,
              style: isTitle == true
                  ? TextAppStyle.poppinsReguler.copyWith(
                      color: subTitleColor ?? Colors.blue,
                    )
                  : TextAppStyle.poppinsBold.copyWith(
                      color: subTitleColor ?? Colors.blue,
                    ),
            )
          ],
        ),
        const Spacer(),
        isClickable == true
            ? InkWell(
                onTap: onTap,
                child: const Icon(Icons.more_vert).paddingOnly(right: 5),
              )
            : const SizedBox()
      ],
    ),
  );
}

extension IconCardData on IconCard {
  IconData get iconic {
    return switch (this) {
      IconCard.pin => Icons.copy,
      IconCard.materi => Icons.book_outlined,
      IconCard.quiz => Icons.quiz_outlined,
    };
  }
}
