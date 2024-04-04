import 'package:flutter/material.dart';

import 'onboarding_third_screen.dart';

class OnboardingSecondScreen extends StatelessWidget {
  const OnboardingSecondScreen({
    super.key,
  });

  void _goToOnboardingThird(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OnboardingThirdScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1D2766),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Image.asset(
                'assets/img/onboard2.png',
                width: 250,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Fácil, rápido y seguro",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.0,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                "Nunca antes que tu automóvil este protegido  fue tan sencillo",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xff9ED1FF),
                  ),
                  elevation: MaterialStateProperty.all(0),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 36,
                    ),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                onPressed: () => _goToOnboardingThird(context),
                child: const Text(
                  "Siguiente",
                  style: TextStyle(color: Color(0xff1D2766)),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
