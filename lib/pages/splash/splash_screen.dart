import 'package:flutter/material.dart';
import 'package:pharmaps/pages/login/login_screen.dart';
import 'package:pharmaps/widgets/button_primary.dart';
import 'package:pharmaps/widgets/illustration.dart';
import 'package:pharmaps/widgets/logo_space.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LogoSpace(
        child: Column(
          children: [
            const SizedBox(
              height: 45,
            ),
            Illustration(
              image: "assets/location-searrch-animate.svg",
              title: "La pharmacie dans \nta poche",
              subtitle1: "Trouve une pharmacie de garde",
              subtitle2: "à n'importe quelle heure",
              child: ButtonPrimary(
                text: "Demarrer",
                onPressed: (){
                  Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen()));
                },
              ),
            )
          ],),
        ),
    );
  }
}