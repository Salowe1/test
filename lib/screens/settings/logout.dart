import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lockre/constants/colors.dart';
import 'package:lockre/screens/auth/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
 // Make sure to import your AuthService

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text(
        'Confirmation de déconnexion',
        style: TextStyle(color: AppColors.primaryColor, fontSize: 19),
      ),
      content: const Text(
        'Êtes-vous sûr de vouloir vous déconnecter ?',
        style: TextStyle(color: Colors.black),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text(
            'Annuler',
            style: TextStyle(color: AppColors.primaryColor),
          ),
        ),
        const SizedBox(width: 60),
        TextButton(
          onPressed: () async {
            await _auth.signOut();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLoggedIn', false);

            Get.offAll(() => const LoginScreen()); // Navigate to the login screen after logout
          },
          child: const Text(
            'Déconnexion',
            style: TextStyle(color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
