import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String _kSave = 'SAVE';
const String _kCancel = 'SAVE';

/// Open native-like DatePicker / TimePicker in the Target platform
class DateTimePicker {
  DateTimePicker._();

  static Future<DateTime?> pickDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return await _buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return await _buildCupertinoDatePicker(context);
    }
  }

  static Future<TimeOfDay?> pickTime(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return await _buildMaterialTimePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return await _buildCupertinoTimePicker(context);
    }
  }

  /// This builds material date picker in Android
  static Future<DateTime?> _buildMaterialDatePicker(
      BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        cancelText: _kCancel,
        confirmText: _kSave);
    return picked;
  }

  /// This builds material time picker in Android
  static Future<TimeOfDay?> _buildMaterialTimePicker(
      BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      cancelText: _kCancel,
      confirmText: _kSave,
    );
    return picked;
  }

  /// This builds cupertino date picker in iOS
  static Future<DateTime?> _buildCupertinoDatePicker(
      BuildContext context) async {
    DateTime _selectedDate = DateTime.now();
    DateTime? result;
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (picked) {
                      if (picked != _selectedDate) _selectedDate = picked;
                    },
                    initialDateTime: _selectedDate,
                    minimumYear: _selectedDate.year,
                    maximumYear: 2025,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CupertinoButton(
                      child: Text(_kSave),
                      onPressed: () {
                        result = _selectedDate;
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text(_kCancel),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                )
              ],
            ),
          );
        });
    return result;
  }

  /// This builds cupertino time picker in iOS
  static Future<TimeOfDay?> _buildCupertinoTimePicker(
      BuildContext context) async {
    TimeOfDay _currentTime = TimeOfDay.now();
    TimeOfDay? _selectedTime;
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: CupertinoTimerPicker(
                    mode: CupertinoTimerPickerMode.hm,
                    onTimerDurationChanged: (picked) {
                      _currentTime.replacing(
                          hour: picked.inHours, minute: picked.inMinutes);
                    },
                    initialTimerDuration: Duration(
                        hours: _currentTime.hour, minutes: _currentTime.minute),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CupertinoButton(
                      child: Text(_kSave),
                      onPressed: () {
                        _selectedTime = _currentTime;
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text(_kCancel),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                )
              ],
            ),
          );
        });
    return _selectedTime;
  }
}
