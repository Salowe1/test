import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lockre/constants/colors.dart';
import 'package:lockre/screens/settings/contact_support_screen.dart';
import 'package:lockre/screens/ecarte/my_ecarte.dart';
import 'package:lockre/screens/ecarte/ecarte_order.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class EcarteScreen extends StatefulWidget {
  const EcarteScreen({Key? key}) : super(key: key);

  @override
  _EcarteScreenState createState() => _EcarteScreenState();
}

class _EcarteScreenState extends State<EcarteScreen> {
  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: true, // Allows dismissing by tapping outside
      builder: (BuildContext context) {
        return Stack(
          children: [
            AlertDialog(
              title: const Text(
                "Contacter l'assistance",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
                    title: const Text('WhatsApp'),
                    subtitle: const Text('Messages et audio uniquement'),
                    onTap: () async {
                      final link = WhatsAppUnilink(
                        phoneNumber: '+22607077418',
                        text: "Bonjour comment allez vous? J'aimerais avoir des éclairssissements sur le mode de fonctionnement de votre système",
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
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: AppColors.primaryColor,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(); // Navigate back
        return false; // Prevent back button press
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('E-carte'),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: EcarteContent(showDialogCallback: _showDialog),
          ),
        ),
      ),
    );
  }
}

class EcarteContent extends StatelessWidget {
  final VoidCallback showDialogCallback;

  const EcarteContent({required this.showDialogCallback, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSection(
          options: [
            SettingOption(
              icon: Icons.arrow_forward,
              title: "Ma carte virtuelle",
              onTap: () {
                Get.to(() => MyEcarteScreen());
              },
            ),
            SettingOption(
              icon: Icons.arrow_forward,
              title: 'Commander une carte virtuelle',
              onTap: () {
                Get.to(() => EcarteOrderScreen()); // Navigate to the new screen
              },
            ),
            SettingOption(
              icon: Icons.arrow_forward,
              title: "Je n'ai pas recu ma carte virtuelle",
              onTap: showDialogCallback, // Pass the showDialogCallback function here
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSection({required List<Widget> options}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: options,
      ),
    );
  }
}

class SettingOption extends StatefulWidget {
  final IconData icon;
  final String title;
  final Color? titleColor;
  final VoidCallback? onTap;

  const SettingOption({
    required this.icon,
    required this.title,
    this.titleColor,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  _SettingOptionState createState() => _SettingOptionState();
}

class _SettingOptionState extends State<SettingOption> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _iconColorAnimation;
  late Animation<Color?> _textColorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _iconColorAnimation = ColorTween(
      begin: Colors.black,
      end: AppColors.primaryColor,
    ).animate(_controller);

    _textColorAnimation = ColorTween(
      begin: widget.titleColor ?? Colors.black,
      end: AppColors.primaryColor,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _controller.reverse();
    });

    if (widget.onTap != null) {
      widget.onTap!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ListTile(
          title: Text(
            widget.title,
            style: TextStyle(
              fontSize: 16, // Reduced text size
              color: _textColorAnimation.value,
            ),
          ),
          trailing: Icon(widget.icon, color: _iconColorAnimation.value),
          onTap: _handleTap,
        );
      },
    );
  }
}
