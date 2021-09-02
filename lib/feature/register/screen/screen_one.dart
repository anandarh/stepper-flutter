import 'package:flutter/material.dart';
import 'package:gin_finans/common/constant/strings.dart';

class ScreenOne extends StatefulWidget {
  ScreenOne({Key? key}) : super(key: key);

  @override
  _ScreenOneState createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: Strings.welcomeTo,
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                children: const <TextSpan>[
                  TextSpan(
                    text: '\n${Strings.gin} ',
                  ),
                  TextSpan(
                    text: Strings.finans,
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(Strings.slogan),
            ),
            Spacer(),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: Strings.email,
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {},
                child: Text(Strings.next))
          ],
        ),
      ),
    );
  }
}
