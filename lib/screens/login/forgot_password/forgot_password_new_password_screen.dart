import 'package:flutter/material.dart';

class ForgotPasswordNewPasswordScreen extends StatefulWidget {
  const ForgotPasswordNewPasswordScreen({
    super.key,
  });

  @override
  State<ForgotPasswordNewPasswordScreen> createState() =>
      _ForgotPasswordNewPasswordScreenState();
}

class _ForgotPasswordNewPasswordScreenState
    extends State<ForgotPasswordNewPasswordScreen> {
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
                          'Ingresa nueva contraseña',
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
                  key: _formKeyPasswordResetCodigoUsuario,
                  child: Column(
                    children: <Widget>[
                      ValueListenableBuilder<bool>(
                        valueListenable: _showPasswordNotifier,
                        builder:
                            (BuildContext context, bool value, Widget? child) {
                          return TextFormField(
                            obscureText: !value,
                            controller: _password,
                            decoration: inputDecoration('Nueva contraseña',
                                value ? Icons.visibility_off : Icons.visibility,
                                () {
                              _showPasswordNotifier.value =
                                  !_showPasswordNotifier.value;
                            }),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Nueva contraseña es requerido';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: _repeatShowPasswordNotifier,
                        builder:
                            (BuildContext context, bool value, Widget? child) {
                          return TextFormField(
                            obscureText: !value,
                            controller: _repeatPassword,
                            decoration: inputDecoration('Repite tu contraseña',
                                value ? Icons.visibility_off : Icons.visibility,
                                () {
                              _repeatShowPasswordNotifier.value =
                                  !_repeatShowPasswordNotifier.value;
                            }),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Repetir contraseña es repetido';
                              }
                              return null;
                            },
                          );
                        },
                      ),
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
                        onPressed: () async {},
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          child: const Center(
                            child: Text(
                              "Ingresar",
                              style: TextStyle(fontSize: 14.0),
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
                    "No tengo cuenta  ",
                    style: TextStyle(
                      color: Color(0xff707070),
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Registrar",
                      style: TextStyle(
                        color: Color(0xffEC1C24),
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.underline,
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
