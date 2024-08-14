import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Corrected import statement
import 'package:get/get.dart';

import 'package:lockre/screens/ecarte/ecarte_menu.dart';
import 'package:lockre/screens/send/sender_number_screen.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            SvgPicture.asset(
              'assets/icon/money-recive.svg',
              width: 40,
            ),
            const Text("Recevoir"),
          ],
        ),
        GestureDetector(
          onTap: () {
           Get.to(() => SenderNumberScreen());
          },
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/icon/money-send.svg',
                width: 40,
              ),
              const Text("Envoyer"),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            
            Get.to(() => const  EcarteScreen());
          },
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/icon/card.svg',
                width: 40,
              ),
              const Text("E-carte"),
            ],
          ),
        ),
      ],
    );
  }
}
