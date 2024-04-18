import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mibigbro_ventas_mobile/screens/plans/plan_confirmation_screen.dart';
import 'package:mibigbro_ventas_mobile/widgets/bigbro_scaffold.dart';

class PlansScreen extends StatelessWidget {
  final bool esRenovacion;

  const PlansScreen({
    super.key,
    this.esRenovacion = false,
  });

  @override
  Widget build(BuildContext context) {
    return BigBroScaffold(
      title: 'Personaliza tu seguro',
      centerWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/img/planes_seguro.png'),
          const Text(
            'Planes de Seguro',
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Paquetes(
        esRenovacion: esRenovacion,
      ),
    );
  }
}

class Paquetes extends StatefulWidget {
  final bool esRenovacion;

  const Paquetes({
    super.key,
    this.esRenovacion = false,
  });

  static const TextStyle optionStyleTitle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 12.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);

  static const TextStyle optionStyleTitle2 = TextStyle(
    color: Colors.red,
    fontSize: 10.0,
    height: 1,
    fontFamily: 'Manrope',
    fontWeight: FontWeight.w400,
  );

  static const TextStyle optionStyleTitleSelect = TextStyle(
      color: Colors.white,
      fontSize: 12.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);

  static const TextStyle panelTitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontFamily: 'Manrope',
    fontWeight: FontWeight.w500,
  );
  static const TextStyle panelStyle = TextStyle(
    color: Colors.white,
    fontSize: 25.0,
    height: 0.5,
    fontFamily: 'Manrope',
    fontWeight: FontWeight.w700,
  );

  @override
  _PaquetesState createState() => _PaquetesState();
}

class _PaquetesState extends State<Paquetes> {
  final appTitle = 'Personaliza tu seguro';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime hoy = DateTime.now();
    var fechaInicio = DateTime(hoy.year, hoy.month, hoy.day);
    return FutureBuilder<List<dynamic>>(
        future: Future.value([]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(
                            left: 56, right: 56, top: 18, bottom: 8),
                        child: const Text(
                          "Elige el plan diario que necesites.",
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                        )),
                    Container(
                        padding: const EdgeInsets.only(
                            left: 56, right: 56, top: 0, bottom: 10),
                        child: const Text(
                          "A mayor tiempo de cobertura, será menor el monto de su prima.",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PlanConfirmationScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 14),
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                // width: 200,
                                margin: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 0),
                                padding: const EdgeInsets.only(
                                    left: 28, right: 28, top: 28, bottom: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xffEC1C24),
                                    width: 2,
                                  ),
                                  color: const Color(0xffEC1C24),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 10),
                                    AutoSizeText(
                                      // "${double.parse(snapshot.data![0]['primebs']
                                      // .toString())
                                      // .toStringAsFixed(2)} Bs",
                                      '0.0 Bs',
                                      style: Paquetes.panelStyle,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                    AutoSizeText(
                                      // "${snapshot.data![0]['prime']} USD",
                                      '0.0 USD',
                                      style: Paquetes.panelTitleStyle,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 28,
                                width: 85,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    // "${snapshot.data![0]['duration']} Días",
                                    "0 Días",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PlanConfirmationScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 14),
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                // width: 200,
                                margin: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 0),
                                padding: const EdgeInsets.only(
                                    left: 28, right: 28, top: 28, bottom: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xffEC1C24),
                                    width: 2,
                                  ),
                                  color: const Color(0xffEC1C24),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 10),
                                    AutoSizeText(
                                      "0.0 Bs",
                                      style: Paquetes.panelStyle,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                    AutoSizeText(
                                      "0.0 USD",
                                      style: Paquetes.panelTitleStyle,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 28,
                                width: 85,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "0 Días",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PlanConfirmationScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 14),
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                // width: 200,
                                margin: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 0),
                                padding: const EdgeInsets.only(
                                    left: 28, right: 28, top: 28, bottom: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xffEC1C24),
                                    width: 2,
                                  ),
                                  color: const Color(0xffEC1C24),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 10),
                                    AutoSizeText(
                                      "0.0 Bs",
                                      style: Paquetes.panelStyle,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                    AutoSizeText(
                                      "0.0 USD",
                                      style: Paquetes.panelTitleStyle,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 28,
                                width: 85,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "0 Días",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Container(
                        padding: const EdgeInsets.only(
                            left: 60, right: 60, top: 0, bottom: 10),
                        child: const Text(
                          "El seguro se activa desde las 00:00 horas del día solicitado, hasta las 00:00 del último día de vigencia.",
                          style: Paquetes.optionStyleTitle2,
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
