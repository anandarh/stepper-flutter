import 'package:flutter/material.dart';
import 'package:gin_finans/common/constant/strings.dart';

class RegisterAppBar extends StatefulWidget implements PreferredSizeWidget {
  const RegisterAppBar(this.currentStep, {this.onTap});

  /// The index into [steps] of the current step whose content is displayed.
  final int currentStep;

  /// Signature for when a tap has occurred.
  final GestureTapCallback? onTap;

  @override
  _RegisterAppBarState createState() => _RegisterAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _RegisterAppBarState extends State<RegisterAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: widget.currentStep > 0 ? GestureDetector(
        child: Icon(Icons.arrow_back),
        onTap: widget.onTap,
      ) : null,
      title: widget.currentStep > 0 ? Text(Strings.createAccount) : null,
      backgroundColor: Colors.blue[800],
      elevation: 0,
    );
  }
}
