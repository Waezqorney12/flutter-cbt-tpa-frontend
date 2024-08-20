import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_potensial/core/theme/app_palette.dart';
import 'package:test_potensial/core/utils/map_index_utils.dart';
import 'package:test_potensial/core/utils/notification_dialog_utils.dart';
import 'package:test_potensial/features/profile/Widget/box_shadow.dart';
import 'package:test_potensial/features/quiz/quiz_controller.dart';
import 'package:test_potensial/features/quiz_detail/bloc/quiz_detail_bloc.dart';

import '../../core/routes/routes_pages.dart';
import '../../core/shared/positioned/dimensions.dart';
import '../../core/shared/text_style/text_app_style.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

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
                    bottom: -5,
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
              child: BlocListener<QuizDetailBloc, QuizDetailState>(
                listener: (context, state) {},
                child: Column(children: [
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
                          onPressed: () {},
                          icon: const Icon(
                            Icons.menu,
                            color: AppPalette.quaternaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  ...QuizController.data.mapIndexed<Widget, QuizCategoryModel>(
                    funct: (index, value) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: InkWell(
                          onTap: () {
                            notificationDialog(
                              context: context,
                              text:
                                  'Jika sudah berada dalam tes maka tidak bisa keluar. Anda akan mengikut Tes ${value.title}\n Apakah anda yakin?',
                              onTap: () {
                                context.read<QuizDetailBloc>().add(GetQuizDetailEvent(value.title));
                                Navigator.pop(context);
                                Navigator.of(context).pushReplacement(Routes.detailQuiz(value.title));
                              },
                            );
                          },
                          child: Container(
                            width: 344,
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                                    child: Image.asset('assets/quiz-items.png'),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
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
                                        value.jenis,
                                        style: TextAppStyle.poppinsSemiBold.copyWith(
                                          fontSize: 12,
                                          color: AppPalette.quaternaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        value.content,
                                        style: TextAppStyle.poppinsReguler.copyWith(
                                          fontSize: 10,
                                          color: AppPalette.quaternaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
