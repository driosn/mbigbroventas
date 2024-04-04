import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mibigbro_ventas_mobile/screens/onboard/onboarding_second_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class OnboardingFirstScreen extends StatefulWidget {
  const OnboardingFirstScreen({
    super.key,
  });

  @override
  State<OnboardingFirstScreen> createState() => _OnboardingFirstScreenState();
}

class _OnboardingFirstScreenState extends State<OnboardingFirstScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final grantedPermission = await Permission.notification.isGranted;
      if (!grantedPermission) {
        final permissionStatus = await Permission.notification.request();
        if (kDebugMode) {
          print(permissionStatus);
        }
      }
    });
  }

  void _goToOnboardingSecond(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OnboardingSecondScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1D2766),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            50,
            10,
            50,
            10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Image.asset(
                'assets/img/onboard1.png',
                width: 250,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Protege tu automóvil",
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
                "Con el primer seguro automotor que se puede tomar por días.",
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
                onPressed: () => _goToOnboardingSecond(context),
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
