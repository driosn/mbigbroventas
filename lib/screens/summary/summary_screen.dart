import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mibigbro_ventas_mobile/controllers/car_controller.dart';
import 'package:mibigbro_ventas_mobile/controllers/inspeccion_controller.dart';
import 'package:mibigbro_ventas_mobile/controllers/personal_data_controller.dart';
import 'package:mibigbro_ventas_mobile/data/models/paquetes/paquete_stock.dart';
import 'package:mibigbro_ventas_mobile/data/services/bigbro_service.dart';
import 'package:mibigbro_ventas_mobile/dialogs/custom_dialog.dart';
import 'package:mibigbro_ventas_mobile/dialogs/show_qr_dialog.dart';
import 'package:mibigbro_ventas_mobile/utils/extensions.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({
    super.key,
    required this.paqueteStock,
    required this.personalDataController,
    required this.carController,
    required this.inspectionController,
  });

  final PaqueteStock paqueteStock;
  final PersonalDataController personalDataController;
  final CarController carController;
  final InspeccionController inspectionController;

  static const TextStyle labelStyle = TextStyle(
      color: Colors.red,
      fontSize: 14.0,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);
  static const TextStyle infoStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 14.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w300);
  static const TextStyle infoStyleTitle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 16.0,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w600);
  static const TextStyle infoPrecioTachadoStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 16.0,
      height: 1,
      fontFamily: 'Manrope',
      decoration: TextDecoration.lineThrough,
      fontWeight: FontWeight.w700);
  static const TextStyle infoPrecioStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 16.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);

  Future verificarPago() async {
    print("Verificando pago");
    return "Dato";
  }

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final appTitle = 'Resumen';
  bool verificarPagoEnabled = false;
  bool verPago = true;
  bool verContinuar = false;
  String idTransaccion = "";
  int porcentageDescuento = 0;
  int idDescuento = 0;
  final TextEditingController _codigoDescuento = TextEditingController();

  String nameFileSlip = '';

  coberturaTexto() {
    var coberturaWidget = <Widget>[];

    coberturaWidget.add(const Text(
      "Responsabilidad civil",
      style: SummaryScreen.infoStyle,
      textAlign: TextAlign.left,
    ));
    coberturaWidget.add(const SizedBox(
      height: 5,
    ));
    coberturaWidget.add(const Text(
      "Pérdida total por robo o accidente",
      style: SummaryScreen.infoStyle,
      textAlign: TextAlign.left,
    ));
    coberturaWidget.add(const SizedBox(
      height: 5,
    ));
    coberturaWidget.add(const Text(
      "Daños propios",
      style: SummaryScreen.infoStyle,
      textAlign: TextAlign.left,
    ));
    coberturaWidget.add(const SizedBox(
      height: 5,
    ));
    coberturaWidget.add(const Text(
      "Accidentes personales",
      style: SummaryScreen.infoStyle,
      textAlign: TextAlign.left,
    ));
    coberturaWidget.add(const SizedBox(
      height: 5,
    ));
    return coberturaWidget;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: Future.value(<String, dynamic>{}),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data!['periodo_costo']);

            // double costoTotalSeguro =
            // double.parse(widget.datosMotorizado!.costo!);
            // print(costoTotalSeguro);
            // String? nombreModelo = snapshot.data!['modelo']['nombre_modelo'];

            /*  print(snapshot.data['automovil']['modelo']['nombre_modelo']);
            print(snapshot.data['automovil']['modelo']['nombre_marca']);
            print(snapshot.data['compania']['nombre_compania']);
            print(snapshot.data['coberturas']);
            print(snapshot.data['producto']);
            print(snapshot.data['periodo_total']);
            print(snapshot.data['vigencia_inicio']);
            print(snapshot.data['vigencia_final']);
            print(snapshot.data['periodo_costo']); 
            print(snapshot.data['coberturas']);*/

            return Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(
                  color: Color(0xff1D2766), //change your color here
                ),
                actions: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/home", (r) => false);
                        },
                        child: const Icon(
                          Icons.home_outlined,
                          size: 26.0,
                        ),
                      ))
                ],
                centerTitle: true,
                backgroundColor: Colors.white,
                title: Text(appTitle,
                    style: const TextStyle(color: Color(0xff1D2766))),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text("Resumen del seguro",
                          style: SummaryScreen.infoStyleTitle,
                          textAlign: TextAlign.center),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: const Text(
                                    "Modelo de automotor:",
                                    style: SummaryScreen.labelStyle,
                                    textAlign: TextAlign.right,
                                  ))),
                          Expanded(
                              flex: 1,
                              child: Text(
                                // snapshot.data!['modelo']['nombre_marca'] +
                                // " " +
                                // 'nombreModelo',
                                '${widget.carController.nombreMarca} ${widget.carController.nombreModelo}',
                                style: SummaryScreen.infoStyle,
                                textAlign: TextAlign.left,
                              ))
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: const Text(
                                    "Coberturas:",
                                    style: SummaryScreen.labelStyle,
                                    textAlign: TextAlign.right,
                                  ))),
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: coberturaTexto(),
                              ))
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: const Text(
                                    "Tipo de uso:",
                                    style: SummaryScreen.labelStyle,
                                    textAlign: TextAlign.right,
                                  ))),
                          Expanded(
                            flex: 1,
                            child: Text(
                              // snapshot.data!['uso']['nombre_uso'],
                              widget.carController.nombreUso,
                              style: SummaryScreen.infoStyle,
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: const Text(
                                    "Departamento:",
                                    style: SummaryScreen.labelStyle,
                                    textAlign: TextAlign.right,
                                  ))),
                          Expanded(
                              flex: 1,
                              child: Text(
                                // snapshot.data!['ciudad']['nombre_ciudad'],
                                widget.carController.nombreCiudad,
                                style: SummaryScreen.infoStyle,
                                textAlign: TextAlign.left,
                              ))
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: const Text(
                                    "Valor asegurado:",
                                    style: SummaryScreen.labelStyle,
                                    textAlign: TextAlign.right,
                                  ))),
                          Expanded(
                              flex: 1,
                              child: Text(
                                // snapshot.data!['valor_asegurado'] + ' USD',
                                '${widget.paqueteStock.prime}'
                                ' USD',
                                style: SummaryScreen.infoStyle,
                                textAlign: TextAlign.left,
                              ))
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: const Text(
                                    "Aseguradora:",
                                    style: SummaryScreen.labelStyle,
                                    textAlign: TextAlign.right,
                                  ))),
                          const Expanded(
                              flex: 1,
                              child: Text(
                                "Alianza seguros",
                                style: SummaryScreen.infoStyle,
                                textAlign: TextAlign.left,
                              ))
                        ],
                      ),
                      const SizedBox(height: 10),
                      /* Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      child: Text(
                                        "Producto:",
                                        style: SummaryScreen.labelStyle,
                                        textAlign: TextAlign.right,
                                      ))),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    snapshot.data['producto'] +
                                        " " +
                                        snapshot.data['periodo_total'],
                                    style: SummaryScreen.infoStyle,
                                    textAlign: TextAlign.left,
                                  ))
                            ],
                          ),
                          SizedBox(height: 10), */
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: const Text(
                                    "Inicio de cobertura:",
                                    style: SummaryScreen.labelStyle,
                                    textAlign: TextAlign.right,
                                  ))),
                          Expanded(
                              flex: 1,
                              child: Text(
                                // widget.datosMotorizado!.inicioVigencia!,
                                // TODO: Verificar inicio de vigencia
                                DateTime.now().dashedDate,
                                style: SummaryScreen.infoStyle,
                                textAlign: TextAlign.left,
                              ))
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: const Text(
                                    "Fin de cobertura:",
                                    style: SummaryScreen.labelStyle,
                                    textAlign: TextAlign.right,
                                  ))),
                          Expanded(
                              flex: 1,
                              child: Text(
                                // widget.datosMotorizado!.finVigencia!,
                                DateTime.now()
                                    .add(Duration(
                                        days: widget.paqueteStock.duration))
                                    .dashedDate,
                                style: SummaryScreen.infoStyle,
                                textAlign: TextAlign.left,
                              ))
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: const Text(
                                    "Costo total de la póliza:",
                                    style: SummaryScreen.labelStyle,
                                    textAlign: TextAlign.right,
                                  ))),
                          Expanded(
                              flex: 1,
                              child: Text(
                                // "$costoTotalSeguro Bs",
                                '${widget.paqueteStock.primebs} Bs',
                                style: SummaryScreen.infoStyle,
                                textAlign: TextAlign.left,
                              ))
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                final bigBroService = BigBroService();

                                final slipResponse =
                                    await bigBroService.getSlip(
                                  userId: widget.personalDataController.userId,
                                  carId: widget.carController.carId,
                                  stockId: widget.paqueteStock.idstock,
                                  startDate: DateTime.now().dashedDate,
                                  endDate: DateTime.now()
                                      .add(Duration(
                                          days: widget.paqueteStock.duration))
                                      .dashedDate,
                                  prima: widget.paqueteStock.primebs.toDouble(),
                                );

                                nameFileSlip = slipResponse.nameFileSlip;

                                String nameDocEncod =
                                    base64Url.encode(utf8.encode(nameFileSlip));

                                _launchNav(
                                    'http://181.188.186.158:8000/document/$nameDocEncod');
                              } catch (e) {
                                Fluttertoast.showToast(
                                    msg: 'Hubo un problema generando el slip');
                              }
                            },
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.file_download,
                                  size: 20.0,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 190,
                                  child: Text(
                                    "Descargar slip de cotización",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (nameFileSlip.isEmpty) {
                            _showMyDialogNoSlip();
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialog(
                                  context: context,
                                  iconColor: Theme.of(context).primaryColor,
                                  hideActions: false,
                                  icon: SizedBox(
                                    height: 42,
                                    width: 42,
                                    child: Image.asset(
                                      'assets/img/logo_bigbro.png',
                                    ),
                                  ),
                                  extraActions: [
                                    GestureDetector(
                                      onTap: () async {
                                        // TODO: Mostrar dialog progreso

                                        try {
                                          final bigBroService = BigBroService();

                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return const Dialog(
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              );
                                            },
                                          );

                                          final policyResponse =
                                              await bigBroService.createPolicy(
                                            startDate:
                                                DateTime.now().dashedDate,
                                            endDate: DateTime.now()
                                                .add(Duration(
                                                    days: widget
                                                        .paqueteStock.duration))
                                                .dashedDate,
                                            daysNumber:
                                                widget.paqueteStock.duration,
                                            coberturas: "1,2,3,4,5,6,7,8,9",
                                            userId: widget
                                                .personalDataController.userId,
                                            carId: widget.carController.carId,
                                            inspectionId: widget
                                                .inspectionController
                                                .inspectionId,
                                            companyId: 1,
                                            urlSlip: nameFileSlip,
                                            renovationNumber: 0,
                                          );

                                          // ignore: use_build_context_synchronously
                                          Navigator.pop(context);

                                          final policyId = policyResponse.id;

                                          showDialog(
                                            // ignore: use_build_context_synchronously
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) {
                                              return CustomDialog(
                                                context: context,
                                                iconColor: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                hideActions: true,
                                                icon: const Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 50,
                                                ),
                                                content: Column(
                                                  children: [
                                                    const Text(
                                                      'Tu seguro ha sido preaprobado',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    const Text(
                                                      'Antes de continuar con el pago tus datos serán verificados.',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 16,
                                                    ),
                                                    const Text(
                                                      '¡Gracias por elegir miBigbro!',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 16,
                                                    ),
                                                    ElevatedButton(
                                                      child: const Text(
                                                          'Finalizar'),
                                                      onPressed: () {
                                                        showQRDialog(
                                                          context,
                                                          amount: widget
                                                              .paqueteStock
                                                              .primebs,
                                                          onFinish: () {},
                                                        );
                                                        // Navigator.push(
                                                        // context,
                                                        // MaterialPageRoute(
                                                        // builder: (context) =>
                                                        // Calificacion(
                                                        // datosMotorizado:
                                                        // widget
                                                        // .datosMotorizado),
                                                        // ),
                                                        // );
                                                      },
                                                    )
                                                  ],
                                                ),
                                                extraActions: const [],
                                              );
                                            },
                                          );
                                        } catch (exception) {
                                          Navigator.pop(context);
                                          Fluttertoast.showToast(
                                            msg:
                                                'Hubo un problema generando la poliza, intentelo nuevamente',
                                          );
                                        }
                                      },
                                      child: const Text(
                                        'Aceptar',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                  content: const Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'miBigBro',
                                        style: TextStyle(
                                          color: Color(0xff1A2461),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Estas de acuerdo con los datos de tu seguro?',
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        'En caso de contar con un error de información en los datos declarados tu póliza será anulada',
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 12,
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          }

                          // Navigator.pushAndRemoveUntil(
                          // context,
                          // MaterialPageRoute(builder: (_) => HomeScreen()),
                          // (route) => false,
                          // );
                        },
                        child: const Text(
                          "Confirmar los datos",
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
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

  Future<void> _showMyDialogPago() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('miBigBro',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xff1D2766),
                  fontSize: 20.0,
                  height: 1,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w700)),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('¿Está usted de acuerdo con los datos de tu seguro?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xff1D2766),
                        fontSize: 14.0,
                        height: 1,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w300)),
                SizedBox(height: 15),
                Text(
                    'En caso de contar con un error de información en tus declarados tu póliza será anulada',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xff1D2766),
                        fontSize: 14.0,
                        height: 1,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w300)),
                SizedBox(height: 5),
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
            TextButton(
              onPressed: () {},
              child: const Text(
                "Aceptar",
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> _showMyDialogNoSlip() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Aviso',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xff1D2766),
                  fontSize: 20.0,
                  height: 1,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w700)),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Usted debe descargar y leer el slip de cotización antes de poder continuar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xff1D2766),
                        fontSize: 14.0,
                        height: 1,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w300)),
                SizedBox(height: 5),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Volver'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}

_launchNav(String urlDocument) async {
  print(urlDocument);
  await launchUrlString(urlDocument);
  return;
}
