import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_potensial/core/shared/positioned/dimensions.dart';
import 'package:test_potensial/core/shared/text_style/text_app_style.dart';
import 'package:test_potensial/core/shared/widget/loading_widget.dart';
import 'package:test_potensial/core/theme/app_palette.dart';
import 'package:test_potensial/core/utils/calculate_date_utils.dart';
import 'package:test_potensial/core/utils/map_index_utils.dart';
import 'package:test_potensial/core/utils/regex_utils.dart';
import 'package:test_potensial/core/utils/show_snackbar_utils.dart';

import '../../materi_detail/materi_detail_screen.dart';
import 'bloc/materi_bloc.dart';

class MateriScreen extends StatefulWidget {
  const MateriScreen({super.key});

  @override
  State<MateriScreen> createState() => _MateriScreenState();
}

class _MateriScreenState extends State<MateriScreen> {
  String? _selectedCategory = 'Logika';
  final List<String> _categories = ['All', 'Logika', 'Numeric', 'Verbal'];
  late final CalendarUtils _calendarUtils;
  @override
  void initState() {
    _calendarUtils = CalendarUtils(
      start: DateTime(1945, 1, 1),
      end: DateTime(9999, 1, 1),
    );
    super.initState();
  }

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
                    child: BlocBuilder<MateriBloc, MateriState>(
                      builder: (context, state) {
                        return switch (state) {
                          MateriLoading() => const Loading(),
                          MateriLoaded() => Row(
                              children: [
                                Text(
                                  '${state.materi.length} Materi',
                                  style: TextAppStyle.urbanistSemiBold.copyWith(fontSize: 16),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: Icon(
                                    Icons.history,
                                    color: AppPalette.boardingTextColor.withOpacity(.6),
                                    size: 18,
                                  ),
                                ),
                                Text(
                                  "${calculateTotalReadingTime<String?>(
                                    state.materi.map((e) => e.materi?.description).toList(),
                                  )}min",
                                  style: TextAppStyle.interLight.copyWith(
                                    color: AppPalette.boardingTextColor,
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              'Select Category',
                                              style: TextAppStyle.poppinsMedium.copyWith(fontSize: 16),
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: _categories.mapIndexed<Widget, String>(
                                                funct: (index, category) {
                                                  return RadioListTile(
                                                    groupValue: _selectedCategory,
                                                    value: category,
                                                    title: Text(category),
                                                    onChanged: (value) {
                                                      setState(() => _selectedCategory = value ?? '');
                                                      if (value == 'All') _selectedCategory = null;
                                                      context
                                                          .read<MateriBloc>()
                                                          .add(GetAllMateriEvent(kategori: _selectedCategory));
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                                },
                                              ).toList(),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.menu,
                                      color: AppPalette.boardingTextColor,
                                    )),
                              ],
                            ),
                          _ => Text(
                              'No data',
                              style: TextAppStyle.urbanistSemiBold.copyWith(
                                fontSize: 18,
                                color: AppPalette.boardingTextColor,
                              ),
                            ),
                        };
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      textAlign: TextAlign.justify,
                      'Soal Tes Potensi Akademik penting untuk membantu Anda menjawab soal-soal dalam aplikasi ini. Konten ini berisi beberapa item yang akan membantu Anda menjawab pertanyaan. Semangat belajar!',
                      style: TextAppStyle.interLight.copyWith(color: AppPalette.boardingTextColor),
                    ),
                  ),
                  BlocConsumer<MateriBloc, MateriState>(
                    listener: (context, state) {
                      if (state is MateriError) showSnackBar(context, state.message);
                    },
                    builder: (context, state) {
                      if (state is MateriInitial) {
                        context.read<MateriBloc>().add(const GetAllMateriEvent());
                      }
                      return switch (state) {
                        MateriLoading() => const Loading(),
                        MateriLoaded() => ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.materi.length,
                            itemBuilder: (context, index) {
                              final value = state.materi[index];
                              Duration waktu = DateTime.now().difference(value.createdAt ?? DateTime.now());
                              int range = _calendarUtils.daysInMonth(
                                value.createdAt?.year ?? 0,
                                value.createdAt?.month ?? 0,
                              );
                              return Padding(
                                padding:
                                    index == 0 ? const EdgeInsets.only(bottom: 16) : const EdgeInsets.symmetric(vertical: 16),
                                child: InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MateriDetailScreen(
                                        materi: value,
                                      ),
                                    ),
                                  ),
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
                                                    "Materi ${value.kategori}",
                                                    style: TextAppStyle.urbanistSemiBold.copyWith(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${calculateReadingTime(value.materi?.description ?? '')} min read",
                                                        style: TextAppStyle.interReguler.copyWith(
                                                          color: Colors.grey,
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                                        child: Container(
                                                          height: 5,
                                                          width: 5,
                                                          decoration: const BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Created ${waktu.getCalendarDiffer(month: range)}',
                                                        style: TextAppStyle.interReguler.copyWith(
                                                          color: Colors.grey,
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Hero(
                                                tag: 'image${value.id}',
                                                child: Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: CachedNetworkImageProvider(value.materi?.image ?? ''),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          LinearProgressIndicator(
                                            value: value.status != null ? value.status! / 100 : 0,
                                            color: value.status == 100 ? AppPalette.baseGreen : AppPalette.primaryColor,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5),
                                            child: Text(
                                              'Progress ${value.status}%',
                                              style: TextAppStyle.interReguler.copyWith(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        _ => const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [Text('No data available')],
                          )
                      };
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
