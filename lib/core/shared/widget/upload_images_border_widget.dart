import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:test_potensial/core/utils/extension_utils.dart';

import '../positioned/dimensions.dart';
import '../text_style/text_app_style.dart';

DottedBorder uploadImagesBorder(
  BuildContext context, {
  void Function()? onTap,
  File? imageFile,
}) {
  return DottedBorder(
    borderType: BorderType.RRect,
    radius: const Radius.circular(8),
    dashPattern: const [20, 12],
    strokeWidth: 2,
    color: Colors.grey.withOpacity(.6),
    child: InkWell(
        onTap: onTap,
        child: Container(
          height: 168,
          width: Dimensions.screenWidht(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: imageFile != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    imageFile,
                    fit: BoxFit.fill,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.cloud_upload_outlined,
                      size: 40,
                    ),
                    Text(
                      'Choose a file & drop it here',
                      style: TextAppStyle.poppinsMedium,
                    ).paddingOnly(top: 12),
                    Text(
                      'JPEG, PNG formats, up to 2MB',
                      style: TextAppStyle.poppinsMedium.copyWith(
                        color: Colors.grey,
                      ),
                    ).paddingOnly(bottom: 12),
                  ],
                ),
        )),
  );
}
