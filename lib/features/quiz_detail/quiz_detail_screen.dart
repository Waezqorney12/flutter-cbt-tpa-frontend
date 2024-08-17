// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_potensial/core/shared/positioned/dimensions.dart';
import 'package:test_potensial/core/shared/text_style/text_app_style.dart';
import 'package:test_potensial/core/shared/widget/button_blended_widget.dart';
import 'package:test_potensial/core/shared/widget/loading_widget.dart';
import 'package:test_potensial/core/shared/widget/padding_widget.dart';
import 'package:test_potensial/core/theme/app_palette.dart';
import 'package:test_potensial/core/utils/show_snackbar_utils.dart';

import '../profile/Widget/box_shadow.dart';
import 'bloc/quiz_detail_bloc.dart';

class QuizDetailScreen extends StatefulWidget {
  final String category;
  const QuizDetailScreen({
    super.key,
    required this.category,
  });

  @override
  State<QuizDetailScreen> createState() => _QuizDetailScreenState();
}

class _QuizDetailScreenState extends State<QuizDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppPalette.primaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
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
          if (state is QuizDetailError) {
            showSnackBar(context, state.message);
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
                      state.quizEntities[0].pertanyaan,
                      style: TextAppStyle.montserratMedium.copyWith(
                        fontSize: 16,
                      ),
                    ).paddingAll(30),
                  ),
                  const SizedBox(height: 50),
                  buttonBlendedWidget(
                    text: state.quizEntities[0].jawabanA,
                    onTap: () {
                      print(state.quizEntities[0 + 1].jawabanA);
                      state.quizEntities[0 + 1].jawabanA;
                      setState(() {});
                    },
                    context: context,
                  ),
                  buttonBlendedWidget(
                    text: state.quizEntities[0].jawabanB,
                    onTap: () {},
                    context: context,
                  ).paddingSymmetric(vertical: 20),
                  buttonBlendedWidget(
                    text: state.quizEntities[0].jawabanC,
                    onTap: () {},
                    context: context,
                  ),
                  buttonBlendedWidget(
                    text: state.quizEntities[0].jawabanD,
                    onTap: () {},
                    context: context,
                  ).paddingSymmetric(vertical: 20)
                ],
              ).paddingAll(20),
            _ => const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text('No data available')),
                ],
              )
          };
        },
      ),
    );
  }
}
