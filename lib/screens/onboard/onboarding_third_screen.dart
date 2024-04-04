import 'package:flutter/material.dart';
import 'package:mibigbro_ventas_mobile/screens/login/login_screen.dart';

class OnboardingThirdScreen extends StatelessWidget {
  const OnboardingThirdScreen({super.key});

  void _goToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
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
                'assets/img/onboard3.png',
                width: 250,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Cuando más lo necesites",
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
                "Adquiere el paquete por días que mas te conviene",
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
                onPressed: () => _goToLogin(context),
                child: const Text(
                  "Empezar",
                  style: TextStyle(color: Color(0xff1D2766)),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
