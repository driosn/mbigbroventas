import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mibigbro_ventas_mobile/controllers/login_controller.dart';
import 'package:mibigbro_ventas_mobile/screens/home/home_screen.dart';
import 'package:mibigbro_ventas_mobile/screens/login/login_screen.dart';
import 'package:mibigbro_ventas_mobile/screens/onboard/onboarding_first_screen.dart';
import 'package:mibigbro_ventas_mobile/utils/app_colors.dart';
import 'package:mibigbro_ventas_mobile/utils/storage/storage_helper.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final status = await Permission.notification.status;

  if (status.isDenied) {
    await Permission.notification.request();
  }

  await storageHelper.init();
  final (String?, String?) usernameAndPassword =
      storageHelper.getUsernameAndPassword();

  runApp(
    MyApp(
      existsUser:
          usernameAndPassword.$1 != null && usernameAndPassword.$2 != null,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.existsUser,
  });

  final bool existsUser;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'mibigbro ventas',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', ''), // Spanish, no country code
      ],
      theme: ThemeData(
        useMaterial3: false,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xff1A2461),
          unselectedIconTheme: IconThemeData(
            color: Colors.grey,
          ),
          selectedLabelStyle: TextStyle(
            fontSize: 12,
          ),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Manrope',
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xffEC1C24),
        ),
        primaryColor: const Color(0xff1D2766),
        colorScheme: ColorScheme(
          secondary: const Color(0xffEC1C24),
          brightness: Brightness.light,
          error: Colors.red,
          onError: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Theme.of(context).primaryColor,
          primary: Theme.of(context).primaryColor,
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xffFCFCFC),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            textStyle: WidgetStateProperty.all<TextStyle>(
              const TextStyle(color: Colors.white),
            ),
            elevation: WidgetStateProperty.all<double>(0.0),
            backgroundColor: WidgetStateProperty.all<Color>(
              const Color(0xff1A2461),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff1D2766),
            ),
          ),
          iconColor: const Color(0xff1D2766),
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.6),
          ),
          labelStyle: TextStyle(
            color: Colors.black.withOpacity(0.6),
          ),
        ),
      ),
      // TODO: Implement initial route
      // initialRoute:
      // (StorageUtils.getInteger("id_usuario") == 0) ? 'onboard1' : 'home',
      home: widget.existsUser
          ? FutureBuilder<bool>(
              future: loginControllerInstance.login(
                email: storageHelper.getUsernameAndPassword().$1!,
                password: storageHelper.getUsernameAndPassword().$2!,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const HomeScreen();
                }

                if (snapshot.hasError) {
                  return const LoginScreen();
                }

                return Scaffold(
                  body: Container(
                    color: AppColors.primary,
                    child: Center(
                      child: SizedBox(
                        height: 120,
                        width: 120,
                        child: Image.asset('assets/img/logo_bigbro.png'),
                      ),
                    ),
                  ),
                );
              },
            )
          : const OnboardingFirstScreen(),
    );
  }
}
