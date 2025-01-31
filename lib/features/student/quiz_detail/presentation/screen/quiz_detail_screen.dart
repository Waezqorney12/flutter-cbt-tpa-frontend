// ignore_for_file: curly_braces_in_flow_control_structures, unused_import, must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_potensial/core/routes/routes_pages.dart';
import 'package:test_potensial/core/shared/positioned/dimensions.dart';
import 'package:test_potensial/core/shared/text_style/text_app_style.dart';
import 'package:test_potensial/core/shared/widget/button_blended_widget.dart';
import 'package:test_potensial/core/shared/widget/form_widget.dart';
import 'package:test_potensial/core/shared/widget/loading_widget.dart';
import 'package:test_potensial/core/utils/extension_utils.dart';
import 'package:test_potensial/core/theme/app_palette.dart';
import 'package:test_potensial/core/utils/log.dart';
import 'package:test_potensial/core/utils/map_index_utils.dart';
import 'package:test_potensial/core/utils/notification_dialog_utils.dart';
import 'package:test_potensial/core/utils/show_snackbar_utils.dart';
import 'package:test_potensial/core/utils/utils.dart';
import 'package:test_potensial/features/student/quiz_detail/data/model/quiz_model.dart';
import 'package:test_potensial/features/student/quiz_detail/domain/entities/quiz_entities.dart';
import 'package:test_potensial/features/student/quiz_detail/presentation/controller/quiz_detail_controller.dart';
import 'package:test_potensial/features/student/quiz_detail/presentation/widget/quiz_detail_widget.dart';
import 'package:test_potensial/features/student/quiz_nilai/bloc/quiz_nilai_bloc.dart';

import '../../../../profile/Widget/box_shadow.dart';
import '../../bloc/quiz_detail_bloc.dart';
import '../../domain/usecase/quiz_usecase.dart';

class QuizDetailScreen extends StatefulWidget {
  final String title;
  final GetDetailQuizParams params;
  const QuizDetailScreen({super.key, required this.title, required this.params});

  @override
  State<QuizDetailScreen> createState() => _QuizDetailScreenState();
}

class _QuizDetailScreenState extends State<QuizDetailScreen> {
  int currentIndex = 0;
  TextEditingController answerController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<int> quizIds = [];
  List<List<dynamic>> quizTemp = [];
  late QuizDetailController _controller;

