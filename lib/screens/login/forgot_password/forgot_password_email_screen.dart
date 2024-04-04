import 'package:flutter/material.dart';
import 'package:mibigbro_ventas_mobile/screens/login/forgot_password/forgot_password_code_screen.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final TextEditingController _email = TextEditingController();

  final GlobalKey<FormState> _formKeyPasswordResetEmail =
      GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void _goToEnterCode() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ForgotPasswordCodeScreen(),
      ),
    );
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/img/headerpainter.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: double.infinity,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 120),
                      child: const Center(
                        child: Text(
                          'Ingresa el correo registrado',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        'assets/img/logo-mibigbro-dark.png',
                        width: 150,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                ),
                child: Form(
                  key: _formKeyPasswordResetEmail,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: inputDecoration(
                            'Correo electrónico',
                            Icons.email,
                            () {},
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Correo electrónico es requerido';
                            }
                            if (!RegExp(
                                    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                .hasMatch(value)) {
                              return 'Ingrese un correo electrónico valido';
                            }

                            return null;
                          }),
                      const SizedBox(height: 110),
                      const SizedBox(
                        height: 80,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                          elevation: MaterialStateProperty.all<double>(0.0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xff1D2766),
                          ),
                        ),
                        onPressed: _goToEnterCode,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          child: const Center(
                            child: Text(
                              "Enviar",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '¿No lo recibiste? ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff707070),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Haz clic aquí",
                      style: TextStyle(
                        color: const Color(0xffEC1C24),
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
