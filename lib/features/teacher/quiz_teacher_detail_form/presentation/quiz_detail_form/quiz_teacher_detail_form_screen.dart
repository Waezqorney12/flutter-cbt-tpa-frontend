import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test_potensial/core/routes/routes_pages.dart';
import 'package:test_potensial/core/shared/positioned/dimensions.dart';
import 'package:test_potensial/core/shared/widget/form_widget.dart';
import 'package:test_potensial/core/shared/widget/loading_widget.dart';
import 'package:test_potensial/core/utils/extension_utils.dart';
import 'package:test_potensial/core/utils/log.dart';
import 'package:test_potensial/features/teacher/quiz_teacher_detail_form/cubit/quiz_detail_form/quiz_detail_form_cubit.dart';
import 'package:test_potensial/features/teacher/quiz_teacher_detail_form/presentation/quiz_detail_form/quiz_teacher_detail_form_controller.dart';
import 'package:test_potensial/features/teacher/quiz_teacher_form/domain/entities/form_quiz_entities.dart';
import 'package:test_potensial/features/teacher/quiz_teacher_form/quiz_teacher_form_controller.dart';

import '../../../../../core/shared/text_style/text_app_style.dart';
import '../../../../../core/theme/app_palette.dart';

class QuizTeacherDetailFormScreen extends StatefulWidget {
  final String questionType;
  final String questionCategory;
  const QuizTeacherDetailFormScreen({
    required this.questionType,
    required this.questionCategory,
    super.key,
  });

  @override
  State<QuizTeacherDetailFormScreen> createState() => _QuizTeacherDetailFormScreenState();
}

class _QuizTeacherDetailFormScreenState extends State<QuizTeacherDetailFormScreen> {
  late QuizTeacherDetailFormController _controller;
  final key = GlobalKey<FormState>();

  String? _selectedValue;

  @override
  void initState() {
    _controller = QuizTeacherDetailFormController();
    _controller.scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _controller.controllersDispose();
    super.dispose();
  }

  void _onScroll() {
    if (_controller.scrollController.position.pixels == _controller.scrollController.position.maxScrollExtent)
      setState(() {
        _controller.currentMax += 2;
      });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<QuizTeacherFormController>(context, listen: false);

    List<TextEditingController> choices = [
      _controller.choiceA,
      _controller.choiceB,
      _controller.choiceC,
      _controller.choiceD,
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Create your quizzes',
          style: TextAppStyle.poppinsSemiBold.copyWith(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Focus(
                focusNode: _controller.questionNode,
                onFocusChange: (value) => setState(() {}),
                child: FormWidget(
                  onChanged: (p0) => _controller.debouncer.run(
                    () => context.read<QuizDetailFormCubit>().getQuestion(
                          name: _controller.titleController.text,
                        ),
                  ),
                  hintText: 'Search question',
                  controller: _controller.titleController,
                ),
              ),
              _controller.questionNode.hasFocus
                  ? Container(
                      height: 100,
                      width: Dimensions.screenWidht(context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: BlocBuilder<QuizDetailFormCubit, QuizDetailFormState>(
                        builder: (context, state) {
                          Log.loggerInformation(state);
                          if (state is QuizDetailFormInitial)
                            context.read<QuizDetailFormCubit>().getQuestion(
                                  name: _controller.titleController.text,
                                );
                          return switch (state) {
                            QuizDetailFormLoading() || QuizDetailFormInitial() => const Loading(),
                            QuizDetailFormLoaded() => ListView.builder(
                                controller: _controller.scrollController,
                                itemCount: _controller.currentMax < state.question.length
                                    ? _controller.currentMax
                                    : state.question.length,
                                itemBuilder: (context, index) {
                                  Log.loggerError(_controller.currentMax);
                                  Log.loggerInformation(_controller.scrollController.position.pixels);
                                  final value = state.question[index];
                                  return InkWell(
                                    onTap: () {
                                      if (value.imagePath != null) _controller.imageFile = value.imagePath;
                                      _controller.questionId = value.questionId;
                                      _controller.titleController.text = value.question;
                                    },
                                    child: Text(
                                      "ID:${value.questionId},Question:${value.question},Img:${value.imagePath}",
                                      style: TextAppStyle.poppinsMedium.copyWith(
                                        fontSize: 16,
                                        color: AppPalette.black,
                                      ),
                                    ).paddingAll(12),
                                  );
                                },
                              ),
                            QuizDetailFormError() => Center(
                                child: Text(
                                  state.message,
                                  style: TextAppStyle.urbanistSemiBold.copyWith(
                                    fontSize: 18,
                                    color: AppPalette.boardingTextColor,
                                  ),
                                ),
                              ),
                          };
                        },
                      ),
                    ).paddingOnly(top: 8)
                  : const SizedBox(),
              InkWell(
                onTap: () => Navigator.push(context, Routes.questionDetailForm()),
                child: Text(
                  'Add new question',
                  style: TextAppStyle.poppinsMedium.copyWith(
                    fontSize: 12,
                    color: AppPalette.primaryColor,
                  ),
                ),
              ).paddingOnly(top: _controller.questionNode.hasFocus ? 20 : 0),
              const SizedBox(height: 24),
              widget.questionType == 'choice'
                  ? Column(
                      children: choices.asMap().entries.map((entry) {
                        int index = entry.key;
                        TextEditingController value = entry.value;
                        return Stack(
                          children: [
                            FormWidget(
                              hintText: 'Choice ${String.fromCharCode(65 + index)}',
                              controller: value,
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Radio<String>(
                                value: value.text,
                                groupValue: _selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedValue = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ).paddingSymmetric(vertical: 8);
                      }).toList(),
                    )
                  : FormWidget(
                      hintText: 'Correct answer',
                      controller: _controller.essayAnswerController,
                    ),
              ElevatedButton(
                onPressed: () {
                  if (key.currentState!.validate()) {
                    if (widget.questionType == 'choice')
                      controller.addQuiz(
                        quiz: FormQuizEntities(
                            id: _controller.questionId ?? 0,
                            title: _controller.titleController.text,
                            questionImage: _controller.imageFile,
                            choiceA: _controller.choiceA.text,
                            choiceB: _controller.choiceB.text,
                            choiceC: _controller.choiceC.text,
                            choiceD: _controller.choiceD.text,
                            correctAnswer: _selectedValue ?? 'Null'),
                      );
                    else
                      controller.addQuiz(
                        quiz: FormQuizEntities(
                          id: _controller.questionId ?? 0,
                          questionImage: _controller.imageFile,
                          title: _controller.titleController.text,
                          correctAnswer: _controller.essayAnswerController.text,
                        ),
                      );
                    controller.setType ??= widget.questionType;
                    controller.setCategory ??= widget.questionCategory;
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  'Save',
                  style: TextAppStyle.poppinsMedium.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ).paddingOnly(top: 24)
            ],
          ).paddingAll(24),
        ),
      ),
    );
  }
}
