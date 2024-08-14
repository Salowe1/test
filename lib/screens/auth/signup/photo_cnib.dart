import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lockre/constants/colors.dart';
import 'package:lockre/screens/home/home.dart';
import 'package:lottie/lottie.dart';

class PhotoCnib extends StatefulWidget {
  @override
  _PhotoCnibState createState() => _PhotoCnibState();
}

class _PhotoCnibState extends State<PhotoCnib> with SingleTickerProviderStateMixin {
  File? selfieImage;
  ExtractedDataFromId? extractedDataFromId;
  bool? isMatchFace;
  bool isloading = false;
  bool faceMatchButtonPressed = false;
  Map<String, bool> keyWordData = {
    'Name': false,
    'Date of Birth': true,
    'NID No': false
  };

  int currentStep = 0; // Track current step index

  final Color btnColor = Colors.teal; // Define the btnColor variable here

  // Animation controller and animation
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EKYC Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStepCircle(context, "1", "Liveness Detection", currentStep >= 1),
                _buildStepCircle(context, "2", "Scan Your ID", currentStep >= 2),
                _buildStepCircle(context, "3", "Face Match with ID", currentStep >= 3),
              ],
            ),
            SizedBox(height: 20),
            _buildStepContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Welcome to the KYC Process",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Stack(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  currentStep = 1; // Move to the first step
                });
                _startAnimation(); // Start the animation
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: Text(
                  'Start the Process Now'.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  painter: CirclePainter(_animation.value),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStepCircle(BuildContext context, String step, String label, bool isCompleted) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: isCompleted ? AppColors.primaryColor : Colors.grey,
          child: Text(
            step,
            style: TextStyle(color: isCompleted ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: isCompleted ? Colors.black : Colors.grey),
        ),
      ],
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildWelcomeScreen();
      case 1:
        return _buildLivenessDetectionStep();
      case 2:
        return _buildScanIdStep();
      case 3:
        return _buildFaceMatchStep();
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildLivenessDetectionStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.network(
          'https://lottie.host/e1efb8c3-8d19-4690-9b58-e7c0b5bdad66/njl9xQH0T1.json',
        ),
        SizedBox(height: 20),
        TextButton(
          onPressed: () {
            // Replace with your liveness detection logic
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
            backgroundColor: AppColors.primaryColor,
            elevation: 9.0,
            textStyle: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          child: Text("Liveness Detection", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildScanIdStep() {
    return Column(
      children: [
        Lottie.network(
          'https://lottie.host/c58fd760-595b-405c-9e1f-fa2f303cfbbf/ZhjlOfFLUn.json',
        ),
        SizedBox(height: 20),
        TextButton(
          onPressed: () async {
            try {
              // Replace with your scan ID logic
            } catch (error) {
              print("Error occurred during ID scanning: $error");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error occurred during ID scanning: $error'),
                  duration: Duration(seconds: 3),
                ),
              );
            }
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
            backgroundColor: AppColors.primaryColor,
            elevation: 9.0,
            textStyle: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          child: Text("Scan Your ID", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildFaceMatchStep() {
    return Column(
      children: [
        Lottie.network(
          'https://lottie.host/c58fd760-595b-405c-9e1f-fa2f303cfbbf/ZhjlOfFLUn.json',
        ),
        SizedBox(height: 20),
        TextButton(
          onPressed: () async {
            try {
              // Replace with your face match logic
              // After successful face match, navigate to the HomeScreen
              Get.to(() => HomeScreen());
            } catch (error) {
              print("Error occurred during face match: $error");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error occurred during face match: $error'),
                  duration: Duration(seconds: 3),
                ),
              );
            }
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
            backgroundColor: AppColors.primaryColor,
            elevation: 9.0,
            textStyle: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          child: Text("Face Match with ID", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

class ShowImage extends StatelessWidget {
  final File? selfieImage;

  const ShowImage({Key? key, this.selfieImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selfie Image'),
      ),
      body: Center(
        child: selfieImage != null ? Image.file(selfieImage!) : Text('No image selected.'),
      ),
    );
  }
}

class ShowScannedText extends StatelessWidget {
  final String scannedText;
  final Map<String, String>? keyNvalue;

  const ShowScannedText({Key? key, required this.scannedText, this.keyNvalue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanned Text'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(scannedText),
            if (keyNvalue != null)
              ...keyNvalue!.entries.map((entry) => Text('${entry.key}: ${entry.value}')).toList(),
          ],
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double animationValue;

  CirclePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.fill;

    final circleSize = size.height;
    final xOffset = animationValue * (size.width + circleSize);

    canvas.drawCircle(Offset(xOffset, size.height / 2), circleSize / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ExtractedDataFromId {
}

class AppColors {
  static Color primaryColor = Colors.teal;
}
