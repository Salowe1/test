import 'package:flutter/material.dart';
import 'package:flag/flag.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../constants/colors.dart';

class CardWidget extends StatefulWidget {
  final TextEditingController fromAmountController;
  final TextEditingController toAmountController;
  final List<Map<String, dynamic>> currencies;
  final Function(String) onFromCurrencyChanged;
  final Function(String) onToCurrencyChanged;
  final double exchangeRate;
  final String toCurrency;
  final String fromCurrency;
  final Function(double) onUpdateExchangeRate;

  const CardWidget({
    Key? key,
    required this.fromAmountController,
    required this.toAmountController,
    required this.currencies,
    required this.onFromCurrencyChanged,
    required this.onToCurrencyChanged,
    required this.exchangeRate,
    required this.toCurrency,
    required this.fromCurrency,
    required this.onUpdateExchangeRate,
  }) : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  void initState() {
    super.initState();
    fetchExchangeRate();
    widget.fromAmountController.addListener(updateConversion);
    widget.toAmountController.addListener(updateConversion);
  }

  Future<void> fetchExchangeRate() async {
    final url = 'https://api.currencyapi.com/v3/latest?apikey=fca_live_ev1bFhOAWBtGoOlvANBzxkMHMstCwnS1wjaJuUne&base_currency=${widget.fromCurrency}';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final exchangeRate = data['data'][widget.toCurrency]['value'];
        widget.onUpdateExchangeRate(exchangeRate);
      } else {
        throw Exception('Failed to load exchange rate');
      }
    } catch (e) {
      print('Error fetching exchange rate: $e');
    }
  }

  void updateConversion() {
    if (widget.fromAmountController.text.isNotEmpty) {
      final fromAmount = double.tryParse(widget.fromAmountController.text) ?? 0.0;
      final toAmount = fromAmount * widget.exchangeRate;
      widget.toAmountController.text = toAmount.toStringAsFixed(2);
    } else if (widget.toAmountController.text.isNotEmpty) {
      final toAmount = double.tryParse(widget.toAmountController.text) ?? 0.0;
      final fromAmount = toAmount / widget.exchangeRate;
      widget.fromAmountController.text = fromAmount.toStringAsFixed(2);
    }
  }

  void switchCurrencies() {
    final tempCurrency = widget.fromCurrency;
    final tempAmount = widget.fromAmountController.text;

    widget.onFromCurrencyChanged(widget.toCurrency);
    widget.onToCurrencyChanged(tempCurrency);

    widget.fromAmountController.text = widget.toAmountController.text;
    widget.toAmountController.text = tempAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Currency Converter',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            children: [
              _buildCurrencyTextField(widget.fromCurrency, widget.fromAmountController, true),
              const SizedBox(height: 2),
              GestureDetector(
                onTap: switchCurrencies,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Transform.rotate(
                      angle: 90 * 3.141592653589793 / 180, // Convert degrees to radians
                      child: const Icon(
                        Icons.compare_arrows,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              _buildCurrencyTextField(widget.toCurrency, widget.toAmountController, false),
            ],
          ),
          const SizedBox(height: 5),
          const Text(
            'Exchange Rate',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '1 ${widget.fromCurrency} = ${widget.exchangeRate} ${widget.toCurrency}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyTextField(String selectedCurrency, TextEditingController controller, bool isFromCurrency) {
    String hintText = isFromCurrency ? '0.00 $selectedCurrency' : '0.00 ${widget.toCurrency}';

    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: DropdownButton<String>(
                    value: selectedCurrency,
                    dropdownColor: Colors.white,
                    iconEnabledColor: Colors.black,
                    underline: Container(),
                    items: widget.currencies.map((currency) {
                      return DropdownMenuItem<String>(
                        value: currency['code'],
                        child: Row(
                          children: [
                            Flag.fromCode(
                              currency['flag'],
                              height: 16,
                              width: 24,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              currency['code'],
                              style: const TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        if (isFromCurrency) {
                          widget.onFromCurrencyChanged(newValue);
                        } else {
                          widget.onToCurrencyChanged(newValue);
                        }
                        fetchExchangeRate(); // Update exchange rate on currency change
                      }
                    },
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => updateConversion(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hintText,
                      hintStyle: const TextStyle(fontSize: 14),
                    ),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(width: 6,)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
