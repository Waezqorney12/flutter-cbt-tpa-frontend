import 'package:flutter/material.dart';
import 'package:test_potensial/core/shared/text_style/text_app_style.dart';
import 'package:test_potensial/core/theme/app_palette.dart';

class DropDownWidget extends StatefulWidget {
  final double widht;
  final String hintText;
  String? selectedItems;
  List<DropdownMenuItem<String>>? items;
  ValueChanged<String?>? onChanged;
  bool enabled;

  DropDownWidget({
    super.key,
    required this.widht,
    required this.hintText,
    this.selectedItems,
    this.onChanged,
    this.enabled = true,
    this.items,
  });

  @override
  State<DropDownWidget> createState() => DrowDownWidgetState();
}

class DrowDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      elevation: 10,
      child: Container(
        width: widget.widht,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            style: TextAppStyle.poppinsMedium.copyWith(
              fontSize: 16,
              color: AppPalette.black,
            ),
            icon: const Expanded(child: Icon(Icons.keyboard_arrow_down_rounded)),
            borderRadius: BorderRadius.circular(8),
            hint: Text(
              widget.hintText,
              style: TextAppStyle.poppinsMedium.copyWith(
                fontSize: 16,
                color: AppPalette.black,
              ),
            ),
            value: widget.selectedItems,
            items: widget.items,
            onChanged: widget.enabled
                ? (value) {
                    setState(() => widget.selectedItems = value as String?);
                    if (widget.onChanged != null) widget.onChanged!(value as String?);
                  }
                : null,
          ),
        ),
      ),
    );
  }
}
