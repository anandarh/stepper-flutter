import 'package:flutter/material.dart';

String? dateFormat(DateTime? dateTime) {
  String weekday = '';
  String month = '';

  switch (dateTime?.weekday) {
    case 1:
      weekday = 'Senin';
      break;

    case 2:
      weekday = 'Selasa';
      break;

    case 3:
      weekday = 'Rabu';
      break;

    case 4:
      weekday = 'Kamin';
      break;

    case 5:
      weekday = 'Jumat';
      break;

    case 6:
      weekday = 'Sabtu';
      break;

    case 7:
      weekday = 'Minggu';
      break;
  }

  switch (dateTime?.month) {
    case 1:
      month = 'Jan';
      break;

    case 2:
      month = 'Feb';
      break;

    case 3:
      month = 'Mar';
      break;

    case 4:
      month = 'Apr';
      break;

    case 5:
      month = 'Mei';
      break;

    case 6:
      month = 'Jun';
      break;

    case 7:
      month = 'Jul';
      break;

    case 8:
      month = 'Ags';
      break;

    case 9:
      month = 'Sep';
      break;

    case 10:
      month = 'Okt';
      break;

    case 11:
      month = 'Nov';
      break;

    case 12:
      month = 'Des';
      break;
  }

  return dateTime != null
      ? '$weekday, ${dateTime.day} $month ${dateTime.year}'
      : null;
}

String? timeFormat(TimeOfDay? timeOfDay) {
  return timeOfDay != null ? '${timeOfDay.hour}:${timeOfDay.minute}' : null;
}
