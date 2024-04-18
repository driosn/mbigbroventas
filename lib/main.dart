import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mibigbro_ventas_mobile/screens/onboard/onboarding_first_screen.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final status = await Permission.notification.status;

  if (status.isDenied) {
    await Permission.notification.request();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
          background: Colors.white,
          error: Colors.red,
          onBackground: Theme.of(context).primaryColor,
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
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(color: Colors.white),
            ),
            elevation: MaterialStateProperty.all<double>(0.0),
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color(0xff1A2461),
            ),
            shape: MaterialStateProperty.all(
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
      home: const OnboardingFirstScreen(),
    );
  }
}
