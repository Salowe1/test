import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_core/firebase_core.dart'; // Firebase initialization commented out
import 'package:flutter/services.dart';
import 'package:lockre/screens/auth/login/login.dart';
import 'package:lockre/screens/auth/onboard.dart';
import 'package:lockre/screens/auth/first_page.dart';
import 'package:lockre/screens/auth/signup/phone_number.dart';
import 'package:lockre/screens/auth/mongodb/mongodb.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  // await Firebase.initializeApp(); // Firebase initialization commented out
  
  // Connect to MongoDB
  await _connectToMongoDB();

  // Fetch shared preferences and determine initial route
  final isFirstTime = await _getFirstTimePreference();
  
  runApp(MyApp(isFirstTime: isFirstTime));
}

Future<void> _connectToMongoDB() async {
  try {
    print('Connecting to MongoDB...');
    await MongoDB.connect();
    print('Connected to MongoDB.');
  } catch (e) {
    print('MongoDB connection error: $e');
  }
}

Future<bool> _getFirstTimePreference() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirstTime') ?? true;
  } catch (e) {
    print('SharedPreferences error: $e');
    return true; // Default to true in case of error
  }
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;

  const MyApp({Key? key, required this.isFirstTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: isFirstTime ? '/onboarding' : '/login',
      getPages: [
        GetPage(name: '/onboarding', page: () => OnboardingScreen()),
        GetPage(name: '/firstPage', page: () => FirstPageScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/phoneNumber', page: () => PhoneNumberScreen()),
      ],
    );
  }
}

class PhoneNumberScreen extends StatelessWidget {
  static const _methodChannel = MethodChannel('com.example.lockre/ussd');

  Future<void> _makeUSSDCall(String ussdCode) async {
    try {
      final result = await _methodChannel.invokeMethod('makeUSSDCall', {'code': ussdCode});
      print('USSD Call Result: $result');
    } on PlatformException catch (e) {
      print('Failed to make phone call: ${e.message}');
    } catch (e) {
      print('Failed to make phone call: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Number Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _makeUSSDCall('*123#'), // Example USSD code
          child: const Text('Make USSD Call'),
        ),
      ),
    );
  }
}
