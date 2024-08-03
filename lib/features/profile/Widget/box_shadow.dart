import 'package:flutter/material.dart';

BoxShadow shadow() {
    return BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      blurRadius: 10,
      offset: const Offset(0, 3),
    );
  }