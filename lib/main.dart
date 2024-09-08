import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'screens/auth/login/login.dart';
import 'screens/auth/onboard.dart';
import 'screens/auth/first_page.dart';
import 'screens/auth/signup/phone_number.dart';
import 'screens/auth/mongodb/mongodb.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await _connectToMongoDB();
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
    return true;
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
  static const _methodChannel = MethodChannel('com.example.test/ussd');

  Future<void> _makeUSSDCall(String ussdCode) async {
    try {
      final result = await _methodChannel.invokeMethod('makeUSSDCall', {'code': ussdCode});
      print('USSD Call Result: $result');
    } on PlatformException catch (e) {
      print('Failed to make phone call: ${e.message}');
    } catch (e) {
      print('Failed to make phone call: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Number')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _makeUSSDCall('*123#');
          },
          child: const Text('Make USSD Call'),
        ),
      ),
    );
  }
}
