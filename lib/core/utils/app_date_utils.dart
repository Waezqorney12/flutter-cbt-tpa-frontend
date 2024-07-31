// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// enum CustomDateFormat { date, dateTime, dayDate, dayDateTime, hourMinute, dateMonth, day, customDate, taskDeadline }

// class AppDateUtil {
//   AppDateUtil();

//   static String formatDateTime({
//     DateTime? dateTime,
//     CustomDateFormat format = CustomDateFormat.date,
//     Locale locale = const Locale('en', 'EN'),
//   }) {
//     switch (format) {
//       case CustomDateFormat.date:
//         return DateFormat('dd MMMM yyyy', locale.toString()).format(dateTime ?? DateTime.now());
//       case CustomDateFormat.dateTime:
//         return DateFormat('dd MMMM yyyy, HH:mm', locale.toString()).format(dateTime ?? DateTime.now());
//       case CustomDateFormat.dayDate:
//         return DateFormat('EEEE, dd MMMM yyyy', locale.toString()).format(dateTime ?? DateTime.now());
//       case CustomDateFormat.dayDateTime:
//         return DateFormat('EEEE, dd MMMM yyyy, HH:mm', locale.toString()).format(dateTime ?? DateTime.now());
//       case CustomDateFormat.hourMinute:
//         return DateFormat('HH:mm', locale.toString()).format(dateTime ?? DateTime.now());
//       case CustomDateFormat.dateMonth:
//         return DateFormat('dd MMMM', locale.toString()).format(dateTime ?? DateTime.now());
//       case CustomDateFormat.day:
//         return DateFormat('EEEE', locale.toString()).format(dateTime ?? DateTime.now());
//       case CustomDateFormat.taskDeadline:
//         return DateFormat('yyyy/MM/dd', locale.toString()).format(dateTime ?? DateTime.now());
//       case CustomDateFormat.customDate:
//         return "${dateTime?.day}/${dateTime?.month}/${dateTime?.year}";
//     }
//   }
// }
