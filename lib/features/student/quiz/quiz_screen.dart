import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_potensial/core/shared/widget/loading_widget.dart';
import 'package:test_potensial/core/theme/app_palette.dart';
import 'package:test_potensial/core/utils/extension_utils.dart';
import 'package:test_potensial/core/utils/map_index_utils.dart';
import 'package:test_potensial/core/utils/notification_dialog_utils.dart';
import 'package:test_potensial/features/profile/Widget/box_shadow.dart';
import 'package:test_potensial/features/student/quiz/cubit/quiz_thumbnail_cubit.dart';
import 'package:test_potensial/features/student/quiz_detail/bloc/quiz_detail_bloc.dart';

import '../../../core/routes/routes_pages.dart';
import '../../../core/shared/positioned/dimensions.dart';
import '../../../core/shared/text_style/text_app_style.dart';
import '../quiz_detail/domain/usecase/quiz_usecase.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Numeric', 'Logika', 'Verbal'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: Dimensions.screenWidht(context),
              height: 250,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 0,
                    bottom: Dimensions.minHeight5(context),
                    child: SizedBox(
                      width: Dimensions.screenWidht(context),
                      child: Image.asset(
                        'assets/materi-bg.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: Dimensions.height50(context),
                    left: Dimensions.widht20(context),
                    child: Text(
                      'Quiz Tes Potensi Akademik',
                      style: TextAppStyle.urbanistSemiBold.copyWith(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: Dimensions.height30(context),
                    left: Dimensions.widht20(context),
                    child: Text(
                      'by Waezqorney',
                      style: TextAppStyle.interLight.copyWith(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                color: Colors.white,
              ),
              child: BlocBuilder<QuizThumbnailCubit, QuizThumbnailState>(
                builder: (context, state) {
                  if (state is QuizThumbnailInitial) context.read<QuizThumbnailCubit>().getQuizThumbnail();
                  return switch (state) {
                    QuizThumbnailLoading() => const Loading(),
                    QuizThumbnailLoaded() => Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Kategori TPA',
                                  style: TextAppStyle.poppinsSemiBold.copyWith(fontSize: 20, color: AppPalette.quaternaryColor),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Select Category',
                                            style: TextAppStyle.poppinsMedium.copyWith(fontSize: 16),
                                          ),
                                          actions: _categories.mapIndexed<Widget, String>(
                                            funct: (index, value) {
                                              return RadioListTile(
                                                groupValue: _selectedCategory,
                                                value: value,
                                                title: Text(value),
                                                onChanged: (value) {
                                                  setState(() => _selectedCategory = value ?? '');
                                                  //QuizController.data.where((element) => element.jenis == _selectedCategory).toList();
                                                  Navigator.pop(context);
                                                },
                                              );
                                            },
                                          ).toList(),
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.menu,
                                    color: AppPalette.quaternaryColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          if (state.quizThumbnail.isEmpty)
                            Column(
                              children: [
                                Image.asset(
                                  'assets/no-data-quiz.png',
                                  width: 250,
                                ).paddingOnly(top: 50, bottom: 5),
                                Text(
                                  'Oops no data available',
                                  style: TextAppStyle.poppinsReguler.copyWith(
                                    fontSize: 12,
                                    color: AppPalette.quaternaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ...state.quizThumbnail.map(
                            (value) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                child: InkWell(
                                  onTap: () {
                                    if (!value.isDone) {
                                      notificationDialog(
                                        context: context,
                                        text:
                                            'Jika sudah berada dalam tes maka tidak bisa keluar. Anda akan mengikut Tes ${value.title}\n Apakah anda yakin?',
                                        onTap: () {
                                          context.read<QuizDetailBloc>().add(GetQuizDetailEvent(
                                                GetDetailQuizParams(value.quizId, value.type),
                                              ));
                                          Navigator.pop(context);
                                          Navigator.of(context).pushReplacement(Routes.detailQuiz(
                                            params: GetDetailQuizParams(value.quizId, value.type),
                                            title: value.title,
                                          ));
                                        },
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: 344,
                                    decoration: BoxDecoration(
                                      color: value.isDone == true ? Colors.grey : Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [shadow()],
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              height: 160,
                                              width: 145,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                color: AppPalette.tertiaryColor,
                                              ),
                                              child: value.image.isEmpty
                                                  ? Image.asset('assets/quiz-items.png')
                                                  : Image.network(value.image)),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Tes ${value.title}',
                                                style: TextAppStyle.poppinsBold.copyWith(
                                                  fontSize: 15,
                                                  color: AppPalette.quaternaryColor,
                                                ),
                                              ),
                                              Text(
                                                value.type,
                                                style: TextAppStyle.poppinsSemiBold.copyWith(
                                                  fontSize: 12,
                                                  color: AppPalette.quaternaryColor,
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                              // This text
                                              Text(
                                                textAlign: TextAlign.start,
                                                value.category,
                                                style: TextAppStyle.poppinsReguler.copyWith(
                                                  fontSize: 10,
                                                  color: AppPalette.quaternaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ).paddingAll(10),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    _ => const SizedBox(),
                  };
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
