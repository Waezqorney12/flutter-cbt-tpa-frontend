import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_potensial/core/shared/widget/form_widget.dart';
import 'package:test_potensial/core/shared/widget/upload_images_border_widget.dart';
import 'package:test_potensial/core/utils/extension_utils.dart';
import 'package:test_potensial/core/utils/notification_dialog_utils.dart';
import 'package:test_potensial/core/utils/pick_image_utils.dart';
import 'package:test_potensial/features/profile/Widget/box_shadow.dart';

import '../../../core/shared/text_style/text_app_style.dart';
import '../../../core/theme/app_palette.dart';

class MateriTeacherFormScreen extends StatefulWidget {
  const MateriTeacherFormScreen({super.key});

  @override
  State<MateriTeacherFormScreen> createState() => _MateriTeacherFormScreenState();
}

class _MateriTeacherFormScreenState extends State<MateriTeacherFormScreen> {
  File? imageFile;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  late FocusNode _titleNode;
  late FocusNode _descriptionNode;

  String firstHint = 'Material';

  String? _selectedCategory;

  Future uploadImage() async {
    final File? image = await pickImage();
    if (image != null) imageFile = image;
  }

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();

    _descriptionNode = FocusNode();
    _titleNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();

    _titleNode.dispose();
    _descriptionNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Material Form',
          style: TextAppStyle.poppinsSemiBold.copyWith(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            uploadImagesBorder(
              context,
              imageFile: imageFile,
              onTap: () => uploadImage().then(
                (value) => setState(() {}),
              ),
            ),
            Focus(
              focusNode: _titleNode,
              onFocusChange: (value) => setState(() {}),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    _titleNode.hasFocus ? const BoxShadow(color: Colors.transparent) : shadow(),
                  ],
                ),
                child: FormWidget(
                  hintText: 'Material Title',
                  textStyle: TextAppStyle.poppinsMedium.copyWith(
                    fontSize: 16,
                    color: AppPalette.black.withOpacity(.7),
                  ),
                  controller: _titleController,
                ),
              ),
            ).paddingSymmetric(vertical: 24),
            Focus(
              focusNode: _descriptionNode,
              onFocusChange: (value) => setState(() {}),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    _descriptionNode.hasFocus ? const BoxShadow(color: Colors.transparent) : shadow(),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  validator: (value) => value?.isEmpty ?? true ? firstHint : null,
                  maxLines: null,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: '$firstHint Description',
                    hintStyle: TextAppStyle.poppinsMedium.copyWith(
                      fontSize: 16,
                      color: AppPalette.black.withOpacity(.7),
                    ),
                  ),
                ),
              ),
            )
          ],
        ).paddingAll(24),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          if (_titleController.text.isEmpty && _descriptionController.text.isEmpty)
            notificationDialog(
              context: context,
              onTap: () => Navigator.pop(context),
              isOption: false,
              text: 'Please fill out form field',
            );
          else
            print('Submitted');
        },
        child: Text(
          'LOG IN',
          style: TextAppStyle.poppinsMedium.copyWith(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ).paddingAll(24),
    );
  }
}
