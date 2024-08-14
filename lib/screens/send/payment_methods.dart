import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lockre/constants/colors.dart'; // Ensure this path matches your project structure
import 'package:lockre/screens/transactions/transaction_service.dart'; // Ensure this path matches your project structure
import 'package:permission_handler/permission_handler.dart';

class PaymentMethodsScreen extends StatefulWidget {
  final String finalAmount;

  PaymentMethodsScreen({required this.finalAmount});

  @override
  _PaymentMethodsScreenState createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  static const platform = MethodChannel('com.example.lockre/notification');

  String _selectedPaymentMethod = '';

  Future<void> _makePhoneCall() async {
    String code;
    if (_selectedPaymentMethod == 'Moov Money') {
      code = '*555*2*1*02891950*${widget.finalAmount}#';
    } else if (_selectedPaymentMethod == 'Orange Money') {
      code = '*144*2*1*07077418*${widget.finalAmount}#';
    } else {
      // Handle other payment methods or default case
      code = '';
    }

    // Request permission to make phone calls
    var status = await Permission.phone.status;
    if (!status.isGranted) {
      status = await Permission.phone.request();
    }

    if (status.isGranted) {
      try {
        await platform.invokeMethod('makePhoneCall', {'code': code});
      } on PlatformException catch (e) {
        print("Failed to make phone call: '${e.message}'.");
      }
    } else {
      print("Phone call permission not granted");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Méthodes de paiement'),
      ),
      body: ListView(
        children: [
          _buildPaymentMethod(context, 'Moov Money', 'assets/image/moov_money.png'),
          _buildPaymentMethod(context, 'Orange Money', 'assets/image/orange_money.jpeg'),
          _buildPaymentMethod(context, 'Master Card', 'assets/image/mastercard.png'),
          _buildPaymentMethod(context, 'Carte Visa', 'assets/image/visa.png'),
          _buildPaymentMethod(context, 'Carte Virtuelle', 'assets/image/virtual_card.png'),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            backgroundColor: AppColors.primaryColor,
          ),
          child: const Text('Annuler', style: TextStyle(fontSize: 16, color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(BuildContext context, String title, String asset) {
    return ListTile(
      leading: Image.asset(asset, width: 40, height: 40),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        setState(() {
          _selectedPaymentMethod = title;
        });
        title.contains('Carte')
            ? _showCardEntryForm(context)
            : _showPaymentDetails(context, title, asset);
      },
    );
  }

  void _showPaymentDetails(BuildContext context, String title, String asset) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 1.0,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        height: 5.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Entrer le code pour la transaction',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 1.0,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Image.asset(asset, width: 80, height: 80),
                              const SizedBox(height: 20),
                              const Text(
                                'Frais d\'envoi = 1% sans frais de retrait',
                                style: TextStyle(
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                  color: Colors.red,
                                  decorationColor: Colors.red,
                                ),
                              ),
                              const SizedBox(height: 30),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Montant final : ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextSpan(
                                      text: widget.finalAmount, // Use widget.finalAmount
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),
                              Text(
                                'code: ${_selectedPaymentMethod == 'Moov Money' ? '*555*2*1*02891950*${widget.finalAmount}#' : '*144*2*1*07077418*${widget.finalAmount}#'}', // Updated code with finalAmount
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Cliquez sur procéder pour faire la transaction et sur Vérifier OTP pour terminer avec le paiement par une vérification de votre code OTP reçu après la transaction',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: _makePhoneCall, // Trigger the phone call with the code
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: AppColors.primaryColor,
                                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                                      backgroundColor: Colors.white,
                                      side: BorderSide(color: AppColors.primaryColor),
                                    ),
                                    child: const Text(
                                      'Procéder',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        final transId = 'code-otp-simulated'; // Replace with actual OTP entered by the user
                                        final service = TransactionService();
                                        final result = await service.fetchTransaction(transId);
                                        print(result); // Print the result or use it in the UI
                                      } catch (e) {
                                        print('Erreur : $e');
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                                      backgroundColor: AppColors.primaryColor,
                                    ),
                                    child: const Text('Vérifier OTP', style: TextStyle(fontSize: 16, color: Colors.white)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showCardEntryForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 1.0,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        height: 5.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Enter your card details',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              // Add card entry form fields here
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
