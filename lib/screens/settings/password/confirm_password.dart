import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lockre/constants/colors.dart';
import 'package:lockre/screens/settings/settings.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

class ConfirmPasswordPage extends StatefulWidget {
  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<ConfirmPasswordPage> {
  late TextEditingController _pinEditingController;
  late String _pinCode = '';

  @override
  void initState() {
    super.initState();
    _pinEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _pinEditingController.dispose();
    super.dispose();
  }

  void _onKeyboardTap(String value) {
    setState(() {
      if (value == '<') {
        if (_pinCode.isNotEmpty) {
          _pinCode = _pinCode.substring(0, _pinCode.length - 1);
        }
      } else {
        if (_pinCode.length < 4) {
          _pinCode += value;
        }
      }
      _pinEditingController.text = _pinCode;
    });
  }

  void _navigateToSettingsScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo/lockre.png',
                width: 150,
                // Ajoutez ici le code pour le logo
              ),
              const SizedBox(height: 20),
              const Text(
                'Confirmer le mot de passe',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40),
                child: PinCodeTextField(
                  appContext: context,
                  length: 4,
                  controller: _pinEditingController,
                  onChanged: (value) {
                    _pinCode = value;
                  },
                  textStyle: TextStyle(fontSize: 15),
                  obscureText: true,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.circle,
                      activeColor: AppColors.primaryColor,
                      inactiveColor: AppColors.primaryColor),
                ),
              ),
              const SizedBox(height: 50),
              NumericKeyboard(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                onKeyboardTap: _onKeyboardTap,
                textColor: Colors.black,
                leftButtonFn: () {
                  setState(() {
                    if (_pinCode.isNotEmpty) {
                      _pinCode = _pinCode.substring(0, _pinCode.length - 1);
                      _pinEditingController.text = _pinCode;
                    }
                  });
                },
                leftIcon: const Icon(Icons.backspace_rounded),
                rightIcon: const Icon(Icons.arrow_right_sharp),
                rightButtonFn: _navigateToSettingsScreen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
