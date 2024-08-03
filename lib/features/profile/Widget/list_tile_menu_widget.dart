import 'package:flutter/material.dart';

import '../../../core/shared/text_style/text_app_style.dart';
import '../../../core/theme/app_palette.dart';
import '../controller/profile_controller.dart';

ListTile menu(int index, MenuEntities value) {
    return ListTile(
      onTap: () {},
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppPalette.lightBlue.withOpacity(.05),
        ),
        child: Image.asset(value.imageMenu),
      ),
      title: Text(
        value.title,
        style: TextAppStyle.urbanistSemiBold.copyWith(
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        value.description,
        style: TextAppStyle.poppinsReguler.copyWith(
          fontSize: 12,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
        size: 16,
      ),
    );
  }