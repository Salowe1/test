import 'package:get/get.dart';
import 'package:test/screens/home/home.dart';
import 'package:test/screens/settings/password/change_password.dart';
import 'package:test/screens/settings/settings.dart';
import 'package:test/screens/settings/promo_code_screen.dart';
import 'package:test/screens/settings/limites_de_transaction.dart';
import 'package:test/screens/settings/conditions_generales.dart';
import 'package:test/screens/settings/connected_devices_screen.dart';
import 'package:test/screens/settings/politiques_confident.dart';
import 'package:test/screens/settings/password/last_password.dart';
import 'package:test/screens/settings/password/confirm_password.dart';
import 'package:test/screens/auth/splash.dart';
import 'package:test/screens/transactions/all_transaction.dart';
import 'package:test/screens/ecarte/ecarte_menu.dart';
import 'package:test/screens/ecarte/my_ecarte.dart';
import 'package:test/screens/ecarte/ecarte_order.dart';
import 'package:test/screens/auth/login/login.dart';
import 'package:test/screens/auth/signup/complete_profile.dart';
import 'package:test/screens/auth/signup/phone_number.dart';
import 'package:test/screens/auth/signup/photo_cnib.dart';
import 'package:test/screens/auth/signup/test_storage.dart'; 
import 'package:test/screens/send/sender_number_screen.dart';
import 'package:test/screens/send/amount_to_send.dart';
import 'package:test/screens/send/payment_methods.dart';
import 'package:test/screens/auth/onboard.dart'; // Import onboarding screens
import 'package:test/screens/auth/first_page.dart'; // Import onboarding screens
import 'route.dart';

class Routes {
  static final routes = [
    GetPage(name: '/', page: () => SplashScreen()),
    GetPage(name: MyRoutes.onboardingScreen, page: () => OnboardingScreen()),
    GetPage(name: MyRoutes.firstPage, page: () => FirstPageScreen()),
    GetPage(name: MyRoutes.home, page: () => const HomeScreen()),
    GetPage(name: MyRoutes.phoneNumber, page: () => const PhoneNumberScreen()),
    GetPage(name: MyRoutes.settings, page: () => const SettingsScreen()),
    GetPage(name: MyRoutes.promoCode, page: () => const PromoCodeScreen()),
    GetPage(name: MyRoutes.limitesDeTransaction, page: () => const LimitesDeTransactionScreen()),
    GetPage(name: MyRoutes.conditionsGenerales, page: () => const ConditionsGeneralesScreen()),
    GetPage(name: MyRoutes.politiquesConfidentialite, page: () => const PolitiquesConfidentialiteScreen()),
    GetPage(name: MyRoutes.connectedDevices, page: () => const ConnectedDevicesScreen()),
    GetPage(name: MyRoutes.lastpassword, page: () => LastPasswordPage()),
    GetPage(name: MyRoutes.changepassword, page: () => ChangePasswordPage()),
    GetPage(name: MyRoutes.confirmpassword, page: () => ConfirmPasswordPage()),
    GetPage(name: MyRoutes.allTransactions, page: () => const AllTransactionsScreen()),
    GetPage(name: MyRoutes.ecarte, page: () => const EcarteScreen()),
    GetPage(name: MyRoutes.myEcarte, page: () => const MyEcarteScreen()),
    GetPage(name: MyRoutes.ecarteOrder, page: () => const EcarteOrderScreen()),
    GetPage(name: MyRoutes.login, page: () => const LoginScreen()),
    GetPage(name: MyRoutes.completeProfile, page: () => CompleteProfileScreen()),
    GetPage(name: MyRoutes.photoCnib, page: () => PhotoCnib()),
    GetPage(name: '/test-storage', page: () => TestStorage()),
    GetPage(
      name: MyRoutes.senderNumberScreen,
      page: () => SenderNumberScreen(),
    ),
    GetPage(
      name: MyRoutes.amountToSend,
      page: () => AmountToSendScreen(finalAmount: 0), // Default value or replace with appropriate value
    ),
    GetPage(name: MyRoutes.paymentMethods, page: () => PaymentMethodsScreen()),
  ];
}
