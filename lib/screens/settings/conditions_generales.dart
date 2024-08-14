import 'package:flutter/material.dart';

class ConditionsGeneralesScreen extends StatelessWidget {
  const ConditionsGeneralesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conditions générales d’utilisation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Conditions Générales d’Utilisation',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              '1. Introduction',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Bienvenue sur notre application. En utilisant notre application, vous acceptez nos conditions générales d’utilisation. Veuillez les lire attentivement.',
            ),
            SizedBox(height: 16),
            Text(
              '2. Acceptation des Conditions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'En accédant à notre application et en l\'utilisant, vous acceptez de vous conformer aux présentes conditions générales d’utilisation. Si vous n\'acceptez pas ces conditions, vous ne devez pas utiliser notre application.',
            ),
            SizedBox(height: 16),
            Text(
              '3. Utilisation de l\'Application',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Vous vous engagez à utiliser l\'application de manière légale et appropriée. Vous ne devez pas utiliser l\'application à des fins illégales ou non autorisées. Vous acceptez de ne pas modifier, copier, distribuer, transmettre, afficher, exécuter, reproduire, publier, accorder sous licence, créer des œuvres dérivées, transférer ou vendre des informations, logiciels, produits ou services obtenus à partir de l\'application.',
            ),
            SizedBox(height: 16),
            Text(
              '4. Comptes Utilisateur',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Pour utiliser certaines fonctionnalités de notre application, vous devrez créer un compte utilisateur. Vous acceptez de fournir des informations exactes, complètes et à jour lors de la création de votre compte. Vous êtes responsable de la confidentialité de votre mot de passe et de toutes les activités qui se produisent sous votre compte.',
            ),
            SizedBox(height: 16),
            Text(
              '5. Propriété Intellectuelle',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Tout le contenu présent sur l\'application, y compris mais sans s\'y limiter, les textes, graphiques, logos, icônes, images, clips audio, téléchargements numériques et logiciels, est la propriété de notre société ou de ses fournisseurs de contenu et est protégé par les lois internationales sur le droit d\'auteur.',
            ),
            SizedBox(height: 16),
            Text(
              '6. Limitation de Responsabilité',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Notre société ne sera pas responsable des dommages de toute nature résultant de l\'utilisation de cette application, y compris mais sans s\'y limiter, les dommages directs, indirects, accessoires, punitifs et consécutifs.',
            ),
            SizedBox(height: 16),
            Text(
              '7. Modifications des Conditions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Nous nous réservons le droit de modifier ces conditions générales d\'utilisation à tout moment. Vous êtes responsable de la consultation régulière des conditions générales d\'utilisation. Votre utilisation continue de l\'application après toute modification constitue votre acceptation des nouvelles conditions.',
            ),
            SizedBox(height: 16),
            Text(
              '8. Résiliation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Nous nous réservons le droit de résilier ou de suspendre votre accès à notre application, sans préavis, pour quelque raison que ce soit, y compris mais sans s\'y limiter, une violation de ces conditions générales d\'utilisation.',
            ),
            SizedBox(height: 16),
            Text(
              '9. Droit Applicable',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Les présentes conditions générales d\'utilisation sont régies et interprétées conformément aux lois de notre pays. Tout litige relatif à ces conditions générales d\'utilisation sera soumis à la juridiction exclusive des tribunaux de notre pays.',
            ),
            SizedBox(height: 16),
            Text(
              '10. Contactez-nous',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Si vous avez des questions concernant ces conditions générales d\'utilisation, veuillez nous contacter à l\'adresse suivante : [votre.email@exemple.com]',
            ),
          ],
        ),
      ),
    );
  }
}
