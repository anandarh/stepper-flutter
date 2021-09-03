import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gin_finans/common/constant/dimens.dart';
import 'package:gin_finans/common/constant/strings.dart';
import 'package:gin_finans/common/utils/date_time_format.dart';
import 'package:gin_finans/common/utils/form_validator.dart';
import 'package:gin_finans/common/widgets/date_picker.dar.dart';
import 'package:gin_finans/common/widgets/password_checker.dart';
import 'package:gin_finans/common/widgets/stepper_widget.dart';
import 'package:gin_finans/feature/register/widget/animated_calendar_icon.dart';
import 'package:gin_finans/feature/register/widget/background_clip.dart';
import 'package:gin_finans/feature/register/widget/register_app_bar.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  final List<String> _options = <String>[
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 5',
  ];

  int _currentStep = 0;
  bool _showPassword = false;
  bool _isComplete = false;
  String? _goalActivationValue;
  String? _monthlyIncomeValue;
  String? _monthlyExpenseValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      appBar: RegisterAppBar(
        _currentStep,
        onTap: _back,
      ),
      body: Stack(
        children: [
          BackgroundClipper(
            color: _currentStep == 0 ? Colors.white : Colors.transparent,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: StepperWidget(
                    elevation: 0,
                    indicatorBackgroundColor: Colors.transparent,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: Dimens.vertical_padding,
                        horizontal: Dimens.horizontal_padding),
                    physics: ScrollPhysics(),
                    currentStep: _currentStep,
                    onStepTapped: (step) => _tapped(step),
                    onStepContinue: _continue,
                    controlsBuilder: (BuildContext context,
                        {VoidCallback? onStepContinue,
                        VoidCallback? onStepCancel}) {
                      return Container();
                    },
                    steps: <StepperStep>[
                      _stepOne,
                      _stepTwo,
                      _stepThree,
                      _stepFour,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  StepperStep get _stepOne => StepperStep(
        content: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Spacer(),
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
                  child: TextFormField(
                    controller: _emailController,
                    validator: FormValidator.validateEmail,
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
              Spacer(
                flex: 2,
              ),
              _continueButton()
            ],
          ),
        ),
        isActive: _currentStep == 0,
        state: _currentStep > 0 ? StepState.complete : StepState.disabled,
      );

  StepperStep get _stepTwo => StepperStep(
        content: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Spacer(),
              _buildTitle(
                title: Strings.createPasswordTitle,
                subtitle: Strings.createPasswordSubtitle,
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimens.vertical_padding),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: Strings.createPasswordTitle,
                      suffixIcon: GestureDetector(
                        onTap: _passwordVisibility,
                        child: Icon(
                          _showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.blue,
                        ),
                      ),
                      errorStyle: TextStyle(color: Colors.white)),
                  validator: FormValidator.validatePassword,
                ),
              ),
              StrengthChecker(
                controller: _passwordController,
              ),
              Spacer(),
              PasswordChecker(
                controller: _passwordController,
              ),
              Spacer(
                flex: 2,
              ),
              _continueButton()
            ],
          ),
        ),
        isActive: _currentStep == 1,
        state: _currentStep > 1 ? StepState.complete : StepState.disabled,
      );

  StepperStep get _stepThree => StepperStep(
        content: Container(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(),
                _buildTitle(
                  title: Strings.personalInfoTitle,
                  subtitle: Strings.personalInfoSubtitle,
                ),
                Spacer(),
                Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: Dimens.vertical_padding),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 24, bottom: 10),
                    child: DropdownButtonFormField<String>(
                      focusColor: Colors.white,
                      value: _goalActivationValue,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      icon: Icon(Icons.keyboard_arrow_down),
                      decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          labelText: Strings.goalForActivation,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: Strings.chooseOption,
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      items: _options
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                      isExpanded: true,
                      onChanged: (String? value) {
                        _goalActivationValue = value;
                      },
                      validator: FormValidator.validateEmpty,
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: Dimens.vertical_padding),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 24, bottom: 10),
                    child: DropdownButtonFormField<String>(
                      focusColor: Colors.white,
                      value: _monthlyIncomeValue,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      icon: Icon(Icons.keyboard_arrow_down),
                      decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          labelText: Strings.monthlyIncome,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: Strings.chooseOption,
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      items: _options
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                      isExpanded: true,
                      onChanged: (String? value) {
                        _monthlyIncomeValue = value;
                      },
                      validator: FormValidator.validateEmpty,
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: Dimens.vertical_padding),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 24, bottom: 10),
                    child: DropdownButtonFormField<String>(
                      focusColor: Colors.white,
                      value: _monthlyExpenseValue,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      icon: Icon(Icons.keyboard_arrow_down),
                      decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          labelText: Strings.monthlyExpense,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: Strings.chooseOption,
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      items: _options
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                      isExpanded: true,
                      onChanged: (String? value) {
                        _monthlyExpenseValue = value;
                      },
                      validator: FormValidator.validateEmpty,
                    ),
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
                _continueButton()
              ],
            ),
          ),
        ),
        isActive: _currentStep == 2,
        state: _currentStep > 2 ? StepState.complete : StepState.disabled,
      );

  StepperStep get _stepFour => StepperStep(
        content: Container(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AnimatedCalendarIcon(),
                _buildTitle(
                  title: Strings.scheduleVideoCallTitle,
                  subtitle: Strings.createPasswordSubtitle,
                ),
                Spacer(),
                Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: Dimens.vertical_padding),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 10, bottom: 10),
                    child: TextFormField(
                      controller: _dateController,
                      readOnly: true,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: Strings.date,
                        labelStyle: TextStyle(fontWeight: FontWeight.normal),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: Strings.chooseDate,
                        hintStyle: TextStyle(color: Colors.black),
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_down,
                        ),
                      ),
                      onTap: () async {
                        final formattedDate =
                            dateFormat(await DateTimePicker.pickDate(context));
                        if (formattedDate != null)
                          _dateController.text = formattedDate;
                      },
                      validator: FormValidator.validateEmpty,
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: Dimens.vertical_padding),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 10, bottom: 10),
                    child: TextFormField(
                      controller: _timeController,
                      readOnly: true,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: Strings.time,
                          labelStyle: TextStyle(fontWeight: FontWeight.normal),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: Strings.chooseTime,
                          hintStyle: TextStyle(color: Colors.black),
                          suffixIcon: Icon(Icons.keyboard_arrow_down)),
                      onTap: () async {
                        final timeOfDay =
                            timeFormat(await DateTimePicker.pickTime(context));
                        if (timeOfDay != null) _timeController.text = timeOfDay;
                      },
                      validator: FormValidator.validateEmpty,
                    ),
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
                _continueButton()
              ],
            ),
          ),
        ),
        isActive: _currentStep == 3,
        state: _isComplete ? StepState.complete : StepState.disabled,
      );

  ElevatedButton _continueButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          if (_currentStep > 2) {
            setState(() => _isComplete = true);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                Strings.complete,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ));
          }
          _continue();
        }
      },
      child: Text(Strings.next),
    );
  }

  Widget _buildTitle({required String title, required String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(vertical: Dimens.vertical_padding),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.white),
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  void _passwordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _tapped(int step) {
    _currentStep = step;
    if (_currentStep < 3) _isComplete = false;
    setState(() {});
  }

  void _continue() {
    if (_currentStep < 3) setState(() => _currentStep += 1);
  }

  void _back() {
    _isComplete = false;
    if (_currentStep > 0) setState(() => _currentStep -= 1);
  }

  @override
  void dispose() {
    _timeController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}
