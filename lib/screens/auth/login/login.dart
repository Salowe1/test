import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lockre/constants/colors.dart';
import 'package:lockre/screens/home/home.dart';
import 'package:lockre/screens/auth/signup/phone_number.dart';
import 'package:lockre/screens/auth/reset/reset_password.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

const MONGO_URL = "mongodb+srv://salowe:Adouabou102001.@lockre.xrasr0e.mongodb.net/?retryWrites=true&w=majority&appName=Lockre";
const USER_COLLECTION = "lockre";

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailOrNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _errorMessage = '';
  bool _passwordVisible = false;
  bool _isButtonPressed = false;
  bool _isSignUpButtonPressed = false;

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
      setState(() {
        _errorMessage = 'Failed to connect to the database. Please try again later.';
      });
    }
  }

  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      String emailOrName = _emailOrNameController.text.trim();
      String password = _passwordController.text.trim();

      try {
        Get.offAll(() => const HomeScreen());
        /* var user = await userCollection.findOne(mongo.where.eq('email', emailOrName).eq('password', password));

        if (user != null) {
          Get.offAll(() => const HomeScreen());
        } else {
          setState(() {
            _errorMessage = 'Login failed. Please check your credentials and try again.';
          });
        } */
      } catch (error) {
        print('Error signing in: $error');
        setState(() {
          _errorMessage = 'Login failed. Please check your credentials and try again.';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  InputDecoration _inputDecoration(String label, {IconData? icon, Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: icon != null ? Icon(icon) : null,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 100),
                Image.asset(
                  'assets/logo/lockre.png',
                  width: 150,
                ),
                const SizedBox(height: 50),
                TextFormField(
                  controller: _emailOrNameController,
                  decoration: _inputDecoration('Email or Name', icon: Icons.person),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email or name';
                    }
                    return null;
                  },
                  onTap: () {
                    setState(() {
                      _emailOrNameController.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset: _emailOrNameController.text.length,
                      );
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: _inputDecoration(
                    'Password',
                    icon: Icons.lock,
                    suffixIcon: IconButton(
                      icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_passwordVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onTap: () {
                    setState(() {
                      _passwordController.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset: _passwordController.text.length,
                      );
                    });
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: TextStyle(color: Colors.black),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isSignUpButtonPressed = true;
                        });
                        Get.to(() => PhoneNumberScreen());
                      },
                      onHighlightChanged: (value) {
                        setState(() {
                          _isSignUpButtonPressed = value;
                        });
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: _isSignUpButtonPressed ? AppColors.primaryColor : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Get.to(() => ChangePasswordScreen());
                  },
                  child: Text(
                    'Forgot my password?',
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ),
                const SizedBox(height: 20),
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 20),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  _animatedButton(
                    onPressed: _login,
                    label: 'Sign In',
                    isPressed: _isButtonPressed,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
