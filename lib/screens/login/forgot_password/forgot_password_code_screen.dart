import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:mibigbro_ventas_mobile/screens/login/forgot_password/forgot_password_new_password_screen.dart';
import 'package:mibigbro_ventas_mobile/widgets/bigbro_scaffold.dart';

class ForgotPasswordCodeScreen extends StatefulWidget {
  const ForgotPasswordCodeScreen({
    super.key,
  });

  @override
  State<ForgotPasswordCodeScreen> createState() =>
      _ForgotPasswordCodeScreenState();
}

class _ForgotPasswordCodeScreenState extends State<ForgotPasswordCodeScreen> {
  final TextEditingController _code = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _repeatPassword = TextEditingController();

  final GlobalKey<FormState> _formKeyPasswordResetCodigoUsuario =
      GlobalKey<FormState>();

  final ValueNotifier<bool> _showPasswordNotifier = ValueNotifier(false);
  final ValueNotifier<bool> _repeatShowPasswordNotifier = ValueNotifier(false);

  InputDecoration inputDecoration(
      String text, IconData icono, VoidCallback onTap) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(fontSize: 12),
      hintText: text,
      suffixIcon: GestureDetector(
        onTap: onTap,
        child: Icon(
          icono,
          color: const Color(0xffCDD4D9),
        ),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xffCDD4D9),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xffCDD4D9),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xffCDD4D9),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.all(10),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BigBroScaffold(
      title: 'Ingresa el código de verificación',
      subtitle: 'Te hemos enviado un código via email',
      backIcon: Icons.close,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                ),
                child: Form(
                  key: _formKeyPasswordResetCodigoUsuario,
                  child: Column(
                    children: <Widget>[
                      OtpTextField(
                        numberOfFields: 4,
                        borderColor: Theme.of(context).colorScheme.secondary,
                        focusedBorderColor:
                            Theme.of(context).colorScheme.secondary,
                        styles: const [
                          TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                        showFieldAsBox: false,
                        borderWidth: 4.0,
                        disabledBorderColor:
                            Theme.of(context).colorScheme.secondary,
                        enabledBorderColor:
                            Theme.of(context).colorScheme.secondary,
                        //runs when a code is typed in
                        onCodeChanged: (String code) {
                          //handle validation or checks here if necessary
                        },
                        //runs when every textfield is filled
                        onSubmit: (String verificationCode) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const ForgotPasswordNewPasswordScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "¿No recibiste el código? ",
                    style: TextStyle(
                      color: Color(0xff707070),
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Haz clic aquí",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.underline,
                        decorationColor:
                            Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
