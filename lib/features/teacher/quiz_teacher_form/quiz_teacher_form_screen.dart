import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_potensial/core/routes/routes_pages.dart';
import 'package:test_potensial/core/shared/widget/container_shadow_widget.dart';
import 'package:test_potensial/core/shared/widget/dropdown_widget.dart';
import 'package:test_potensial/core/shared/widget/form_widget.dart';
import 'package:test_potensial/core/theme/app_palette.dart';
import 'package:test_potensial/core/utils/extension_utils.dart';
import 'package:test_potensial/core/utils/notification_dialog_utils.dart';
import 'package:test_potensial/core/utils/utils.dart';
import 'package:test_potensial/features/profile/Widget/box_shadow.dart';
import 'package:test_potensial/features/teacher/quiz_teacher_form/quiz_teacher_form_controller.dart';

import '../../../core/shared/text_style/text_app_style.dart';
import '../../../core/shared/widget/upload_images_border_widget.dart';

class QuizTeacherFormScreen extends StatefulWidget {
  const QuizTeacherFormScreen({super.key});

  @override
  State<QuizTeacherFormScreen> createState() => _QuizTeacherFormScreenState();
}

class _QuizTeacherFormScreenState extends State<QuizTeacherFormScreen> {
  late QuizTeacherFormController _controller;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _categoryController;
  late TextEditingController _typeController;

  late FocusNode _titleNode;
  late FocusNode _descriptionNode;
  late FocusNode _categoryNode;
  late FocusNode _typeNode;

  @override
  void initState() {
    _controller = Provider.of<QuizTeacherFormController>(context, listen: false);
    _titleController = TextEditingController();
    _titleNode = FocusNode();

    _descriptionController = TextEditingController();
    _descriptionNode = FocusNode();

    _categoryController = TextEditingController();
    _categoryNode = FocusNode();

    _typeController = TextEditingController();
    _typeNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _titleNode.dispose();

    _descriptionController.dispose();
    _descriptionNode.dispose();

    _categoryController.dispose();
    _categoryNode.dispose();

    _typeController.dispose();
    _typeNode.dispose();
    _controller.questionList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: Text(
          'Quizzes Form',
          style: TextAppStyle.poppinsSemiBold.copyWith(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              uploadImagesBorder(
                imageFile: _controller.thumbnailImage,
                context,
                onTap: () => _controller.addImage().then(
                      (_) => setState(() {}),
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
                    textStyle: TextAppStyle.poppinsMedium.copyWith(
                      fontSize: 16,
                      color: AppPalette.black,
                    ),
                    hintText: 'Title',
                    controller: _titleController,
                  ),
                ),
              ).paddingOnly(top: 32, bottom: 24),
              Focus(
                focusNode: _descriptionNode,
                onFocusChange: (value) => setState(() {}),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      _descriptionNode.hasFocus ? const BoxShadow(color: Colors.transparent) : shadow(),
                    ],
                  ),
                  child: FormWidget(
                    textStyle: TextAppStyle.poppinsMedium.copyWith(
                      fontSize: 16,
                      color: AppPalette.black,
                    ),
                    hintText: 'Description',
                    controller: _descriptionController,
                  ),
                ),
              ),

              /// -----

              //-----------
              Consumer<QuizTeacherFormController>(
                // Consumer is a listener to rebuilding for changes state
                builder: (context, value, child) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DropDownWidget(
                              enabled: _controller.setCategory == null,
                              hintText: 'Category',
                              widht: 160,
                              selectedItems: _controller.selectedCategory,
                              onChanged: (value) => setState(() => _controller.selectedCategory = value),
                              items: CategoryQuiz.values.map(
                                (value) {
                                  return DropdownMenuItem(
                                    value: value.name,
                                    child: Text(Utility.capitalize(value.name)),
                                  );
                                },
                              ).toList()),
                          DropDownWidget(
                            hintText: 'Type',
                            enabled: _controller.setType == null,
                            widht: 140,
                            selectedItems: _controller.selectedType,
                            items: TypeQuiz.values.map(
                              (value) {
                                return DropdownMenuItem(
                                  value: value.name,
                                  child: Text(
                                    value.name[0].toUpperCase() + value.name.substring(1),
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (value) => setState(() => _controller.selectedType = value),
                          ),
                        ],
                      ).paddingOnly(top: 24, bottom: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${_controller.questionList.length} question',
                            style: TextAppStyle.montserratBold.copyWith(
                              fontSize: 16,
                              color: AppPalette.black,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_controller.selectedType != null && _controller.selectedCategory != null)
                                Navigator.of(context).push(
                                  Routes.quizDetailForm(type: _controller.selectedType!, category: _controller.selectedCategory!),
                                );
                              else
                                notificationDialog(
                                  context: context,
                                  isOption: false,
                                  onTap: () => Navigator.pop(context),
                                  text: 'Please select question type first',
                                );
                            },
                            child: Text(
                              'Add question',
                              style: TextAppStyle.montserratBold.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ).sized(w: 140)
                        ],
                      ),
                      const SizedBox(height: 12),
                      //-----------

                      ..._controller.questionList.map(
                        (data) {
                          final choices = [
                            data.choiceA,
                            data.choiceB,
                            data.choiceC,
                            data.choiceD,
                          ];
                          return containerShadow(
                            context,
                            widget: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: data.questionImage != null
                                      ? Container(
                                          height: 160,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            image: DecorationImage(
                                              image: NetworkImage(data.questionImage!),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ).paddingOnly(bottom: 4)
                                      : const SizedBox(),
                                ),
                                Text(
                                  data.title,
                                  style: TextAppStyle.poppinsMedium.copyWith(
                                    color: AppPalette.black,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Answer ${_controller.setType == 'choice' ? choices : 'essay'}',
                                  style: TextAppStyle.poppinsReguler.copyWith(fontSize: 10),
                                ).paddingSymmetric(vertical: 8),
                                _controller.setType == 'choice'
                                    ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: List.generate(
                                          choices.length,
                                          (index) {
                                            final choice = choices[index];
                                            final isCorrect = choice == data.correctAnswer;
                                            return Row(
                                              children: [
                                                isCorrect
                                                    ? const Icon(
                                                        Icons.check,
                                                        size: 16,
                                                        color: Colors.green,
                                                      )
                                                    : const Icon(
                                                        Icons.close,
                                                        size: 16,
                                                        color: Colors.red,
                                                      ),
                                                Text(
                                                  choice ?? 'No data',
                                                  style: TextAppStyle.poppinsReguler,
                                                ),
                                              ],
                                            ).paddingSymmetric(vertical: 2);
                                          },
                                        ))
                                    : Text(
                                        data.correctAnswer,
                                        style: TextAppStyle.poppinsReguler,
                                      ),
                              ],
                            ).paddingAll(10),
                          ).paddingSymmetric(vertical: 20);
                        },
                      )
                    ],
                  );
                },
              )
            ],
          ).paddingAll(24),
        ),
      ),
    );
  }
}
