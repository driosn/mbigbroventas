import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mibigbro_ventas_mobile/screens/home/home_screen.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({
    super.key,
  });
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
                              const Expanded(
                                  flex: 1,
                                  child: Text(
                                    // snapshot.data!['modelo']['nombre_marca'] +
                                    // " " +
                                    // 'nombreModelo',
                                    'nombreMarca'
                                    " "
                                    'nombreModelo',
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
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: const Text(
                                        "Coberturas:",
                                        style: SummaryScreen.labelStyle,
                                        textAlign: TextAlign.right,
                                      ))),
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 10, 0),
                                      child: const Text(
                                        "Tipo de uso:",
                                        style: SummaryScreen.labelStyle,
                                        textAlign: TextAlign.right,
                                      ))),
                              const Expanded(
                                  flex: 1,
                                  child: Text(
                                    // snapshot.data!['uso']['nombre_uso'],
                                    'nombreUso',
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
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 10, 0),
                                      child: const Text(
                                        "Departamento:",
                                        style: SummaryScreen.labelStyle,
                                        textAlign: TextAlign.right,
                                      ))),
                              const Expanded(
                                  flex: 1,
                                  child: Text(
                                    // snapshot.data!['ciudad']['nombre_ciudad'],
                                    'nombreCiudad',
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
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 10, 0),
                                      child: const Text(
                                        "Valor asegurado:",
                                        style: SummaryScreen.labelStyle,
                                        textAlign: TextAlign.right,
                                      ))),
                              const Expanded(
                                  flex: 1,
                                  child: Text(
                                    // snapshot.data!['valor_asegurado'] + ' USD',
                                    'valorAsegurado'
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
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 10, 0),
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
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 10, 0),
                                      child: const Text(
                                        "Inicio de cobertura:",
                                        style: SummaryScreen.labelStyle,
                                        textAlign: TextAlign.right,
                                      ))),
                              const Expanded(
                                  flex: 1,
                                  child: Text(
                                    // widget.datosMotorizado!.inicioVigencia!,
                                    'inicioVigencia',
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
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 10, 0),
                                      child: const Text(
                                        "Fin de cobertura:",
                                        style: SummaryScreen.labelStyle,
                                        textAlign: TextAlign.right,
                                      ))),
                              const Expanded(
                                  flex: 1,
                                  child: Text(
                                    // widget.datosMotorizado!.finVigencia!,
                                    'finVigencia',
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
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 10, 0),
                                      child: const Text(
                                        "Costo total de la póliza:",
                                        style: SummaryScreen.labelStyle,
                                        textAlign: TextAlign.right,
                                      ))),
                              const Expanded(
                                  flex: 1,
                                  child: Text(
                                    // "$costoTotalSeguro Bs",
                                    "costoTotalSeguro Bs",
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
                                // minWidth: 20,
                                // color: Colors.red,
                                // textColor: Colors.white,
                                // disabledColor: Colors.grey,
                                // disabledTextColor: Colors.black,
                                // padding: EdgeInsets.all(8.0),
                                // splashColor: Colors.blueAccent,
                                onPressed: () async {},
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
                            // color: Color(0xff1D2766),
                            // textColor: Colors.white,
                            // disabledColor: Colors.grey,
                            // disabledTextColor: Colors.black,
                            // padding: EdgeInsets.all(8.0),
                            // splashColor: Colors.blueAccent,
                            onPressed: () async {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => HomeScreen()),
                                (route) => false,
                              );
                            },
                            child: const Text(
                              "Confirmar los datos",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ))),
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
