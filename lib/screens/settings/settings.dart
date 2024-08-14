import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:lockre/constants/colors.dart';
import 'package:lockre/screens/settings/contact_support_screen.dart';
import 'package:lockre/screens/settings/rate_lockre.dart'; // Import the RateLockreDialog
import 'package:lockre/screens/home/home.dart';
import 'logout.dart';
import 'package:lockre/screens/settings/politiques_confident.dart';
import 'package:lockre/screens/settings/promo_code_screen.dart';
import 'package:lockre/screens/auth/reset/reset_password.dart';
import 'package:lockre/screens/settings/limites_de_transaction.dart';
import 'package:lockre/screens/settings/conditions_generales.dart';
import 'package:lockre/screens/settings/connected_devices_screen.dart';

// Import onboarding screens


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDialogVisible = false;
  bool _isRatingDialogVisible = false;

  void _showDialog() {
    setState(() {
      _isDialogVisible = true;
    });
  }

  void _hideDialog() {
    setState(() {
      _isDialogVisible = false;
    });
  }

  void _showRatingDialog() {
    setState(() {
      _isRatingDialogVisible = true;
    });
  }

  void _hideRatingDialog() {
    setState(() {
      _isRatingDialogVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => const HomeScreen()); // Navigate to the HomeScreen
        return false; // Prevent back button press
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Paramètres'),
          backgroundColor: _isDialogVisible || _isRatingDialogVisible ? Colors.white.withOpacity(0.35) : Colors.white,
        ),
        backgroundColor: _isDialogVisible || _isRatingDialogVisible ? Colors.black.withOpacity(0.6) : Colors.white,
        body: Stack(
          children: [
            Opacity(
              opacity: _isDialogVisible || _isRatingDialogVisible ? 0.4 : 1.0,
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SettingsContent(showDialogCallback: _showDialog, showRatingDialogCallback: _showRatingDialog),
                  ),
                ),
              ),
            ),
            if (_isDialogVisible)
              Center(
                child: ContactSupportDialog(
                  onClose: _hideDialog,
                  isDialogVisible: _isDialogVisible,
                ),
              ),
            if (_isRatingDialogVisible)
              Center(
                child: RateLockreDialog(onClose: _hideRatingDialog),
              ),
          ],
        ),
      ),
    );
  }
}

class SettingsContent extends StatelessWidget {
  final VoidCallback showDialogCallback;
  final VoidCallback showRatingDialogCallback;

  const SettingsContent({required this.showDialogCallback, required this.showRatingDialogCallback, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Partage'),
        _buildSection(
          options: [
            SettingOption(
              icon: Icons.share,
              title: 'Inviter un ami à utiliser Lockré',
              onTap: () {
                Share.share(
                  'Je vous invite à utiliser Lockré. C\'est une app avec des services de qualité!',
                  subject: 'Invitation à utiliser Lockré',
                );
              },
            ),
            SettingOption(
              icon: Icons.card_giftcard,
              title: 'Mon code promo',
              onTap: () {
                Get.to(() => const PromoCodeScreen());
              },
            ),
          ],
        ),
        const SectionHeader(title: 'Assistance'),
        _buildSection(
          options: [
            SettingOption(
              icon: Icons.phone,
              title: 'Contacter l’assistance',
              onTap: showDialogCallback,
            ),
            SettingOption(
              icon: CupertinoIcons.chart_bar_alt_fill,
              title: 'Vérifier les limites',
              onTap: () {
                Get.to(() => const LimitesDeTransactionScreen());
              },
            ),
            SettingOption(
              icon: Icons.description,
              title: 'Conditions générales d’utilisation',
              onTap: () {
                Get.to(() => const ConditionsGeneralesScreen());
              },
            ),
            SettingOption(
              icon: Icons.privacy_tip,
              title: 'Politiques de confidentialité',
              onTap: () {
                Get.to(() => const PolitiquesConfidentialiteScreen());
              },   
            ),
          ],
        ),
        const SectionHeader(title: 'Sécurité'),
        _buildSection(
          options: [
            SettingOption(
              icon: Icons.phone_iphone,
              title: 'Vos appareils connectés',
              onTap: () {
                Get.to(() => const ConnectedDevicesScreen());
              },
            ),
            SettingOption(
              icon: Icons.lock,
              title: 'Changer mon mot de passe',
              onTap: () {
                Get.to(() => const ChangePasswordScreen());
              },
            ),
          ],
        ),
        const SectionHeader(title: 'Actions'),
        _buildSection(
          options: [
            SettingOption(
              icon: Icons.star,
              title: 'Noter Lockré',
              onTap: showRatingDialogCallback,
            ),
            SettingOption(
              icon: Icons.logout,
              title: 'Déconnexion',
              titleColor: Colors.black,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return LogoutDialog();
                  },
                );
              },
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

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
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
          leading: Icon(widget.icon, color: _iconColorAnimation.value),
          title: Text(
            widget.title,
            style: TextStyle(
              color: _textColorAnimation.value,
            ),
          ),
          onTap: _handleTap,
        );
      },
    );
  }
}
