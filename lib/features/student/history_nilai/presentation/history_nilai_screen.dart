import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_potensial/core/shared/positioned/dimensions.dart';
import 'package:test_potensial/core/shared/widget/loading_widget.dart';
import 'package:test_potensial/core/utils/extension_utils.dart';
import 'package:test_potensial/core/utils/map_index_utils.dart';
import 'package:test_potensial/core/utils/show_snackbar_utils.dart';
import 'package:test_potensial/features/student/history_nilai/domain/entities/history_nilai_entities.dart';
import 'package:test_potensial/features/student/history_nilai/presentation/cubit/history_nilai_cubit.dart';
import 'package:test_potensial/features/profile/Widget/box_shadow.dart';

import '../../../../core/shared/text_style/text_app_style.dart';
import '../../../../core/theme/app_palette.dart';

class HistoryNilaiScreen extends StatelessWidget {
  const HistoryNilaiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'History Nilai',
            style: TextAppStyle.montserratSemiBold.copyWith(
              fontSize: 18,
              color: AppPalette.primaryColor,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<HistoryNilaiCubit, HistoryNilaiState>(
          listener: (context, state) {
            if (state is HistoryNilaiError) showSnackBar(context, state.message);
          },
          builder: (context, state) {
            if (state is HistoryNilaiInitial) context.read<HistoryNilaiCubit>().getHistoryNilai();
            return switch (state) {
              HistoryNilaiLoading() => const Loading(),
              HistoryNilaiLoaded() => Column(
                      children: state.entities
                          .mapIndexed<Widget, HistoryNilaiEntities>(
                            funct: (index, value) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              height: 60,
                              width: Dimensions.screenWidht(context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.circular(12),
                                color: Colors.white,
                                boxShadow: [shadow()],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hasil Tes ${index + 1}',
                                        style: TextAppStyle.montserratSemiBold.copyWith(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        value.hasil == null
                                            ? 'Belum Dikerjakan'
                                            : (value.hasil! < 70)
                                                ? 'Tidak Lulus'
                                                : 'Lulus',
                                        style: TextAppStyle.montserratSemiBold.copyWith(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.grey,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          ((value.nilaiAngka ?? 0) + (value.nilaiLogika ?? 0) + (value.nilaiVerbal ?? 0)) / 3 < 70
                                              ? Colors.red
                                              : Colors.green),
                                      value:
                                          (((value.nilaiAngka ?? 0) + (value.nilaiLogika ?? 0) + (value.nilaiVerbal ?? 0)) / 3) /
                                              100,
                                    ),
                                  ),
                                ],
                              ),
                            ).paddingSymmetric(vertical: 15),
                          )
                          .toList())
                  .paddingAll(25),
              _ => const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Text('No data available')],
                )
            };
          },
        ));
  }
}
