import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:lockre/constants/colors.dart' as Constants;
import 'package:lockre/screens/auth/signup/photo_cnib.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

const MONGO_URL =
    "mongodb+srv://salowe:Adouabou102001.@lockre.xrasr0e.mongodb.net/?retryWrites=true&w=majority&appName=Lockre";
const USER_COLLECTION = "lockre";

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _promoCodeController = TextEditingController();

  bool _isChecked = false;
  bool _dataExists = false;

  static late mongo.Db db;
  static late mongo.DbCollection userCollection;

  @override
  void initState() {
    super.initState();
    _connectToMongoDB();
  }

  Future<void> _connectToMongoDB() async {
    try {
      db = await mongo.Db.create(MONGO_URL);
      await db.open();
      userCollection = db.collection(USER_COLLECTION);
      print('Connected to MongoDB.');
    } catch (e) {
      print('MongoDB Connection Error: $e');
    }
  }

  Future<void> _checkDataExists() async {
    try {
      var result = await userCollection.findOne({
        'email': _emailController.text,
      });
      setState(() {
        _dataExists = result != null;
        if (_dataExists) {
          _showSnackbar('Data already exists.');
        }
      });
    } catch (e) {
      print('Error checking data existence: $e');
    }
  }

  void _showSnackbar(String message) {
    Get.snackbar('Info', message, backgroundColor: Colors.red);
  }

  void _submitProfile() async {
    if (_isChecked && !_dataExists) {
      try {
        var userData = {
          'name': _nameController.text,
          'email': _emailController.text,
          'promoCode': _promoCodeController.text,
          'createdAt': DateTime.now().toIso8601String(),
        };

        var result = await userCollection.insert(userData);
        print('Insert Result: $result');

        Get.off(() => PhotoCnib());
      } catch (e) {
        print('Error submitting profile: $e');
      }
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Constants.AppColors.primaryColor),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Constants.AppColors.primaryColor),
      ),
    );
  }

  Future<void> _googleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        _nameController.text = googleUser.displayName ?? '';
        _emailController.text = googleUser.email;
        _checkDataExists();
        _showSnackbar('Google Sign-In Successful');
      }
    } catch (e) {
      print('Google Sign-In Error: $e');
      _showSnackbar('Google Sign-In Failed');
    }
  }

  Future<void> _appleSignIn() async {
    try {
      final AuthorizationCredentialAppleID credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.fullName,
          AppleIDAuthorizationScopes.email,
        ],
      );
      _nameController.text = '${credential.givenName ?? ''} ${credential.familyName ?? ''}';
      _emailController.text = credential.email ?? '';
      _checkDataExists();
    } catch (e) {
      print('Apple Sign-In Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Center(
                child: Image.asset('assets/logo/lockre.png', height: 200),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Enter your full name",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: _inputDecoration('Full Name'),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Enter your email",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: _inputDecoration('Email'),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Enter promo code (if applicable)",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _promoCodeController,
                decoration: _inputDecoration('Promo Code'),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                    activeColor: Constants.AppColors.primaryColor,
                  ),
                  const Expanded(
                    child: Text(
                      "By signing up, I agree to the terms and conditions",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isChecked ? _submitProfile : null,
                  icon: Icon(Icons.check, color: Colors.white),
                  label: const Text('Submit Profile', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Or sign in with"),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _googleSignIn,
                icon: Icon(Icons.account_circle, color: Colors.white),
                label: const Text('Google', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _appleSignIn,
                icon: Icon(Icons.account_circle, color: Colors.white),
                label: const Text('Apple', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
