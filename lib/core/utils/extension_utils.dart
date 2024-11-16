import 'package:flutter/material.dart';

extension PaddingWidget on Widget {
  Widget paddingAll(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  Widget paddingSymmetric({double vertical = 0, double horizontal = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: this,
    );
  }

  Widget paddingOnly({double left = 0, double right = 0, double top = 0, double bottom = 0}) {
    return Padding(
      padding: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      child: this,
    );
  }
}

extension WidgetExtension on Widget {
  SizedBox sized({double? w, double? h}) => SizedBox(
        width: w,
        height: h,
        child: this,
      );
}

extension ImageProviderExtension on ImageProvider {
  CircleAvatar imageProviderCircleAvatar({double? radius}) => CircleAvatar(
        radius: radius ?? 25,
        backgroundImage: this,
      );
  Container imageProviderContainer({double? w, double? h}) => Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: this,
            fit: BoxFit.cover,
          ),
          shape: BoxShape.circle,
        ),
      );
}
