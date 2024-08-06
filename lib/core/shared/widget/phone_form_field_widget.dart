import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:test_potensial/core/shared/text_style/text_app_style.dart';
import 'package:test_potensial/core/theme/app_palette.dart';

class PhoneFormField extends StatefulWidget {
  const PhoneFormField({super.key, required this.controller, required this.onCountryChanged, this.countryCode, this.onChanged});
  final TextEditingController controller;
  final void Function(Country)? onCountryChanged;
  final String? countryCode;
  final void Function(PhoneNumber)? onChanged;

  @override
  State<PhoneFormField> createState() => _PhoneFormFieldState();
}

class _PhoneFormFieldState extends State<PhoneFormField> {
  final focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    focus.addListener(() => setState(() {}));
    return IntlPhoneField(
      initialCountryCode: widget.countryCode ?? '',
      controller: widget.controller,
      onCountryChanged: widget.onCountryChanged,
      onChanged: widget.onChanged,
      style: TextAppStyle.interReguler.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: 'Nomor telepon',
        hintStyle: TextAppStyle.interReguler.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        counterText: "",
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppPalette.primaryColor),
        ),
        filled: true,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      ),
      focusNode: focus,
    );
  }
}
