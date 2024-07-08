import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mibigbro_ventas_mobile/controllers/car_controller.dart';
import 'package:mibigbro_ventas_mobile/controllers/personal_data_controller.dart';
import 'package:mibigbro_ventas_mobile/data/models/paquetes/paquete_stock.dart';
import 'package:mibigbro_ventas_mobile/data/services/bigbro_service.dart';
import 'package:mibigbro_ventas_mobile/screens/plans/plan_confirmation_screen.dart';
import 'package:mibigbro_ventas_mobile/widgets/bigbro_scaffold.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({
    super.key,
    this.esRenovacion24Hrs = false,
    required this.carController,
    required this.personalDataController,
  });

  final bool esRenovacion24Hrs;

  final CarController carController;
  final PersonalDataController personalDataController;

  @override
  Widget build(BuildContext context) {
    return BigBroScaffold(
      title: 'Personaliza el seguro',
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
        esRenovacion24Hrs: esRenovacion24Hrs,
        carController: carController,
        personalDataController: personalDataController,
      ),
    );
  }
}

class Paquetes extends StatefulWidget {
  final bool esRenovacion24Hrs;
  final CarController carController;
  final PersonalDataController personalDataController;

  const Paquetes({
    super.key,
    this.esRenovacion24Hrs = false,
    required this.carController,
    required this.personalDataController,
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
    return FutureBuilder<List<PaqueteStock>>(
      future: BigBroService().getPaquetesStock(
        city: widget.carController.ciudad,
        brandId: widget.carController.marca,
        model: widget.carController.modelo,
        use: widget.carController.uso,
        issueValue: widget.carController.issueValue,
        renovation: 0,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final paquetesStock = snapshot.data!;

          bool existsZeroPlan = false;

          for (var paquete in paquetesStock) {
            if (paquete.prime == 0 || paquete.primebs == 0) {
              existsZeroPlan = true;
            }
          }

          // if (existsZeroPlan) {
          //   return const Center(
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(
          //         horizontal: 32,
          //       ),
          //       child: Text(
          //         'Hubo un problema obteniendo los planes, contáctese con su administrador',
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           fontSize: 20,
          //           color: AppColors.primary,
          //         ),
          //       ),
          //     ),
          //   );
          // }

          return Scaffold(
            body: Column(
              children: [
                Container(
                    padding: const EdgeInsets.only(
                        left: 56, right: 56, top: 18, bottom: 8),
                    child: const Text(
                      "Elige el plan diario que se necesite.",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    )),
                Container(
                    padding: const EdgeInsets.only(
                        left: 56, right: 56, top: 0, bottom: 10),
                    child: const Text(
                      "A mayor tiempo de cobertura, será menor el monto de la prima.",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    )),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final paqueteStock = paquetesStock[index];

                      return GestureDetector(
                        onTap: () {
                          final fechaFin = DateTime.now()
                            ..add(
                              Duration(days: paqueteStock.duration),
                            );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PlanConfirmationScreen(
                                fechaFin: fechaFin,
                                paqueteStock: paqueteStock,
                                carController: widget.carController,
                                personalDataController:
                                    widget.personalDataController,
                                esRenovacion24Hrs: widget.esRenovacion24Hrs,
                              ),
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 10),
                                      AutoSizeText(
                                        // "${double.parse(snapshot.data![0]['primebs']
                                        // .toString())
                                        // .toStringAsFixed(2)} Bs",
                                        '${paqueteStock.primebs} Bs',
                                        style: Paquetes.panelStyle,
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                      ),
                                      AutoSizeText(
                                        // "${snapshot.data![0]['prime']} USD",
                                        '${paqueteStock.prime} USD',
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
                                      "${paqueteStock.duration} Días",
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
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 12,
                    ),
                    itemCount: paquetesStock.length,
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
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
