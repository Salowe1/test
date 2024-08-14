
import 'package:get/get.dart';
import 'package:lockre/screens/home/home.dart';
import 'package:lockre/screens/settings/password/change_password.dart';
import 'package:lockre/screens/settings/settings.dart';
import 'package:lockre/screens/settings/promo_code_screen.dart';
import 'package:lockre/screens/settings/limites_de_transaction.dart';
import 'package:lockre/screens/settings/conditions_generales.dart';
import 'package:lockre/screens/settings/connected_devices_screen.dart';
import 'package:lockre/screens/settings/politiques_confident.dart';
import 'package:lockre/screens/settings/password/last_password.dart';
import 'package:lockre/screens/settings/password/confirm_password.dart';
import 'package:lockre/screens/auth/splash.dart';
import 'package:lockre/screens/transactions/all_transaction.dart';
import 'package:lockre/screens/ecarte/ecarte_menu.dart';
import 'package:lockre/screens/ecarte/my_ecarte.dart';
import 'package:lockre/screens/ecarte/ecarte_order.dart';
import 'package:lockre/screens/auth/login/login.dart';
import 'package:lockre/screens/auth/signup/complete_profile.dart';
import 'package:lockre/screens/auth/signup/phone_number.dart';
import 'package:lockre/screens/auth/signup/photo_cnib.dart';
import 'package:lockre/screens/auth/signup/test_storage.dart'; 
import 'package:lockre/screens/send/sender_number_screen.dart';
import 'package:lockre/screens/send/amount_to_send.dart';
import 'package:lockre/screens/send/payment_methods.dart';
import 'package:lockre/screens/auth/onboard.dart'; // Import onboarding screens
import 'package:lockre/screens/auth/first_page.dart'; // Import onboarding screens
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
    GetPage(name: MyRoutes.completeProfile, page: () => CompleteProfileScreen()), // Add this line
    GetPage(name: MyRoutes.photoCnib, page: () => PhotoCnib()),
    GetPage(name: '/test-storage', page: () => TestStorage()),  // Add the route
    GetPage(name: MyRoutes.senderNumberScreen, page: () => SenderNumberScreen()),
    GetPage(name: MyRoutes.amountToSend, page: () => AmountToSendScreen(selectedNumber: '',)),
    GetPage(name: MyRoutes.paymentMethods, page: () => PaymentMethodsScreen()),
  
  ];
}