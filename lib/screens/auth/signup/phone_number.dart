import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lockre/constants/colors.dart';
import 'package:lockre/screens/auth/signup/otp.dart';
// import 'package:lockre/screens/auth/signup/complete_profile.dart';
// import 'package:mongo_dart/mongo_dart.dart' as mongo;
// const MONGO_URL = "mongodb+srv://salowe:Adouabou102001.@lockre.xrasr0e.mongodb.net/?retryWrites=true&w=majority&appName=Lockre";
// const USER_COLLECTION = "lockre";
import 'package:firebase_auth/firebase_auth.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  String phoneNumber = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isButtonPressed = false;
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    // _connectToMongoDB();
  }

  // Future<void> _connectToMongoDB() async {
  //   try {
  //     db = await mongo.Db.create(MONGO_URL);
  //     await db.open();
  //     userCollection = db.collection(USER_COLLECTION);
  //     print('Connected to MongoDB.');
  //   } catch (e) {
  //     print('MongoDB Connection Error: $e');
  //     // Handle connection error
  //   }
  // }

  // Future<void> _insertUserData(String phoneNumber) async {
  //   if (userCollection != null) {
  //     var existingUser = await userCollection!.findOne({'phoneNumber': phoneNumber});
  //     if (existingUser == null) {
  //       await userCollection!.insertOne({'phoneNumber': phoneNumber});
  //       print('User data inserted successfully.');
  //     } else {
  //       print('User already exists.');
  //     }
  //   } else {
  //     print('User collection is null.');
  //   }
  // }

  void _verifyPhoneNumber(String phoneNumber) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Phone number verification failed: $e');
        setState(() {
          _errorMessage = 'Phone number verification failed. Please try again.';
        });
      },
      codeSent: (String verificationId, int? resendToken) {
        Get.to(() => OTPScreen(
        phoneNumber: phoneNumber,
        verificationId: verificationId,
      ));

      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle timeout
      },
    ).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: AppColors.primaryColor),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
    );
  }

  Widget _animatedButton({
    required VoidCallback onPressed,
    required String label,
    required bool isPressed,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: double.infinity,
      decoration: BoxDecoration(
        color: isPressed ? Colors.white : AppColors.primaryColor,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: InkWell(
        onTap: onPressed,
        onHighlightChanged: (value) {
          setState(() {
            _isButtonPressed = value;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: isPressed ? AppColors.primaryColor : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/logo/lockre.png', width: 150),
                const SizedBox(height: 20),
                const Text(
                  "Welcome to Lockré! Enter your phone number to start",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                            setState(() {
                              phoneNumber = number.phoneNumber ?? '';
                            });
                          },
                          hintText: "Phone Number",
                          inputDecoration: const InputDecoration(
                            hintText: "Phone Number",
                            hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                            border: InputBorder.none,
                          ),
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          ),
                          textStyle: const TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (_isLoading)
                        CircularProgressIndicator()
                      else
                        _animatedButton(
                          onPressed: () {
                            _verifyPhoneNumber(phoneNumber);
                          },
                          label: 'Continue',
                          isPressed: _isButtonPressed,
                        ),
                      if (_errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            _errorMessage,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
