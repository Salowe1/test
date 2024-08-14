import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lockre/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatelessWidget {
  void _onIntroEnd(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false); // Set first time launch to false
    Get.offAllNamed('/firstPage');
  }

  @override
  Widget build(BuildContext context) {
    final customPrimary = AppColors.primaryColor;

    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'Transférez de l\'argent en toute sécurité',
          body: 'Utilisez notre application pour envoyer de l\'argent à vos proches en toute simplicité.',
          image: SvgPicture.asset('assets/icon/onboarding1.svg', height: 250),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: customPrimary),
            bodyTextStyle: TextStyle(fontSize: 16, color: const Color.fromARGB(96, 0, 0, 0)),
          ),
        ),
        PageViewModel(
          title: 'Profitez des promotions exclusives',
          body: 'Accédez à nos services de publicité et rendez vos produits encore plus visibles par la communauté.',
          image: SvgPicture.asset('assets/icon/onboarding2.svg', height: 250),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: customPrimary),
            bodyTextStyle: TextStyle(fontSize: 16, color: const Color.fromARGB(96, 0, 0, 0)),
          ),
        ),
        PageViewModel(
          title: 'Commandez votre carte virtuelle',
          body: 'Commandez votre carte virtuelle avec le montant de votre choix et effectuez vos paiements en ligne.',
          image: SvgPicture.asset('assets/icon/onboarding3.svg', height: 250),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: customPrimary),
            bodyTextStyle: TextStyle(fontSize: 16, color: const Color.fromARGB(96, 0, 0, 0)),
          ),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      skip: const Text("Avancer", style: TextStyle(color: AppColors.primaryColor)),
      next: const Icon(Icons.arrow_forward, color: AppColors.primaryColor),
      done: const Text("Commencer", style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.primaryColor)),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: customPrimary,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}
