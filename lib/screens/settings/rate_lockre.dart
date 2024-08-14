// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lockre/constants/colors.dart';



class RateLockreDialog extends StatefulWidget {
  final VoidCallback onClose;

  const RateLockreDialog({Key? key, required this.onClose}) : super(key: key);

  @override
  _RateLockreDialogState createState() => _RateLockreDialogState();
}

class _RateLockreDialogState extends State<RateLockreDialog> {
  int _selectedRating = 0;

  void _onStarTap(int index) {
    setState(() {
      _selectedRating = index + 1;
    });
  }

  void _onSubmit() {
    // Handle the submission of the rating (_selectedRating)
    print('User rated: $_selectedRating');
    // Close the dialog after submission
    widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      
      onTap: widget.onClose, // Dismiss dialog when tapped outside
      child: Stack(
        
        alignment: Alignment.center,
        children: [
          
          Container(
            color: Colors.black.withOpacity(0.1), // Semi-transparent background
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {}, // To prevent tap propagation to the underlying screen
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch, // Align children widgets horizontally
                      children: [
                        const SizedBox(height: 60),
                        const Text(
                          'Notez Lockré',
                          textAlign: TextAlign.center, // Center the text
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Avez-vous apprécié l’application Lockré? N’hésitez pas à la noter!',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return GestureDetector(
                              onTap: () => _onStarTap(index),
                              child: Icon(
                                index < _selectedRating ? Icons.star : Icons.star_border,
                                color: Colors.amber,
                                size: 40,
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: _onSubmit,
                          icon: const Icon(Icons.send, color: Colors.white),
                          label: const Text(
                            'Noter',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor, // Change button color as needed
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 225,
            child: GestureDetector(
              onTap: () {}, // To prevent tap propagation to the underlying screen
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: Image.asset(
                    'assets/logo/lockre.png',
                    width: 100,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
