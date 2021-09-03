import 'package:flutter/material.dart';
import 'package:gin_finans/common/constant/strings.dart';
import 'package:gin_finans/feature/register/screen/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.blue,
          textTheme: TextTheme(
            bodyText1: TextStyle(
              color: Colors.white,
            ),
            headline5: TextStyle(
              color: Colors.white,
            ),
          )),
      home: RegistrationScreen(),
    );
  }
}
