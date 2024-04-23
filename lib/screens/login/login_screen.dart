import 'package:flutter/material.dart';
import 'package:mibigbro_ventas_mobile/controllers/login_controller.dart';
import 'package:mibigbro_ventas_mobile/screens/home/home_screen.dart';
import 'package:mibigbro_ventas_mobile/screens/login/forgot_password/forgot_password_email_screen.dart';

// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:mibigbro/models/respuesta_crear_usuario.dart';
// import 'package:mibigbro/rest_api/provider/user_provider.dart';
// import 'package:mibigbro/screens/login/reset_password_email.dart';
// import 'package:mibigbro/screens/login/validar_codigo.dart';
// import 'package:mibigbro/utils/notifications_handler.dart';
// import 'package:mibigbro/utils/storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //
  // Controllers
  //
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  //
  // Keys
  //
  final GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();
  //
  // Notifiers
  //
  final ValueNotifier<bool> _showPasswordNotifier = ValueNotifier(false);

  //
  // Own Controllers
  //
  final LoginController _loginController = LoginController();

  void _login() async {
    final email = _email.text;
    final password = _pass.text;

    final successResponse = await _loginController.login(
      email: email,
      password: password,
    );

    if (successResponse) {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      }
    }
  }

  void _goToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ForgotPasswordEmailScreen(),
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
  void initState() {
    super.initState();
    //StorageUtils.init();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: _loginController,
        builder: (context, child) {
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
                                'Ingresa a tu cuenta',
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
                        key: _formKeyLogin,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                                controller: _email,
                                keyboardType: TextInputType.emailAddress,
                                decoration: inputDecoration(
                                  'Correo electrónico',
                                  Icons.person,
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
                            const SizedBox(height: 20),
                            ValueListenableBuilder<bool>(
                              valueListenable: _showPasswordNotifier,
                              builder: (BuildContext context, bool value,
                                  Widget? child) {
                                return TextFormField(
                                  obscureText: !value,
                                  controller: _pass,
                                  decoration: inputDecoration(
                                    'Contraseña',
                                    value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    () {
                                      _showPasswordNotifier.value =
                                          !_showPasswordNotifier.value;
                                    },
                                  ),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Contraseña es requerido';
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: _goToForgotPassword,
                                child: const Text(
                                  '¿Olvidaste tu contraseña?',
                                  style: TextStyle(
                                    color: Color(0xff979797),
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                )),
                                elevation:
                                    MaterialStateProperty.all<double>(0.0),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  const Color(0xff1D2766),
                                ),
                              ),
                              onPressed: _login,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: const Center(
                                  child: Text(
                                    "Ingresar",
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
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
