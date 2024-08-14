import 'dart:async';
import 'dart:io'; // Import dart:io library for exit function

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lockre/constants/colors.dart'; // Adjust the import based on your project's structure

class ConnectedDevicesScreen extends StatefulWidget {
  const ConnectedDevicesScreen({Key? key}) : super(key: key);

  @override
  _ConnectedDevicesScreenState createState() => _ConnectedDevicesScreenState();
}

class _ConnectedDevicesScreenState extends State<ConnectedDevicesScreen> {
  bool _isBlocked = false;

  void _toggleBlock(bool value) {
    setState(() {
      _isBlocked = value;
    });

    if (_isBlocked) {
      // Implement the disconnect logic here
      // For demonstration, we'll just show a snackbar
      Get.snackbar('Compte bloqué', 'Vous avez été déconnecté de tous les appareils.');

      // Quit the app after 5 seconds
      Timer(const Duration(seconds: 5), () => exit(0));
    } else {
      Get.snackbar('Compte débloqué', 'Votre compte est actif sur cet appareil.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vos Appareils connectés'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Bloquer le compte lockré sur cet appareil',
                          style: TextStyle(fontSize: 16),
                        ),
                        Switch(
                          value: _isBlocked,
                          onChanged: _toggleBlock,
                          activeColor: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'En bloquant le compte lockré vous enclenché un processus de déconnexion automatique sur les appareils connectés.',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(
                        Icons.phone_android,
                        color: Colors.black,
                      ),
                    ),
                    title: const Text('Samsung SM-32'),
                    subtitle: const Text('Cet appareil'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
