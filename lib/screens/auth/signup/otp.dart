import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lockre/constants/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:sms_autofill/sms_autofill.dart';
import 'complete_profile.dart';

const MONGO_URL =
    "mongodb+srv://salowe:Adouabou102001.@lockre.xrasr0e.mongodb.net/?retryWrites=true&w=majority&appName=Lockre";
const USER_COLLECTION = "lockre";

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  OTPScreen({Key? key, required this.phoneNumber, required this.verificationId}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}


class _OTPScreenState extends State<OTPScreen> with CodeAutoFill {
  String otpCode = '';

  @override
  void codeUpdated() {
    setState(() {
      otpCode = code!;
    });
  }

  Future<bool> _verifyOTP(String otp) async {
    try {
      mongo.Db db = await mongo.Db.create(MONGO_URL);
      await db.open();
      mongo.DbCollection userCollection = db.collection(USER_COLLECTION);

      var result = await userCollection.findOne({
        'phone_number': widget.phoneNumber,
        'otp': otp,
      });

      await db.close();

      return result != null; // Return true if OTP is valid
    } catch (e) {
      print('Error verifying OTP: $e');
      return false; // Handle error: return false for invalid OTP
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    listenForCode();
  }

  @override
  void dispose() {
    cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, top: 30, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Image.asset('assets/logo/lockre.png', height: 200),
            const SizedBox(height: 20),
            const Text(
              "Enter the OTP sent to your phone number",
              style: TextStyle(fontSize: 15, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: PinFieldAutoFill(
                codeLength: 6,
                onCodeChanged: (value) {
                  setState(() {
                    otpCode = value ?? '';
                  });
                },
                currentCode: otpCode,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  bool verified = await _verifyOTP(otpCode);
                  if (verified) {
                    // Insert user data into MongoDB if OTP is verified
                    try {
                      mongo.Db db = await mongo.Db.create(MONGO_URL);
                      await db.open();
                      mongo.DbCollection userCollection = db.collection(USER_COLLECTION);

                      await userCollection.insert({
                        'phone_number': widget.phoneNumber,
                        // Add other user data fields as needed
                      });

                      await db.close();

                      Get.to(() => CompleteProfileScreen());
                    } catch (e) {
                      print('Error inserting user data: $e');
                      showSnackBar('Failed to complete profile. Please try again.');
                    }
                  } else {
                    // Handle OTP verification failure
                    showSnackBar('Invalid OTP');
                  }
                },
                child: const Text(
                  'Verify',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor, // Adjust as per your app's theme
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
