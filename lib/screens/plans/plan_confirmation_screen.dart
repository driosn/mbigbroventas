import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mibigbro_ventas_mobile/controllers/car_controller.dart';
import 'package:mibigbro_ventas_mobile/controllers/personal_data_controller.dart';
import 'package:mibigbro_ventas_mobile/data/models/paquetes/paquete_stock.dart';
import 'package:mibigbro_ventas_mobile/dialogs/custom_info_dialog.dart';
import 'package:mibigbro_ventas_mobile/motorized_data/motorized_data_crpva_screen.dart';
import 'package:mibigbro_ventas_mobile/motorized_data/motorized_photo_front_back_screen.dart';
import 'package:mibigbro_ventas_mobile/widgets/bigbro_scaffold.dart';

// Create a Form widget.
class PlanConfirmationScreen extends StatefulWidget {
  final bool esRenovacion24Hrs;

  final DateTime fechaFin;
  final PaqueteStock paqueteStock;
  final PersonalDataController personalDataController;
  final CarController carController;

  const PlanConfirmationScreen({
    super.key,
    this.esRenovacion24Hrs = false,
    required this.fechaFin,
    required this.paqueteStock,
    required this.personalDataController,
    required this.carController,
  });

  @override
  PlanConfirmationScreenState createState() {
    return PlanConfirmationScreenState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class PlanConfirmationScreenState extends State<PlanConfirmationScreen> {
  List<int> idCoberturas = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  bool valueAuxilioMecanico = true;
  bool valueRehabilitacionAutomatica = true;
  bool valueAccidentesPersonales = true;
  bool valueDanoPropios = true;
  bool valueRoboParcial = true;
  bool valueDanoMalicioso = true;
  bool valueExtraterriGratuita = true;
  bool valuePerdidaRobo = true;
  bool valuePerdidaAccidente = true;
  bool valueResponsabilidadCivil = true;
  String? valueCotizacion = "0";
  String tituloCotizacion = "Cotizacion";
  String medidaCotizacion = " medida";

  int valueFranquicia = 100;
  int valoracionCoberturas = 100;
  Color colorBarra = Colors.green;
  String textoValorCobertura = "Excelente";

  final _formKey = GlobalKey<FormState>();
  Future<void> _showMyDialogFranquisia() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Qué es una franquicia?'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Importe fijo que queda a cargo del asegurado en caso de siniestro.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    String title = 'Coberturas del Seguro';
    return BigBroScaffold(
      title: title,
      centerWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/img/planes_seguro.png'),
          const SizedBox(
            height: 4,
          ),
          const Text(
            'Personaliza el seguro',
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            height: 32,
                            width: 32,
                            child: Image.asset('assets/img/check-square.png'),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Text(
                              "Responsabilidad civil",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.info_outline),
                            onPressed: () {
                              CustomInfoDialog(
                                context: context,
                                iconColor: Theme.of(context).primaryColor,
                                title: 'Responsabilidad civil',
                                subtitle:
                                    'Cubre a terceros las lesiones corporales, muerte y daños materiales.',
                              );
                            },
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            height: 32,
                            width: 32,
                            child: Image.asset('assets/img/check-square.png'),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Text(
                              "Pérdida total por robo o accidente",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.info_outline),
                            onPressed: () {
                              CustomInfoDialog(
                                context: context,
                                iconColor: Theme.of(context).primaryColor,
                                title: 'Pérdida total por robo o accidente',
                                subtitle:
                                    'Pérdida por Robo: \nCubre en caso de que el vehículo asegurado sea robado en su totalidad, se trata de un robo cuando el hecho es realizado por desconocidos (no cubre pérdida total por robo en el extranjero). \nPérdida por accidente: \nCubre en caso de que exista un accidente y se tenga una pérdida total del automóvil.',
                              );
                            },
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            height: 32,
                            width: 32,
                            child: Image.asset('assets/img/check-square.png'),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Expanded(
                              child: Text(
                            "Daños propios",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          )),
                          IconButton(
                            icon: const Icon(Icons.info_outline),
                            onPressed: () {
                              CustomInfoDialog(
                                context: context,
                                iconColor: Theme.of(context).primaryColor,
                                title: 'Daños propios',
                                subtitle:
                                    'Cubre los daños sufridos en el vehículo tras un accidente ocasionado por colisión, embarrancamiento, vuelco o caída accidental, descuidos y daños a vehículo estacionado, siempre que sean sucesos súbitos e imprevistos, ajenos a la voluntad del Asegurado.',
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            height: 32,
                            width: 32,
                            child: Image.asset('assets/img/check-square.png'),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Expanded(
                              child: Text(
                            "Accidentes personales",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          )),
                          IconButton(
                            icon: const Icon(Icons.info_outline),
                            onPressed: () {
                              CustomInfoDialog(
                                context: context,
                                iconColor: Theme.of(context).primaryColor,
                                title: 'Accidentes personales',
                                subtitle:
                                    'Cubre las lesiones personales de las personas que se encuentren dentro del vehículo asegurado en caso de accidente, ya sea muerte, invalidez total o parcial y gastos médicos.',
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Expanded(
                              flex: 5,
                              child: Text("La franquicia es:",
                                  style: TextStyle(
                                      color: Color(0xff1D2766), fontSize: 14))),
                          IconButton(
                            icon: Icon(
                              Icons.info_outline,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            onPressed: () {
                              CustomInfoDialog(
                                context: context,
                                iconColor:
                                    Theme.of(context).colorScheme.secondary,
                                title: '¿Qué es una franquicia?',
                                subtitle:
                                    'Importe fijo que queda a cargo del asegurado en caso de siniestro.',
                              );
                            },
                          ),
                        ],
                      ),
                      Container(
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
                                    color: const Color(0xffF2F2F2),
                                    width: 2,
                                  ),
                                  color: const Color(0xffF2F2F2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      '$valueFranquicia',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 25.0,
                                        height: 0.5,
                                        fontFamily: 'Manrope',
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    AutoSizeText(
                                      'Total cobertura',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12.0,
                                        height: 1.5,
                                        fontFamily: 'Manrope',
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                    AutoSizeText(
                                      '${widget.paqueteStock.primebs} Bs',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 25.0,
                                        height: 1.2,
                                        fontFamily: 'Manrope',
                                        fontWeight: FontWeight.w700,
                                      ),
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
                                    // "Por ${widget.datosMotorizado!.diasPaquete.toString()} Días",
                                    "Por ${widget.paqueteStock.duration} Días",
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
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (widget.esRenovacion24Hrs) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        MotorizedPhotoFrontBackScreen(
                                      carController: widget.carController,
                                      paqueteStock: widget.paqueteStock,
                                      personalDataController:
                                          widget.personalDataController,
                                    ),
                                  ),
                                );
                                return;
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MotorizedDataCRPVAScreen(
                                    carController: widget.carController,
                                    paqueteStock: widget.paqueteStock,
                                    personalDataController:
                                        widget.personalDataController,
                                  ),
                                ),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Text(
                                "Continuar",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialogCobertura(String titulo, String detalle) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(detalle),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
