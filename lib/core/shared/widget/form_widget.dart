import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FormWidget extends StatelessWidget {
  FormWidget(
      {super.key,
      required this.hintText,
      required this.controller,
      this.inputType,
      this.obscureText,
      this.textStyle,
      this.validatedText,
      this.validator,
      this.onSaved,
      this.onChanged});
  final String hintText;
  final String? validatedText;
  final TextEditingController controller;
  final TextInputType? inputType;
  final bool? obscureText;
  final TextStyle? textStyle;
  final void Function(String?)? onSaved;
  String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        hintStyle: textStyle ?? const TextStyle(color: Colors.black),
      ),
      controller: controller,
      keyboardType: inputType ?? TextInputType.text,
      obscureText: obscureText ?? false,
      validator: validator ??
          (value) => value!.isEmpty
              ? validatedText?.isNotEmpty ?? false
                  ? "$validatedText is missing"
                  : "$hintText is missing"
              : null,
    );
  }
}
