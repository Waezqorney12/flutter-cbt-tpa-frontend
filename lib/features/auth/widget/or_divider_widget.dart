import 'package:flutter/material.dart';

Widget orDivederWidget(BuildContext context, {required double widht}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 1,
            color: Colors.grey,
            width: widht / 3,
          ),
          const Text('OR'),
          Container(
            height: 1,
            color: Colors.grey,
            width: widht / 3,
          ),
        ],
      ),
    ),
  );
}
