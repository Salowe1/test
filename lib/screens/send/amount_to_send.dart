import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lockre/constants/colors.dart';
import 'package:lockre/screens/send/payment_methods.dart';

class AmountToSendScreen extends StatefulWidget {
  final String selectedNumber;

  AmountToSendScreen({required this.selectedNumber});

  @override
  _AmountToSendScreenState createState() => _AmountToSendScreenState();
}

class _AmountToSendScreenState extends State<AmountToSendScreen> {
  final double conversionRate = 0.0015; // Example conversion rate: 1 XOF = 0.0015 EUR
  final TextEditingController _burkinaAmountController = TextEditingController();
  final TextEditingController _franceAmountController = TextEditingController();
  String _convertedAmount = '0.00 €';
  String _finalAmountXOF = '0.00 XOF';

  @override
  void initState() {
    super.initState();
    _burkinaAmountController.addListener(_updateFromBurkina);
    _franceAmountController.addListener(_updateFromFrance);
  }

  @override
  void dispose() {
    _burkinaAmountController.removeListener(_updateFromBurkina);
    _franceAmountController.removeListener(_updateFromFrance);
    _burkinaAmountController.dispose();
    _franceAmountController.dispose();
    super.dispose();
  }

  void _updateFromBurkina() {
    final amount = double.tryParse(_burkinaAmountController.text) ?? 0.0;
    final convertedAmount = amount * conversionRate;
    final finalAmountXOF = amount * 0.99; // 99% of the entered amount

    setState(() {
      _convertedAmount = '${convertedAmount.toStringAsFixed(2)} €';
      _finalAmountXOF = '${finalAmountXOF.toStringAsFixed(2)} XOF';
    });

    // Clear France input if Burkina input changes
    if (_franceAmountController.text.isNotEmpty) {
      _franceAmountController.clear();
    }
  }

  void _updateFromFrance() {
    final amount = double.tryParse(_franceAmountController.text) ?? 0.0;
    final convertedAmount = amount / conversionRate;
    final finalAmountXOF = convertedAmount * 0.99; // 99% of the entered amount

    setState(() {
      _convertedAmount = '${convertedAmount.toStringAsFixed(2)} €';
      _finalAmountXOF = '${finalAmountXOF.toStringAsFixed(2)} XOF';
    });

    // Clear Burkina input if France input changes
    if (_burkinaAmountController.text.isNotEmpty) {
      _burkinaAmountController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Montant à transférer', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: _buildBorderedText('J’envoie'),
              ),
              _buildAmountInput('Burkina', '0.00000 XOF', 'assets/image/burkina_flag.jpeg', _burkinaAmountController),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: _buildBorderedTextWithArrow('Vers', widget.selectedNumber),
              ),
              _buildAmountInput('France', _convertedAmount, 'assets/image/france_flag.webp', _franceAmountController),
              const SizedBox(height: 60),
              RichText(
                text: const TextSpan(
                  text: 'Frais d’envoi = 1% sans frais de retrait',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.red,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Montant final :           ',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    TextSpan(
                      text: _finalAmountXOF,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                     Get.to(() => PaymentMethodsScreen(finalAmount: _finalAmountXOF));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 15),
                    backgroundColor: AppColors.primaryColor,
                  ),
                  child: const Text('Continuer', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountInput(String country, String amount, String flagAsset, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Image.asset(flagAsset, width: 60, height: 60),
              const SizedBox(height: 5),
              Text(
                country,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Saisissez votre montant', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  height: 40,
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: amount,
                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Color.fromARGB(197, 221, 221, 221),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(197, 221, 221, 221)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(197, 221, 221, 221)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBorderedText(String text) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: AppColors.primaryColor),
          top: BorderSide(color: AppColors.primaryColor),
          right: BorderSide(color: AppColors.primaryColor),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildBorderedTextWithArrow(String text, String phoneNumber) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: AppColors.primaryColor),
          top: BorderSide(color: AppColors.primaryColor),
          right: BorderSide(color: AppColors.primaryColor),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 15),
          const Icon(Icons.arrow_forward, color: Colors.black, size: 30),
          const SizedBox(width: 15),
          Text(
            phoneNumber,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
