import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
    );
  }
}

class SettingOption extends StatelessWidget {
  final String title;
  final String amount; // New parameter for amount

  const SettingOption({
    Key? key,
    required this.title,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(amount), // Display amount to the right of the title
        ],
      ),
    );
  }
}

class LimitesDeTransactionScreen extends StatelessWidget {
  const LimitesDeTransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Limites de Transaction'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: 'Limites de transfert'),
            _buildSection(
              options: [
                SettingOption(
                  title: 'Maximum journalier',
                  amount: '500.000F', // Provide the corresponding amount
                ),
                SettingOption(
                  title: 'Maximum annuel',
                  amount: '2.000.000F', // Provide the corresponding amount
                ),
              ],
            ),
            SectionHeader(title: 'Limites de paiement'),
            _buildSection(
              options: [
                SettingOption(
                  title: 'Maximum journalier',
                  amount: '500.000F', // Provide the corresponding amount
                ),
                SettingOption(
                  title: 'Maximum annuel',
                  amount: '2.000.000F', // Provide the corresponding amount
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required List<Widget> options}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: options,
      ),
    );
  }
}
