import 'package:flutter/material.dart';
import 'package:test_potensial/core/shared/widget/form_widget.dart';
import 'package:test_potensial/core/shared/widget/upload_images_border_widget.dart';
import 'package:test_potensial/core/utils/extension_utils.dart';
import 'package:test_potensial/features/teacher/quiz_teacher_detail_form/presentation/quiz_detail_form_question/quiz_teacher_detail_form_question_controller.dart';

import '../../../../../core/shared/text_style/text_app_style.dart';
import '../../../../../core/theme/app_palette.dart';
import '../../../../profile/Widget/box_shadow.dart';

class QuizTeacherDetailFormQuestionScreen extends StatefulWidget {
  const QuizTeacherDetailFormQuestionScreen({super.key});

  @override
  State<QuizTeacherDetailFormQuestionScreen> createState() => _QuizTeacherDetailFormQuestionScreenState();
}

class _QuizTeacherDetailFormQuestionScreenState extends State<QuizTeacherDetailFormQuestionScreen> {
  late QuizTeacherDetailFormQuestionController _controller;
  final key = GlobalKey<FormState>();

  @override
  void initState() {
    _controller = QuizTeacherDetailFormQuestionController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Create your question',
          style: TextAppStyle.poppinsSemiBold.copyWith(fontSize: 20),
        ),
      ),
      body: Form(
        key: key,
        child: Column(
          children: [
            uploadImagesBorder(
              imageFile: _controller.fileImage,
              context,
              onTap: () => _controller.addImage().then(
                    (_) => setState(() {}),
                  ),
            ),
            const SizedBox(height: 24),
            Focus(
              focusNode: _controller.titleNode,
              onFocusChange: (value) => setState(() {}),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    _controller.titleNode.hasFocus ? const BoxShadow(color: Colors.transparent) : shadow(),
                  ],
                ),
                child: FormWidget(
                  textStyle: TextAppStyle.poppinsMedium.copyWith(
                    fontSize: 16,
                    color: AppPalette.black,
                  ),
                  hintText: 'Write your question',
                  controller: _controller.titleController,
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (key.currentState!.validate()) _controller.addNewQuestion(context: context);
              },
              child: Text(
                'Save',
                style: TextAppStyle.poppinsMedium.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ).paddingAll(24),
      ),
    );
  }
}
