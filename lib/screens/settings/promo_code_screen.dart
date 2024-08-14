import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lockre/constants/colors.dart';

class PromoCodeScreen extends StatelessWidget {
  const PromoCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Code promo'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Votre code promo',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 38, 37, 37),
              ),
            ),
            const SizedBox(height: 8),
            const AnimatedPromoCode(),
          ],
        ),
      ),
    );
  }
}

class AnimatedPromoCode extends StatefulWidget {
  const AnimatedPromoCode({Key? key}) : super(key: key);

  @override
  _AnimatedPromoCodeState createState() => _AnimatedPromoCodeState();
}

class _AnimatedPromoCodeState extends State<AnimatedPromoCode>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  bool _isIconClicked = false; // Variable to track the click state of the icon

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _colorAnimation = ColorTween(
      begin: AppColors.primaryColor,
      end: Colors.transparent,
    ).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
        setState(() {
          _isIconClicked = false; // Reset the click state after the animation completes
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.forward();
  }

  void _onIconClicked() {
    _startAnimation();
    setState(() {
      _isIconClicked = true; // Set the click state of the icon to true
    });
    // Copy code to clipboard
    Clipboard.setData(const ClipboardData(text: "3505"));
    // Show SnackBar message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Le code a été copié avec succès')), // Message shown after copying
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '3505',
              style: TextStyle(
                fontSize: 20,
                color: AppColors.primaryColor,
              ),
            ),
            Spacer(), // To push the copy icon to the right end
            GestureDetector(
              onTap: _onIconClicked,
              child: Icon(
                Icons.copy,
                color: _isIconClicked ? AppColors.primaryColor : Colors.black,
              ), // Change color based on click state
            ),
          ],
        ),
        AnimatedBuilder(
          animation: _colorAnimation,
          builder: (context, child) {
            return Container(
              height: 2,
              margin: const EdgeInsets.only(top: 8),
              width: 350, // Set the width to match the text width
              decoration: BoxDecoration(
                color: _colorAnimation.value,
              ),
            );
          },
        ),
      ],
    );
  }
}
