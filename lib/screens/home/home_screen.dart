import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mibigbro_ventas_mobile/controllers/login_controller.dart';
import 'package:mibigbro_ventas_mobile/screens/applications/applications_screen.dart';
import 'package:mibigbro_ventas_mobile/screens/login/login_screen.dart';
import 'package:mibigbro_ventas_mobile/screens/search_client/search_client_renovation_screen.dart';
import 'package:mibigbro_ventas_mobile/screens/search_client/search_client_screen.dart';
import 'package:mibigbro_ventas_mobile/utils/app_colors.dart';
import 'package:mibigbro_ventas_mobile/utils/spacing.dart';
import 'package:mibigbro_ventas_mobile/utils/storage/storage_helper.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  static const TextStyle optionStyleTitle = TextStyle(
    color: Color(0xff1D2766),
    fontSize: 13.0,
    height: 1,
    fontFamily: 'Manrope',
    fontWeight: FontWeight.w600,
  );
  static const TextStyle optionStyle = TextStyle(
    color: Color(0xff1D2766),
    fontSize: 15.0,
    height: 1,
    fontFamily: 'Manrope',
    fontWeight: FontWeight.w400,
  );
  static const TextStyle panelTitleStyle = TextStyle(
    color: Color(0xff1D2766),
    fontSize: 22.0,
    height: 1,
    fontFamily: 'Manrope',
    fontWeight: FontWeight.w700,
  );
  static const TextStyle panelTitleAvisoStyle = TextStyle(
    color: Colors.red,
    fontSize: 18.0,
    height: 1,
    fontFamily: 'Manrope',
    fontWeight: FontWeight.w700,
  );
  static const TextStyle panelStyle = TextStyle(
    color: Color(0xff1D2766),
    fontSize: 12.0,
    fontFamily: 'Manrope',
    fontWeight: FontWeight.w400,
  );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final ValueNotifier<bool> isDrawerOpened = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          onDrawerChanged: (isOpened) {
            isDrawerOpened.value = isOpened;
          },
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: ValueListenableBuilder<bool>(
              valueListenable: isDrawerOpened,
              builder: (context, isDrawerOpened, child) {
                return Container(
                  height: 86,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                );
              }),
          key: scaffoldKey,
          drawer: const HomeDrawer(),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: SpacingValues.l,
                  horizontal: SpacingValues.m * 2,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(SpacingValues.xl),
                    bottomRight: Radius.circular(SpacingValues.xl),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: SpacingValues.xl,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            scaffoldKey.currentState!.openDrawer();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                SpacingValues.m,
                              ),
                            ),
                            child: Icon(
                              Icons.menu,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    VerticalSpacing.m,
                    Text(
                      'Bienvenid@, ${loginControllerInstance.loginResponse!.usarioNombre}',
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: _inicioBody(
                    context,
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 2 - 40,
          bottom: 20,
          child: ValueListenableBuilder<bool>(
            valueListenable: isDrawerOpened,
            builder: (context, isDrawerOpened, child) {
              if (isDrawerOpened) return const SizedBox();

              return Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 10,
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/img/svg/house.svg',
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget _inicioBody(
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: SpacingValues.m,
        horizontal: SpacingValues.m * 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            '¿Qué deseas hacer?',
            style: TextStyle(
              color: Color(0xff464646),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          VerticalSpacing.l,
          Row(
            children: [
              Expanded(
                child: _optionButton(
                  carImagePath: 'assets/img/car1.png',
                  text: 'Solicitar\nSeguro',
                  gradientColors: [
                    const Color(0xffE82220),
                    const Color(0xffE11C24),
                  ],
                  onTapped: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SearchClientScreen(),
                      ),
                    );
                    return;
                  },
                ),
              ),
              const SizedBox(
                width: SpacingValues.l,
              ),
              Expanded(
                child: Container(
                  child: _optionButton(
                    carImagePath: 'assets/img/car2.png',
                    text: 'Renovar\nSeguro',
                    gradientColors: [
                      const Color(0xff1D2766).withOpacity(0.86),
                      const Color(0xff1A2461),
                    ],
                    onTapped: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SearchClientRenovationScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 28,
          ),
          _extraOptionButton(
            context,
            title: 'Tus Registros',
            subtitle: 'Visualiza tu listado de seguros activos y pagados',
            icon: SvgPicture.asset(
              'assets/img/svg/solicitudes.svg',
            ),
            onTapped: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ApplicationsScreen(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 28,
          ),
          _extraOptionButton(
            context,
            title: 'Conoce a miBigbro',
            subtitle: 'Te explicamos como funciona el seguro que ofrecemos',
            icon: SvgPicture.asset(
              'assets/img/svg/conoce.svg',
            ),
            onTapped: _launchLandingURL,
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  _launchLandingURL() async {
    const url = 'http://www.mibigbro.com';
    try {
      await launchUrlString(url);
    } catch (error) {
      throw 'Could not launch $url';
    }
  }

  Widget _optionButton({
    required String text,
    required VoidCallback onTapped,
    required List<Color> gradientColors,
    required String carImagePath,
  }) {
    return GestureDetector(
      onTap: onTapped,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 28,
              right: 52,
              top: SpacingValues.m * 2,
              bottom: SpacingValues.l * 6,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
              ),
              borderRadius: BorderRadius.circular(SpacingValues.l * 3),
            ),
            child: AutoSizeText(
              text,
              style: const TextStyle(
                color: Colors.transparent,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            right: 0.0,
            child: Stack(
              children: [
                const SizedBox(
                  height: 100,
                  width: 100,
                ),
                Positioned.fill(
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      child: Image.asset('assets/img/elipse1.png'),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Image.asset('assets/img/elipse2.png'),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 26.0,
            left: 26.0,
            child: Image.asset(carImagePath),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 28,
              right: 52,
              top: SpacingValues.m * 2,
              bottom: SpacingValues.l * 6,
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _extraOptionButton(
    BuildContext context, {
    required VoidCallback onTapped,
    required Widget icon,
    required String title,
    required String subtitle,
  }) {
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff5C5C5C).withOpacity(0.16),
              offset: const Offset(0, 3),
              blurRadius: 15,
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                color: const Color(0xffF4F4F4),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Center(
                child: icon,
              ),
            ),
            HorizontalSpacing.l,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      color: AppColors.textBlack,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      color: AppColors.textBlack,
                      height: 1,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        height: double.infinity,
        width: MediaQuery.of(context).size.width * 0.5,
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (_) {
                  //           return const Contacto();
                  //         },
                  //       ),
                  //     );
                  //   },
                  //   child: const Row(
                  //     children: [
                  //       Icon(Icons.lock, color: Colors.white),
                  //       SizedBox(
                  //         width: 8,
                  //       ),
                  //       Expanded(
                  //         child: Text(
                  //           'Modificar Contraseña',
                  //           style: TextStyle(color: Colors.white, fontSize: 18),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  GestureDetector(
                    onTap: () {
                      storageHelper.clearUsernameAnPassword();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.exit_to_app, color: Colors.white),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Cerrar Sesión',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
