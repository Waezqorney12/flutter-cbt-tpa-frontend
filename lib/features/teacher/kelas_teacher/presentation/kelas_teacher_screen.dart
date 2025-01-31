import 'package:flutter/material.dart';
import 'package:test_potensial/core/routes/routes_pages.dart';
import 'package:test_potensial/core/shared/positioned/dimensions.dart';
import 'package:test_potensial/core/theme/app_palette.dart';
import 'package:test_potensial/core/utils/extension_utils.dart';
import 'package:test_potensial/features/profile/Widget/box_shadow.dart';
import 'package:test_potensial/features/teacher/kelas_teacher/presentation/kelas_teacher_controller.dart';

import '../../../../core/shared/text_style/text_app_style.dart';
import '../../../../core/utils/notification_dialog_utils.dart';
import '../widget/card_kelas_teacher_widget.dart';

class KelasTeacherScreen extends StatefulWidget {
  const KelasTeacherScreen({super.key});

  @override
  State<KelasTeacherScreen> createState() => _KelasTeacherScreenState();
}

class _KelasTeacherScreenState extends State<KelasTeacherScreen> {
  late KelasTeacherController _controller;

  @override
  void initState() {
    _controller = KelasTeacherController();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          switch (_controller.currentIndex) {
            case 0:
              Navigator.push(
                context,
                Routes.materiForm(),
              );
            case 1:
              Navigator.push(
                context,
                Routes.quizForm(),
              );
            default:
              notificationDialog(
                context: context,
                onTap: () => Navigator.pop(context),
                text: 'Unknown error occured',
              );
          }
        },
        backgroundColor: AppPalette.primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Container
                    Container(
                      height: 150,
                      width: Dimensions.screenWidht(context),
                      decoration: BoxDecoration(
                        borderRadius: _controller.isClicked
                            ? const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))
                            : BorderRadius.circular(8),
                        color: Colors.deepPurple,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Research Methodology',
                            style: TextAppStyle.poppinsMedium.copyWith(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Tuesday(2.00PM-4.00PM)',
                            style: TextAppStyle.poppinsReguler.copyWith(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Waezqorney Huanfareyzo',
                                style: TextAppStyle.poppinsMedium.copyWith(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _controller.isClicked = !_controller.isClicked;
                                  setState(() {});
                                },
                                child: const Icon(
                                  Icons.info,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )
                        ],
                      ).paddingAll(10),
                    ),
                    if (_controller.isClicked)
                      Container(
                        width: Dimensions.screenWidht(context),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: Colors.white,
                          boxShadow: [shadow()],
                        ),
                        child: Text.rich(
                          textAlign: TextAlign.start,
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Mata pelajaran',
                                style: TextAppStyle.poppinsSemiBold,
                              ),
                              TextSpan(
                                text: ' Research Methodology',
                                style: TextAppStyle.poppinsReguler,
                              ),
                            ],
                          ),
                        ).paddingAll(20),
                      ),
                    card(
                      iconCard: IconCard.pin,
                      context: context,
                      title: 'Your pin class',
                      subTitle: '65B792',
                    ).paddingSymmetric(vertical: 24),
                  ],
                ).paddingAll(24),
              ),
            ];
          },
          body: DefaultTabController(
            length: IndicatorColor.values.length,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Focus(
                  focusNode: _controller.focusNode,
                  onFocusChange: (value) => setState(() {}),
                  child: TextField(
                    controller: _controller.searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextAppStyle.poppinsMedium.copyWith(
                        fontSize: 16,
                        color: _controller.focusNode.hasFocus ? AppPalette.primaryColor.withOpacity(.7) : Colors.grey,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: _controller.focusNode.hasFocus ? AppPalette.primaryColor.withOpacity(.7) : Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppPalette.black.withOpacity(.4)),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppPalette.primaryColor.withOpacity(.7)),
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TabBar(
                  onTap: (value) => _controller.currentIndex = value,
                  indicatorColor: AppPalette.primaryColor,
                  tabs: IndicatorColor.values.map(
                    (title) {
                      return Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _controller.determineColor[title.index],
                              ),
                            ).paddingAll(10),
                            Text(title.name),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
                const SizedBox(height: 12),
                Flexible(
                  fit: FlexFit.loose,
                  child: TabBarView(
                    children: IndicatorColor.values.map(
                      (title) {
                        return ListView.builder(
                          itemCount: title.name == IndicatorColor.materi.name ? 15 : 5, // Adjust as needed
                          itemBuilder: (context, index) {
                            return title.name == IndicatorColor.materi.name
                                ? card(
                                    iconCard: IconCard.materi,
                                    context: context,
                                    isClickable: true,
                                    title: 'Asep panjaitan',
                                    subTitle: 'asep',
                                    boxShadow: BoxShadow(
                                      color: AppPalette.black.withOpacity(.35),
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                    ),
                                    subTitleColor: Colors.grey,
                                    isTitle: true,
                                  ).paddingAll(5)
                                : card(
                                    iconCard: IconCard.quiz,
                                    context: context,
                                    isClickable: true,
                                    title: 'Dadang panjaitan',
                                    subTitle: 'asep',
                                    boxShadow: BoxShadow(
                                      color: AppPalette.black.withOpacity(.35),
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                    ),
                                    subTitleColor: Colors.grey,
                                    isTitle: true,
                                  ).paddingAll(5);
                          },
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 24),
          ),
        ),
      ),
    );
  }
}
