import 'package:flutter/material.dart';
import 'package:gin_finans/common/constant/strings.dart';
import 'package:gin_finans/feature/register/screen/screen_one.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: ThemeData(
          primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.blue),
      home: ScreenOne(),
    );
  }
}
