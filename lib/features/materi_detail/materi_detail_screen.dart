import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_potensial/core/shared/text_style/text_app_style.dart';
import 'package:test_potensial/core/shared/widget/padding_widget.dart';
import 'package:test_potensial/core/theme/app_palette.dart';
import 'package:test_potensial/core/utils/custom_date_utils.dart';
import 'package:test_potensial/core/utils/debouncer.dart';
import 'package:test_potensial/features/materi/bloc/materi_bloc.dart';
import 'package:test_potensial/features/materi/domain/entities/materi_entities.dart';
import 'package:test_potensial/features/profile/Widget/box_shadow.dart';

class MateriDetailScreen extends StatefulWidget {
  final MateriEntities _materi;
  const MateriDetailScreen({super.key, required MateriEntities materi}) : _materi = materi;

  @override
  State<MateriDetailScreen> createState() => _MateriDetailScreenState();
}

class _MateriDetailScreenState extends State<MateriDetailScreen> {
  late ScrollController scrollController;
  Debouncer debouncer = Debouncer(milliseconds: 100);

  bool _showButton = true;

  /*
   cara ke 1 (Not valid one for this case because it's only for notify changes 
   not for positioning and animation some widget, for instance in this case is make button
   dissapear and appear which is not suitable if using this method)

   If u want use this make sure u using NotificationListener<ScrollNotification> and implement
   theses method in parameter of NotificationListener which is onNotification
  */
  // void _onStartScrolling(ScrollMetrics metrics) => setState(() => _showButton = false);
  // void _onUpdateScrolling(ScrollMetrics metrics) => setState(() => _showButton = true);
  // void _onEndScrolling(ScrollMetrics metrics) => setState(() => _showButton = false);

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_showButton) setState(() => _showButton = false);
    debouncer.run(() => setState(() => _showButton = true));
  }

  // void _scrollListener() {
  // Cara ke 3 (Not Working yet)
  // if (scrollController.position.userScrollDirection == ScrollDirection.reverse ||
  //     scrollController.position.userScrollDirection == ScrollDirection.forward) {
  //   if (_showButton) {
  //     setState(() {
  //       _showButton = false;
  //     });
  //   }
  // } else {
  //   if (!_showButton) {
  //     setState(() {
  //       _showButton = true;
  //     });
  //   }
  // }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppPalette.primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Materi TPA',
            style: TextAppStyle.montserratSemiBold.copyWith(
              fontSize: 18,
              color: AppPalette.primaryColor,
            ),
          ),
        ),
        body: BlocListener<MateriBloc, MateriState>(
          listener: (context, state) {
            if (state is MateriSuccess) Navigator.pop(context, widget._materi);
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      widget._materi.title ?? '',
                      style: TextAppStyle.montserratBold.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: RichText(
                        text: TextSpan(
                          text: 'oleh ',
                          style: TextAppStyle.montserratSemiBold.copyWith(
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(
                              text: widget._materi.name,
                              style: TextAppStyle.montserratSemiBold.copyWith(
                                color: AppPalette.primaryColor,
                              ),
                            ),
                            TextSpan(
                              text: ' Created at ${AppDateUtil.formatDateTime(
                                dateTime: widget._materi.dateTime,
                                format: CustomDateFormat.dateTime,
                              )} WIB',
                              style: TextAppStyle.montserratSemiBold.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ).paddingAll(15),
                Image.network(
                  widget._materi.image ?? '',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Text(
                  widget._materi.description ?? '',
                  style: TextAppStyle.interReguler.copyWith(
                    fontSize: 16,
                  ),
                ).paddingAll(15),
              ],
            ),
          ),
        ),
        bottomNavigationBar: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _showButton ? 50 : 0,
          child: Material(
            elevation: 10,
            child: GestureDetector(
              onTap: () {
                context.read<MateriBloc>().add(
                      UpdateMateriEvent(
                        id: widget._materi.id ?? 0,
                      ),
                    );
              },
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [shadow()],
                ),
                child: Center(
                  child: Text(
                    'Selesai',
                    style: TextAppStyle.montserratSemiBold.copyWith(
                      fontSize: 16,
                      color: AppPalette.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
