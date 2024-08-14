import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lockre/constants/colors.dart';
import 'package:lockre/routes/route.dart';
import 'package:device_apps/device_apps.dart';

class MyEcarteScreen extends StatelessWidget {
  const MyEcarteScreen({Key? key}) : super(key: key);

  Future<void> _showPaymentOptions(BuildContext context) async {
    // List of known payment app package names
    final paymentAppPackageNames = [
      'com.squareup.cash', // Cash App
      'com.google.android.apps.walletnfcrel', // Google Pay
      'com.apple.wallet', // Apple Pay (this may be handled differently)
      'com.samsung.android.spay', // Samsung Pay
      'com.venmo', // Venmo
      'com.stripe.android', // Stripe
      'com.revolut.revolutapp', // Revolut
      'com.payoneer.android', // Payoneer
      'com.n26.android', // N26
      'com.zellepay', // Zelle
      'com.chimebank', // Chime
      'com.westernunion.android.moneytransfer', // Western Union
      'com.skrill.mobil', // Skrill
      'com.netSpend', // NetSpend
      'com.greendot.moneypak', // MoneyPak by Green Dot
      'com.wepay.android', // WePay
      'com.dwolla.android', // Dwolla
      'com.klarna.android', // Klarna
      'com.sezzle.android', // Sezzle
      'com.afterpay.android', // Afterpay
      'com.wirex', // Wirex
      'com.etsy.android', // Etsy Payments
      'com.plastiq', // Plastiq
      'com.americanexpress.bluebird', // Bluebird by American Express
      'com.hipay.android', // Hipay
      'com.gocardless.android', // GoCardless
      'com.worldpay.android', // Worldpay
      'com.adyen.checkout', // Adyen
      'com.braintreepayments', // Braintree
      'com.propay.android', // ProPay
      'com.payza.android', // Payza (formerly AlertPay)
      'com.vivapayments.android', // Viva Wallet
      'com.paypal.android.p2pmobile', // PayPal
      'com.payeer.app', // Payeer
      'com.paylib.android', // Paylib
      'com.amazon.mShop.android.shopping', // Amazon
      'com.ebay.mobile', // eBay
      'com.walmart.android', // Walmart
      'com.target.ui', // Target
      'com.alibaba.aliexpresshd', // Alibaba
      'com.macys.android', // Macy's (corrected package name)
      'com.asos.android', // ASOS
      // Add more known package names of payment apps as needed
    ];

    final apps = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeSystemApps: true,
    );

    final paymentApps = apps.where((app) {
      return paymentAppPackageNames.contains(app.packageName);
    }).toList();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: paymentApps.length,
          itemBuilder: (context, index) {
            final app = paymentApps[index];
            return ListTile(
              leading: Icon(Icons.payment, size: 40), // Placeholder icon
              title: Text(app.appName),
              onTap: () {
                DeviceApps.openApp(app.packageName);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ma carte virtuelle',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 25.0),
            Container(
              height: 200,
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                color: AppColors.primaryColor, // Blue color for the card
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'VISA',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Debit Card',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Center(
                    child: Text(
                      '5133 1373 2353 6453',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 45.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$80.00',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        '12 / 26',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                _showPaymentOptions(context);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 40.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                backgroundColor: AppColors.primaryColor, // Button color
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 57.0),
                  Text(
                    'Faire un achat',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold, // Make the text bold
                    ),
                  ),
                  SizedBox(width: 40.0),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 26.0, // Adjust the size as needed
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
