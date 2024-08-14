import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lockre/constants/colors.dart';
import 'package:lockre/screens/settings/settings.dart';
import 'package:lockre/screens/home/widget/option.dart';
import 'package:lockre/screens/home/widget/card.dart';
import 'package:lockre/screens/home/widget/infocard.dart';
import 'package:lockre/screens/transactions/all_transaction.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flag/flag.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isTapped = false;
  String _fromCurrency = 'XOF';
  String _toCurrency = 'EUR';
  double _exchangeRate = 0.0;
  final TextEditingController _fromAmountController = TextEditingController();
  final TextEditingController _toAmountController = TextEditingController();
  final List<Map<String, dynamic>> _currencies = [
    {'code': 'XOF', 'flag': FlagsCode.BF},
    {'code': 'EUR', 'flag': FlagsCode.EU},
    // Add other currencies here
  ];

  @override
  void initState() {
    super.initState();
    _fetchExchangeRate();
  }

  Future<void> _fetchExchangeRate() async {
    const apiKey = 'fca_live_ev1bFhOAWBtGoOlvANBzxkMHMstCwnS1wjaJuUne'; 
    final url = Uri.parse('https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_ev1bFhOAWBtGoOlvANBzxkMHMstCwnS1wjaJuUne');
    
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final conversionRates = data['conversion_rates'];
        setState(() {
          _exchangeRate = conversionRates[_toCurrency] ?? 0.0;
        });
      } else {
        throw Exception('Failed to load exchange rate');
      }
    } catch (e) {
      print('Error fetching exchange rate: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 50, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Get.to(() => const SettingsScreen()),
                        icon: const Icon(Icons.settings, size: 35),
                      ),
                      Image.asset('assets/logo/lockre.png', width: 75),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CardWidget(
                    fromCurrency: _fromCurrency,
                    toCurrency: _toCurrency,
                    exchangeRate: _exchangeRate,
                    fromAmountController: _fromAmountController,
                    toAmountController: _toAmountController,
                    currencies: _currencies,
                    onFromCurrencyChanged: (value) => setState(() => _fromCurrency = value),
                    onToCurrencyChanged: (value) => setState(() => _toCurrency = value),
                    onUpdateExchangeRate: (newRate) => setState(() => _exchangeRate = newRate),
                  ),
                  const SizedBox(height: 15),
                  const OptionWidget(),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              height: 140,
              decoration: const BoxDecoration(color: AppColors.greyColor),
              child: const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    InfoCard(),
                    SizedBox(width: 10),
                    InfoCard(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedDefaultTextStyle(
                          style: TextStyle(
                            color: _isTapped ? Colors.black : AppColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          duration: const Duration(milliseconds: 500),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 17),
                            child: Text(
                              "Transactions",
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isTapped = !_isTapped;
                            });
                            Get.to(() => const AllTransactionsScreen());
                            Future.delayed(const Duration(milliseconds: 500), () {
                              setState(() {
                                _isTapped = !_isTapped;
                              });
                            });
                          },
                          child: AnimatedDefaultTextStyle(
                            style: TextStyle(
                              color: _isTapped ? AppColors.primaryColor : Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            duration: const Duration(milliseconds: 500),
                            child: const Padding(
                              padding: EdgeInsets.only(right: 17),
                              child: Text("Tout voir"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 170,
                      width: double.infinity,
                      color: Colors.white,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Container(
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0.5,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 15),
                                  const Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Icon(Icons.check_circle, size: 40, color: Colors.green),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text('Title', style: TextStyle(color: Colors.blue)),
                                      SizedBox(width: 7),
                                      Text('Date'),
                                      SizedBox(width: 7),
                                      Text('Method'),
                                      SizedBox(width: 7),
                                      Text('Phone'),
                                      SizedBox(width: 230),
                                    ],
                                  ),
                                  const Text(
                                    'Amount',
                                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
