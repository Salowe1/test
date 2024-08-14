import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lockre/constants/colors.dart';

class ContactSellerScreen extends StatefulWidget {
  @override
  _ContactSellerScreenState createState() => _ContactSellerScreenState();
}

class _ContactSellerScreenState extends State<ContactSellerScreen> {
  bool _isWhatsAppPressed = false;
  bool _isPhonePressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Description des lieux',
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/image/parcel.jpeg',
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                'Parcelle à vendre à Karpala',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              
             
              Text(
                "Parcelle d'une superficie de 1 hectare de type habitationnel "
                "clôturé de trois côtés à vendre au quartier Karpala en allant vers la radio des écoles.\n\n"
                "Très bien placé et très accessible pour vos projets de construction "
                "de minivilla, duplex villa, magasin...\n\n"
                "Superficie : 1 hectare\n"
                "Document : fiche d'attribution\n"
                "Prix : 6 Millions de FCFA négociable",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    _animatedButton(
                      onPressed: () async {
                        final phoneNumber = '+22607077418';
                        final text =
                            Uri.encodeComponent("Bonjour, je suis intéressé par la parcelle. Pouvez-vous me donner plus de détails?");
                        final url = 'https://wa.me/$phoneNumber?text=$text';
                        
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      label: 'Contacter par WhatsApp',
                      icon: FontAwesomeIcons.whatsapp,
                      isPressed: _isWhatsAppPressed,
                      color: Colors.green,
                      onHighlightChanged: (value) {
                        setState(() {
                          _isWhatsAppPressed = value;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    _animatedButton(
                      onPressed: () async {
                        final phoneUrl = 'tel:+22607077418';
                        if (await canLaunch(phoneUrl)) {
                          await launch(phoneUrl);
                        } else {
                          throw 'Could not launch $phoneUrl';
                        }
                      },
                      label: 'Appeler le vendeur',
                      icon: Icons.phone,
                      isPressed: _isPhonePressed,
                      color: AppColors.primaryColor,
                      onHighlightChanged: (value) {
                        setState(() {
                          _isPhonePressed = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _animatedButton({
    required VoidCallback onPressed,
    required String label,
    required IconData icon,
    required bool isPressed,
    required Color color,
    required ValueChanged<bool> onHighlightChanged,
  }) {
    final buttonColor = isPressed ? Colors.white : color;
    final textColor = isPressed ? color : Colors.white;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: double.infinity,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: color),
      ),
      child: InkWell(
        onTap: onPressed,
        onHighlightChanged: onHighlightChanged,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor),
              SizedBox(width: 10),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
