import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:lockre/constants/colors.dart'; // Make sure to import your AppColors here

class ContactSupportDialog extends StatelessWidget {
  final VoidCallback onClose;
  final bool isDialogVisible;

  const ContactSupportDialog({
    required this.onClose,
    required this.isDialogVisible,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose, 
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
                child:
      Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              title: const Text(
                "Contacter l'assistance",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),

              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: onClose,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
              title: const Text('WhatsApp'),
              subtitle: const Text('Messages et audio uniquement'),
              onTap: () async {
                final link = WhatsAppUnilink(
                  phoneNumber: '+22607077418',
                  text:
                      "Bonjour comment allez vous? J'aimerais avoir des éclairssissements sur le mode de fonctionnement de votre système",
                );
                await launch('$link');
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.blue),
              title: const Text('Appel téléphonique'),
              subtitle: const Text('Ouvert jusqu\'à 16h'),
              onTap: () async {
                final phoneUrl = 'tel:+22607077418';
                if (await canLaunch(phoneUrl)) {
                  await launch(phoneUrl);
                } else {
                  throw 'Could not launch $phoneUrl';
                }
              },
            ),
          ],
        ),
      ),
      )
    )
    
    )
    
        
         
      ),
        
        ],
      )
      );
  }
}