  @override
  void initState() {
    _controller = QuizDetailController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => exit(context, quizId: widget.params.id, data: quizTemp),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => exit(context, quizId: widget.params.id, data: quizTemp),
          ),
          centerTitle: true,
          title: Text(
            '${Utility.capitalize(widget.params.type)} Question',
            style: TextAppStyle.montserratSemiBold.copyWith(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
        ),
        body: Form(
          key: formKey,
          child: BlocListener<QuizNilaiBloc, QuizNilaiState>(
            listener: (context, state) {
              if (state is QuizNilaiSuccess)
                Navigator.of(context).pushAndRemoveUntil(
                  Routes.quizNilai(),
                  (route) => false,
                );
            },
            child: BlocConsumer<QuizDetailBloc, QuizDetailState>(
              listener: (context, state) {
                if (state is QuizUserExit) {
                  Navigator.pushReplacement(context, Routes.nav());
                }
                if (state is QuizDetailError) {
                  showSnackBar(context, state.message);
                } else if (state is QuizDetailLoaded) {
                  quizIds = state.responseQuizzes.quizEntities.map((e) => e.quizDetails.quizQuestionId ?? 0).toList();
                }
              },
              builder: (context, state) {
                return switch (state) {
                  QuizDetailLoading() => const Loading(),
                  QuizDetailLoaded() => SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: Dimensions.screenWidht(context),
                            decoration: BoxDecoration(
                              boxShadow: [shadow(), shadow()],
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    state.responseQuizzes.quizEntities[currentIndex].quizDetails.quizImagePath != null
                                        ? Image.network(
                                            state.responseQuizzes.quizEntities[currentIndex].quizDetails.quizImagePath!,
                                            width: Dimensions.screenWidht(context),
                                            height: 200,
                                            fit: BoxFit.cover,
                                          )
                                        : const SizedBox.shrink(),
                                    Text(
                                      "${state.responseQuizzes.quizEntities[currentIndex].quizDetails.quizQuestion}",
                                      style: TextAppStyle.montserratMedium.copyWith(
                                        fontSize: 16,
                                      ),
                                    ).paddingSymmetric(vertical: 10),
                                  ],
                                ),
                                quizzesNumber(
                                  context: context,
                                  state: state,
                                  currentIndex: currentIndex,
                                )
                              ],
                            ).paddingOnly(top: 30, bottom: 10).paddingAll(10),
                          ).paddingOnly(top: 30, bottom: 50),
                          widget.params.type == 'choice' ? choice(state, context) : essay(context, state),
                        ],
                      ).paddingAll(20),
                    ),
                  _ => const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Loading()],
                    )
                };
              },
            ),
          ),
        ),
      ),
    );
  }

  Column essay(BuildContext context, QuizDetailLoaded state) {
    return Column(
      children: [
        TextFormField(
          maxLines: null,
          decoration: InputDecoration(
            hintText: 'Write your answer here',
            hintStyle: TextAppStyle.montserratMedium.copyWith(
              fontSize: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: .5,
                color: AppPalette.greyBlue, // Enabled border color
              ),
            ),
          ),
          controller: answerController,
          keyboardType: TextInputType.text,
          validator: (value) => value!.isEmpty ? "You must fill the answer" : null,
        ),
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              handlingAnswer(
                context: context,
                answer: answerController.text.trim(),
                quiz: state.responseQuizzes.quizEntities,
              );
            }
            answerController.clear();
          },
          child: Text(
            'Submit',
            style: TextAppStyle.montserratMedium.copyWith(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ).paddingSymmetric(vertical: 20),
      ],
    );
  }

  Column choice(QuizDetailLoaded state, BuildContext context) {
    final quizDetail = state.responseQuizzes.quizEntities[currentIndex].quizDetails;
    return Column(
      children: [
        ..._controller.shuffleOptions(quizDetail).asMap().entries.map((e) {
          final index = e.key;
          final choice = e.value;
          return buttonBlendedWidget(
            color: _controller.buttonColorOptions()[index]['color'],
            blendColor: _controller.buttonColorOptions()[index]['blendColor'],
            text: choice['value'] ?? 'No value',
            onTap: () {
              handlingAnswer(
                context: context,
                quiz: state.responseQuizzes.quizEntities,
                answer: choice['value'] ?? 'No value',
              );
            },
            context: context,
          ).paddingSymmetric(vertical: 10);
        }),
      ],
    );
  }

  void exit(BuildContext context, {required int quizId, required List<List<dynamic>> data}) {
    return notificationDialog(
        context: context,
        onTap: () {
          context.read<QuizDetailBloc>().add(UserExitEvent(
                UserQuizParams(quizId: quizId, data: data),
              ));
          Navigator.of(context).pop();
        },
        text: 'Jika anda keluar maka test tidak akan diulang kembali. Anda yakin ingin keluar?');
  }

  void handlingAnswer({required BuildContext context, required String answer, required List<QuizEntities> quiz}) {
    if (currentIndex < quizIds.length - 1) {
      if (currentIndex == 0) {
        notificationDialog(
            title: 'Reminder',
            context: context,
            onTap: () {
              moveToQuizTemp(quiz, answer);
              setState(() {
                currentIndex++;
              });
              Navigator.pop(context);
            },
            text: 'Setiap soal yang sudah dijawab anda tidak bisa kembali ke soal sebelumnya');
      }
      if (currentIndex != 0 && currentIndex < quizIds.length - 1) {
        moveToQuizTemp(quiz, answer);
        setState(() => currentIndex++);
      }
    } else {
      notificationDialog(
          title: 'Reminder',
          context: context,
          onTap: () async {
            moveToQuizTemp(quiz, answer);
            context.read<QuizNilaiBloc>().add(GetNilaiQuizEvent(UserQuizParams(quizId: widget.params.id, data: quizTemp)));
            Navigator.pop(context);
          },
          text: 'Setiap soal yang sudah dijawab anda tidak bisa kembali ke soal sebelumnya');
    }
  }

  void moveToQuizTemp(List<QuizEntities> quiz, String answer) {
    final id = quiz[currentIndex].id;
    final questionId = quiz[currentIndex].quizDetails.quizQuestionId;
    final isCorrect = answer == quiz[currentIndex].quizDetails.correctAnswer ? true : false;
    quizTemp.add([id, questionId, answer, isCorrect]);
    print(quizTemp);
  }
}
