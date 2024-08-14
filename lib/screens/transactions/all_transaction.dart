import 'package:flutter/material.dart';
import 'package:lockre/constants/colors.dart';

class AllTransactionsScreen extends StatelessWidget {
  const AllTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = [
      {
        'title': 'Burkina --> France',
        'date': '17 Sep',
        'method': 'Automatique',
        'phone': '+33 507077418',
        'amount': '290.90 FCFA',
      },
      // Add other transactions here if needed
    ];

    return Scaffold(
      backgroundColor: Colors.white, // Set the background color of the Scaffold to white
      appBar: AppBar(
        title: const Text(
          'Toutes les transactions',
          style: TextStyle(color: Colors.black), // Set the AppBar title color to black
        ),
        backgroundColor: Colors.white, // Set the AppBar background color to white
        iconTheme: IconThemeData(color: Colors.black), // Set the AppBar icon color to black
      ),
      body: ListView.builder(
        itemCount: transactions.length * 6, // Display the content 6 times
        itemBuilder: (context, index) {
          final transaction = transactions[index % transactions.length];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                 boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.5,
                  ),
                ],
              ),
              child: ListTile(
                leading: const Icon(
  IconData(0xe3f8, fontFamily: 'MaterialIcons'),
  size: 40,
),

                title: Text(
                  transaction['title']!,
                  style: TextStyle(color: Colors.blue),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(transaction['date']!),
                    Text(transaction['method']!),
                    Text('Envoyé au ${transaction['phone']}'),
                  ],
                ),
                trailing: Text(
                  transaction['amount']!,
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
