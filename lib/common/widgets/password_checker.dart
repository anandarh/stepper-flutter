import 'package:flutter/material.dart';
import 'package:gin_finans/common/constant/strings.dart';
import '../utils/string_validator.dart';

/// An indicator widget to display the composition checklist
/// of an entered password.
///
/// Displayed indicators: isLowercase, isUppercase, isNumber and isCharacter
class PasswordChecker extends StatefulWidget {
  const PasswordChecker({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  _PasswordCheckerState createState() => _PasswordCheckerState();
}

class _PasswordCheckerState extends State<PasswordChecker> {
  bool isLowercase = false;
  bool isUppercase = false;
  bool isNumber = false;
  bool isCharacter = false;

  @override
  void initState() {
    widget.controller.addListener(() {
      isLowercase = widget.controller.text.isLowercase;
      isUppercase = widget.controller.text.isUppercase;
      isNumber = widget.controller.text.isNumber;
      isCharacter = widget.controller.text.isCharacter;
      if (mounted) {
        setState(() {
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _iconPasswordChecker(isLowercase, 'a', Strings.lowercase),
        _iconPasswordChecker(isUppercase, 'A', Strings.uppercase),
        _iconPasswordChecker(isNumber, '123', Strings.number),
        _iconPasswordChecker(isCharacter, '9+', Strings.characters)
      ],
    );
  }

  Widget _iconPasswordChecker(bool checked, String text, String information) {
    return Column(
      children: [
        Container(
          width: checked ? 30 : 50,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: checked ? Colors.green : null),
          child: checked
              ? Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                )
              : Text(
                  text,
                  style: Theme.of(context).textTheme.headline5,
                ),
        ),
        Text(
          information,
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }
}

/// An indicator widget to show the level of complexity of an entered password.
///
/// Level of complexity: Weak, Medium, and Strong.
class StrengthChecker extends StatefulWidget {
  const StrengthChecker({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  _StrengthCheckerState createState() => _StrengthCheckerState();
}

class _StrengthCheckerState extends State<StrengthChecker> {
  String _strength = '';
  Color _strenghtColor = Colors.red;

  @override
  void initState() {
    widget.controller.addListener(() {
      _strength = widget.controller.text.strengthLevel;
      _switchColor();
      if (mounted) {
        setState(() {
        });
      }
    });
    super.initState();
  }

  void _switchColor() {
    switch (_strength) {
      case 'Strong':
        _strenghtColor =  Colors.green;
        break;

      case 'Medium':
        _strenghtColor =  Colors.orange;
        break;

      default:
        _strenghtColor=  Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${Strings.complexity}:',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(width: 5),
        Text(
          _strength,
          style: TextStyle(
              color: _strenghtColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

