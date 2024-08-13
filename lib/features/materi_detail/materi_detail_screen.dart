import 'package:flutter/material.dart';
import 'package:test_potensial/core/shared/text_style/text_app_style.dart';
import 'package:test_potensial/core/shared/widget/padding_widget.dart';
import 'package:test_potensial/core/theme/app_palette.dart';
import 'package:test_potensial/core/utils/custom_date_utils.dart';
import 'package:test_potensial/features/materi/domain/entities/materi_entities.dart';

class MateriDetailScreen extends StatelessWidget {
  final MateriEntities _materi;
  const MateriDetailScreen({super.key, required MateriEntities materi}) : _materi = materi;

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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    _materi.title,
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
                            text: _materi.name,
                            style: TextAppStyle.montserratSemiBold.copyWith(
                              color: AppPalette.primaryColor,
                            ),
                          ),
                          TextSpan(
                            text: ' Created at ${AppDateUtil.formatDateTime(
                              dateTime: _materi.dateTime,
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
                _materi.image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              Text(
                _materi.description,
                style: TextAppStyle.interReguler.copyWith(
                  fontSize: 16,
                ),
              ).paddingAll(15),
            ],
          ),
        ));
  }
}
