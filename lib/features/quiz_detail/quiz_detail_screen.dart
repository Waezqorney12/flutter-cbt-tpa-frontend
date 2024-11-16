// ignore_for_file: curly_braces_in_flow_control_structures, unused_import, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_potensial/core/routes/routes_pages.dart';
import 'package:test_potensial/core/shared/positioned/dimensions.dart';
import 'package:test_potensial/core/shared/text_style/text_app_style.dart';
import 'package:test_potensial/core/shared/widget/button_blended_widget.dart';
import 'package:test_potensial/core/shared/widget/loading_widget.dart';
import 'package:test_potensial/core/utils/extension_utils.dart';
import 'package:test_potensial/core/theme/app_palette.dart';
import 'package:test_potensial/core/utils/log.dart';
import 'package:test_potensial/core/utils/notification_dialog_utils.dart';
import 'package:test_potensial/core/utils/show_snackbar_utils.dart';
import 'package:test_potensial/features/quiz_detail/domain/entities/quiz_entities.dart';
import 'package:test_potensial/features/quiz_nilai/bloc/quiz_nilai_bloc.dart';

import '../profile/Widget/box_shadow.dart';
import 'bloc/quiz_detail_bloc.dart';
import 'domain/usecase/quiz_usecase.dart';

class QuizDetailScreen extends StatefulWidget {
  final String category;
  late List<QuizEntities> quiz;
  QuizDetailScreen({super.key, required this.category});

  @override
  State<QuizDetailScreen> createState() => _QuizDetailScreenState();
}

class _QuizDetailScreenState extends State<QuizDetailScreen> {
  int currentIndex = 0;
  bool isButtonEnabled = true;

  List<int> quizIds = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        notificationDialog(
            context: context,
            onTap: () => context.read<QuizDetailBloc>().add(UserExitEvent(quizIds)),
            text: 'Jika anda keluar maka test tidak akan diulang kembali. Anda yakin ingin keluar?');
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Tes ${widget.category}',
            style: TextAppStyle.montserratSemiBold.copyWith(
              fontSize: 18,
              color: AppPalette.primaryColor,
            ),
          ),
        ),
        body: BlocConsumer<QuizDetailBloc, QuizDetailState>(
          listener: (context, state) {
            if (state is QuizUserExit) {
              Navigator.pushReplacement(context, Routes.nav());
            }
            if (state is QuizDetailError) {
              showSnackBar(context, state.message);
            } else if (state is QuizDetailLoaded) {
              widget.quiz = state.quizEntities;
              quizIds = widget.quiz.map((e) => e.id).toList();
            }
          },
          builder: (context, state) {
            if (state is QuizDetailInitial) context.read<QuizDetailBloc>().add(GetQuizDetailEvent(widget.category));
            return switch (state) {
              QuizDetailLoading() => const Loading(),
              QuizDetailLoaded() => Column(
                  children: [
                    const SizedBox(height: 50),
                    Container(
                      width: Dimensions.screenWidht(context),
                      decoration: BoxDecoration(
                        boxShadow: [shadow()],
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Text(
                        "${state.quizEntities[currentIndex].id}. ${state.quizEntities[currentIndex].pertanyaan}",
                        style: TextAppStyle.montserratMedium.copyWith(
                          fontSize: 16,
                        ),
                      ).paddingAll(30),
                    ),
                    const SizedBox(height: 50),
                    buttonBlendedWidget(
                      text: state.quizEntities[currentIndex].jawabanA,
                      onTap: () => handlingAnswer(
                        soalId: state.quizEntities[currentIndex].id,
                        answer: 'a',
                      ),
                      context: context,
                    ),
                    buttonBlendedWidget(
                      text: state.quizEntities[currentIndex].jawabanB,
                      onTap: () => handlingAnswer(
                        soalId: state.quizEntities[currentIndex].id,
                        answer: 'b',
                      ),
                      context: context,
                    ).paddingSymmetric(vertical: 20),
                    buttonBlendedWidget(
                      text: state.quizEntities[currentIndex].jawabanC,
                      onTap: () => handlingAnswer(
                        soalId: state.quizEntities[currentIndex].id,
                        answer: 'c',
                      ),
                      context: context,
                    ),
                    buttonBlendedWidget(
                      text: state.quizEntities[currentIndex].jawabanD,
                      onTap: () => handlingAnswer(
                        soalId: state.quizEntities[currentIndex].id,
                        answer: 'd',
                      ),
                      context: context,
                    ).paddingSymmetric(vertical: 20)
                  ],
                ).paddingAll(20),
              _ => const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Loading()],
                )
            };
          },
        ),
      ),
    );
  }

  void handlingAnswer({required String answer, required int soalId}) {
    if (isButtonEnabled) {
      if (currentIndex < widget.quiz.length - 1) {
        isButtonEnabled = false;
        context.read<QuizDetailBloc>().add(
              CreateJawabanDetailEvent(
                CreateJawabanParams(soalId, answer),
              ),
            );
        Future.delayed(const Duration(milliseconds: 1500), () {
          isButtonEnabled = true;
          currentIndex++;
        });
      } else {
        Navigator.pushReplacement(context, Routes.quizNilai(category: widget.category));
      }
    }
  }
}
