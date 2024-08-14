import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lockre/constants/colors.dart';
import 'package:lockre/screens/dialogs/dialog_order.dart';
import 'package:lockre/screens/send/payment_methods.dart';

class EcarteOrderScreen extends StatefulWidget {
  const EcarteOrderScreen({Key? key}) : super(key: key);

  @override
  _EcarteOrderScreenState createState() => _EcarteOrderScreenState();
}

class _EcarteOrderScreenState extends State<EcarteOrderScreen> {
  final TextEditingController _cardTypeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  final FocusNode _cardTypeFocus = FocusNode();
  final FocusNode _countryFocus = FocusNode();
  final FocusNode _amountFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _setFocusListeners();
  }

  void _setFocusListeners() {
    _cardTypeFocus.addListener(_updateState);
    _countryFocus.addListener(_updateState);
    _amountFocus.addListener(_updateState);
    _addressFocus.addListener(_updateState);
    _cityFocus.addListener(_updateState);
  }

  void _updateState() => setState(() {});

  @override
  void dispose() {
    _disposeControllers();
    _disposeFocusNodes();
    super.dispose();
  }

  void _disposeControllers() {
    _cardTypeController.dispose();
    _countryController.dispose();
    _amountController.dispose();
    _addressController.dispose();
    _cityController.dispose();
  }

  void _disposeFocusNodes() {
    _cardTypeFocus.removeListener(_updateState);
    _countryFocus.removeListener(_updateState);
    _amountFocus.removeListener(_updateState);
    _addressFocus.removeListener(_updateState);
    _cityFocus.removeListener(_updateState);
    _cardTypeFocus.dispose();
    _countryFocus.dispose();
    _amountFocus.dispose();
    _addressFocus.dispose();
    _cityFocus.dispose();
  }

  Color _getLabelColor(FocusNode focusNode) {
    return focusNode.hasFocus ? AppColors.primaryColor : Colors.black;
  }

  void _navigateToPaymentMethodsScreen() {
    final finalAmountXOF = _amountController.text;
    Get.to(() => PaymentMethodsScreen(finalAmount: finalAmountXOF));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Commande de carte virtuelle',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          _buildCardImages(),
          Expanded(child: _buildForm()),
          _buildContinueButton(),
        ],
      ),
    );
  }

  Widget _buildCardImages() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/image/master_card.png',
            width: 320.0,
            height: 300.0,
          ),
        ),
        Positioned(
          top: 50.0,
          left: 32.0,
          right: 32.0,
          child: Image.asset(
            'assets/image/visa_card.png',
            width: 290.0,
            height: 300.0,
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        _buildTextField(
          controller: _cardTypeController,
          focusNode: _cardTypeFocus,
          labelText: 'Type de carte (Visa, Mastercard,..)',
        ),
        _buildTextField(
          controller: _countryController,
          focusNode: _countryFocus,
          labelText: 'Pays',
        ),
        _buildTextField(
          controller: _amountController,
          focusNode: _amountFocus,
          labelText: 'Montant de la carte virtuelle',
        ),
        const SizedBox(height: 10.0),
        _buildTextField(
          controller: _addressController,
          focusNode: _addressFocus,
          labelText: 'Adresse',
        ),
        const SizedBox(height: 10.0),
        _buildTextField(
          controller: _cityController,
          focusNode: _cityFocus,
          labelText: 'Ville',
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String labelText,
  }) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: _getLabelColor(focusNode)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      style: TextStyle(
        color: focusNode.hasFocus ? AppColors.primaryColor : Colors.black,
      ),
    );
  }

  Widget _buildContinueButton() {
    return ElevatedButton(
      onPressed: _navigateToPaymentMethodsScreen,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 85.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          SizedBox(width: 20.0),
          Text(
            'Continuer',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 20.0),
          Icon(
            Icons.arrow_forward_rounded,
            color: Colors.white,
            size: 24.0,
          ),
        ],
      ),
    );
  }
}
