import 'package:flutter/material.dart';

class PolitiquesConfidentialiteScreen extends StatelessWidget {
  const PolitiquesConfidentialiteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Politiques de confidentialité'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Politiques de Confidentialité',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              '1. Introduction',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Votre vie privée est importante pour nous. Cette politique de confidentialité explique quelles informations nous collectons, comment nous les utilisons et comment nous les protégeons.',
            ),
            // Add more sections as needed
          ],
        ),
      ),
    );
  }
}
