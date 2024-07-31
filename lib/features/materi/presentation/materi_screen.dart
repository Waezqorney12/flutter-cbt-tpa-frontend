import 'package:flutter/material.dart';
import 'package:test_potensial/core/shared/positioned/dimensions.dart';
import 'package:test_potensial/core/shared/text_style/text_app_style.dart';
import 'package:test_potensial/core/theme/app_palette.dart';
import 'package:test_potensial/core/utils/calculate_reading_time_utils.dart';
import 'package:test_potensial/core/utils/map_index_utils.dart';
import 'package:test_potensial/features/materi/controller/materi_controller.dart';

class MateriScreen extends StatelessWidget {
  const MateriScreen({super.key});

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
                    'Materi Tes Potensi Akademik',
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
            width: Dimensions.screenWidht(context),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Row(
                      children: [
                        Text(
                          '${MateriController.data.length} Materi',
                          style: TextAppStyle.urbanistSemiBold.copyWith(fontSize: 16),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.history,
                          color: AppPalette.boardingTextColor.withOpacity(.6),
                          size: 18,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "${calculateReadingTime(MateriController.data.map((e) => e['content']).join(' '))}min",
                          style: TextAppStyle.interLight.copyWith(
                            color: AppPalette.boardingTextColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 25),
                    child: Text(
                      textAlign: TextAlign.justify,
                      'Soal Tes Potensi Akademik penting untuk membantu Anda menjawab soal-soal dalam aplikasi ini. Konten ini berisi beberapa item yang akan membantu Anda menjawab pertanyaan. Semangat belajar!',
                      style: TextAppStyle.interLight.copyWith(color: AppPalette.boardingTextColor),
                    ),
                  ),
                  ...MateriController.data.mapIndexed<Widget, Map<String, dynamic>>(
                    funct: (index, val) {
                      return Padding(
                        padding: index == 0 ? const EdgeInsets.only(bottom: 16) : const EdgeInsets.symmetric(vertical: 16),
                        child: InkWell(
                          onTap: () => print('opbe'),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: AppPalette.boardingTextColor.withOpacity(.6),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            val['title'],
                                            style: TextAppStyle.urbanistSemiBold.copyWith(
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            "${calculateReadingTime(val['content'])} min read",
                                            style: TextAppStyle.interReguler.copyWith(
                                              color: Colors.grey,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Color(int.parse('0xFF${val['color']}')),
                                          borderRadius: BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: AssetImage(
                                              val['image'],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    '17 hours ago',
                                    style: TextAppStyle.interReguler.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: LinearProgressIndicator(
                                      value: 1.0,
                                      color: AppPalette.baseGreen,
                                      //Color(int.parse('0xFF${val['color']}')),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
