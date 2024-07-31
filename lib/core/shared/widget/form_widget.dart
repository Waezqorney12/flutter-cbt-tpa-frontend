import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.inputType,
    this.obscureText,
    this.textStyle,
  });
  final String hintText;
  final TextEditingController controller;
  final TextInputType? inputType;
  final bool? obscureText;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: textStyle ?? const TextStyle(color: Colors.black),
      ),
      controller: controller,
      keyboardType: inputType ?? TextInputType.text,
      obscureText: obscureText ?? false,
      validator: (value) => value!.isEmpty ? "$hintText is missing" : null,
    );
  }
}
