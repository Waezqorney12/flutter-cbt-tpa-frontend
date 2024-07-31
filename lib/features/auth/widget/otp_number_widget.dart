import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_potensial/core/shared/text_style/text_app_style.dart';

Widget otpNumberWidget(BuildContext context, {required TextEditingController controller}) {
  return SizedBox(
    height: 66,
    width: 66,
    child: TextFormField(
      style: TextAppStyle.poppinsMedium.copyWith(fontSize: 20),
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      controller: controller,
      onChanged: (value) {
        if (value.length == 1) FocusScope.of(context).nextFocus();
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
