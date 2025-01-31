import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_potensial/core/routes/routes_pages.dart';
import 'package:test_potensial/core/shared/positioned/dimensions.dart';
import 'package:test_potensial/core/shared/text_style/text_app_style.dart';
import 'package:test_potensial/core/shared/widget/loading_widget.dart';
import 'package:test_potensial/core/theme/app_palette.dart';
import 'package:test_potensial/core/utils/extension_utils.dart';
import 'package:test_potensial/core/utils/show_snackbar_utils.dart';
import 'package:test_potensial/features/profile/Widget/box_shadow.dart';

import '../bloc/quiz_nilai_bloc.dart';

class QuizNilaiScreen extends StatelessWidget {
  const QuizNilaiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: container(
            child: GestureDetector(
          onTap: () => Navigator.push(context, Routes.nav()),
          child: const Icon(
            Icons.close,
            color: AppPalette.textHasilColor,
          ),
        )).paddingAll(10),
        actions: [
          container(
            height: 35,
            width: 35,
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.share,
                color: AppPalette.textHasilColor,
              ),
            ),
          ).paddingOnly(right: Dimensions.widht10(context))
        ],
        title: Text(
          'Summary',
          style: TextAppStyle.montserratBold.copyWith(
            fontSize: 18,
            color: AppPalette.textHasilColor,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<QuizNilaiBloc, QuizNilaiState>(
        listener: (context, state) {
          if (state is QuizNilaiError) showSnackBar(context, state.message);
        },
        builder: (context, state) {
          return switch (state) {
            QuizNilaiLoading() => const Loading(),
            QuizNilaiSuccess() => Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset('assets/trophy.png').sized(h: 200, w: 200),
                  ),
                  Text(
                    'Performance stats',
                    style: TextAppStyle.montserratSemiBold.copyWith(
                      fontSize: 16,
                      color: AppPalette.textHasilColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      container(
                        height: 40,
                        width: 85,
                        circular: 6,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.check, color: Colors.green),
                                Text(
                                  state.nilai.totalBenar.toString(),
                                  style: TextAppStyle.poppinsBold.copyWith(fontSize: 14),
                                )
                              ],
                            ),
                            Text(
                              'Benar',
                              style: TextAppStyle.poppinsSemiBold.copyWith(
                                fontSize: 10,
                                color: AppPalette.textHasilColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 30),
                      container(
                        height: 40,
                        width: 85,
                        circular: 6,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.close, color: Colors.red),
                                Text(
                                  state.nilai.totalSalah.toString(),
                                  style: TextAppStyle.poppinsBold.copyWith(fontSize: 14),
                                )
                              ],
                            ),
                            Text(
                              'Salah',
                              style: TextAppStyle.poppinsSemiBold.copyWith(
                                fontSize: 10,
                                color: AppPalette.textHasilColor,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ).paddingSymmetric(vertical: 20),
                  container(
                    height: 40,
                    width: 85,
                    circular: 6,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.timer_outlined, color: Colors.green.shade500),
                            Text(
                              '3 s',
                              style: TextAppStyle.poppinsBold.copyWith(fontSize: 14),
                            )
                          ],
                        ),
                        Text(
                          'Waktu',
                          style: TextAppStyle.poppinsSemiBold.copyWith(
                            fontSize: 10,
                            color: AppPalette.textHasilColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  container(
                    height: 80,
                    width: Dimensions.screenWidht(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          'Accuracy: ${state.nilai.score}%',
                          style: TextAppStyle.montserratSemiBold.copyWith(
                            fontSize: 14,
                            color: AppPalette.textHasilColor,
                          ),
                        ),
                        LinearProgressIndicator(
                          backgroundColor: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                          value: state.nilai.totalNilai.toDouble() / 100,
                          color: Colors.green,
                          minHeight: 10,
                        ).paddingSymmetric(vertical: 15),
                      ],
                    ).paddingSymmetric(horizontal: 15),
                  ).paddingSymmetric(vertical: 30),
                  ElevatedButton(
                    onPressed: () => Navigator.push(context, Routes.nav()),
                    child: Center(
                      child: Text(
                        'Kembali ke beranda',
                        style: TextAppStyle.montserratSemiBold.copyWith(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  container(
                    height: 50,
                    width: Dimensions.screenWidht(context),
                    child: Center(
                      child: Text(
                        'Coba tes lainnya',
                        style: TextAppStyle.montserratSemiBold.copyWith(
                          fontSize: 14,
                          color: AppPalette.primaryColor,
                        ),
                      ),
                    ),
                  ).paddingSymmetric(vertical: 25)
                ],
              ).paddingSymmetric(horizontal: 25),
            _ => const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Loading()],
              ),
          };
        },
      ),
    );
  }

  Container container({required Widget child, double? height, double? width, double? circular, Color? color}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(circular ?? 12),
        boxShadow: [shadow()],
        color: color ?? Colors.white,
      ),
      child: child,
    );
  }
}
