import 'package:flutter/material.dart';
import 'package:lockre/constants/colors.dart'; // Make sure to import the correct colors

class OrderDialog extends StatelessWidget {
  const OrderDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text(
        'Confirmation de la transaction',
        style: TextStyle(color: Color.fromARGB(255, 37, 192, 43), fontSize: 19,), // Assuming primaryColor is the correct color
      ),
      content: const Text(
        'Vous recevrez une notification en rapport avec votre transaction dans les minutes qui suivent.',
        style: TextStyle(color: Colors.black,),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text(
            'Okay',
            style: TextStyle(color: Color.fromARGB(255, 28, 59, 33)), // Assuming primaryColor is the correct color
          ),
        ),
      ],
    );
  }
}
