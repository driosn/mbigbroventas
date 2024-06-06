import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mibigbro_ventas_mobile/controllers/car_controller.dart';
import 'package:mibigbro_ventas_mobile/controllers/personal_data_controller.dart';
import 'package:mibigbro_ventas_mobile/data/models/paquetes/paquete_stock.dart';
import 'package:mibigbro_ventas_mobile/motorized_data/motorized_photo_ruat_screen.dart.dart';
import 'package:mibigbro_ventas_mobile/widgets/bigbro_scaffold.dart';
import 'package:mibigbro_ventas_mobile/widgets/selector_numero.dart';

class CarUpdateData {
  CarUpdateData({
    required this.placa,
    required this.color,
    required this.asientosNro,
    required this.cilindrada,
  });

  final String placa;
  final String color;
  final int asientosNro;
  final String cilindrada;
}

class MotorizedDataCRPVAScreen extends StatefulWidget {
  const MotorizedDataCRPVAScreen({
    super.key,
    required this.paqueteStock,
    required this.personalDataController,
    required this.carController,
  });

  final PaqueteStock paqueteStock;
  final PersonalDataController personalDataController;
  final CarController carController;

  static const TextStyle panelTitleStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 14.0,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);
  static const TextStyle panelTitleStyleDialog = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 16.0,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w300);
  static const TextStyle panelStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 18.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w300);

  @override
  _MotorizedDataCRPVAScreenState createState() =>
      _MotorizedDataCRPVAScreenState();
}

class _MotorizedDataCRPVAScreenState extends State<MotorizedDataCRPVAScreen> {
  final _formKeyDetalleMotorizado = GlobalKey<FormState>();
  final appTitle = 'Datos del motorizado';
  // final TextEditingController _placaController = TextEditingController();
  final TextEditingController _placaPrimeraParteController =
      TextEditingController();
  final TextEditingController _placaSegundaParteController =
      TextEditingController();
  final TextEditingController _chasisController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _motorController = TextEditingController();
  final TextEditingController _asientosController = TextEditingController();
  final TextEditingController _cilindradaController = TextEditingController();
  final TextEditingController _toneladasController = TextEditingController();
  File? _imageRuat;

  int numeroAsientos = 2;

  @override
  Widget build(BuildContext context) {
    Future<void> showMyDialogIndicaciones(
        String title, String detalle, String pathImage) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Tomar en cuenta para la foto',
                style: MotorizedDataCRPVAScreen.panelTitleStyle,
                textAlign: TextAlign.center),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  const Icon(
                    Icons.camera_alt_rounded,
                    size: 50.0,
                    color: Color(0xff1D2766),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    style: MotorizedDataCRPVAScreen.panelStyle,
                    textAlign: TextAlign.center,
                  ),
                  Text(detalle,
                      style: MotorizedDataCRPVAScreen.panelTitleStyleDialog,
                      textAlign: TextAlign.center),
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

    return BigBroScaffold(
      title: appTitle,
      subtitle: 'Ingrese los datos del certificado CRPVA\ndel automóvil',
      body: SingleChildScrollView(
        child: Form(
          key: _formKeyDetalleMotorizado,
          child: Container(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          maxLength: 4,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                            FilteringTextInputFormatter.allow(
                              RegExp("[0-9]"),
                            )
                          ],
                          controller: _placaPrimeraParteController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese la primera parte de la placa';
                            }

                            if (value.toLowerCase().contains(RegExp("[0-9]"))) {
                            } else {
                              return 'La primera parte de la placa debe contener 4 números.';
                            }

                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Placa Primera Parte',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff1D2766),
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '-',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1D2766),
                          fontSize: 32.0,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          maxLength: 3,
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                            FilteringTextInputFormatter.allow(
                              RegExp("[a-zA-Z]"),
                            )
                          ],
                          controller: _placaSegundaParteController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese la segunda parte de la placa';
                            }

                            if (value.contains(RegExp("[a-zA-Z]"))) {
                            } else {
                              return 'La segunda parte de la placa debe contener 3 letras.';
                            }

                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Placa Segunda Parte',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff1D2766),
                                ),
                              )),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.info, color: Color(0xff1D2766)),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/img/placa-bolivia.jpeg',
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    const Text(
                                      '*Ejemplo de placa válida en Bolivia',
                                    )
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('Aceptar'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                  ],
                  controller: _colorController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese el color del vehículo';
                    }
                    return null;
                  },
                  maxLength: 25,
                  decoration: const InputDecoration(
                    labelText: 'Color',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff1D2766),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Número de asientos'),
                ),
                const SizedBox(
                  height: 12,
                ),
                SelectorNumero(
                  valorMinimo: numeroAsientos,
                  valorInicial: numeroAsientos,
                  valorMaximo: 30,
                  onChanged: (nuevonNumAsientos) {
                    numeroAsientos = nuevonNumAsientos!;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    UpperCaseTextFormatter(),
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.allow(
                      RegExp(r"^[0-9]{0,5}$"),
                    )
                  ],
                  controller: _cilindradaController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese la cilindrada del vehículo';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Cilindrada',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff1D2766),
                        ),
                      )),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (!_formKeyDetalleMotorizado.currentState!
                            .validate()) {
                          // TODO: Manejar excepciones
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MotorizedPhotoRuatScreen(
                                carUpdateData: CarUpdateData(
                                  placa: _placaPrimeraParteController.text +
                                      _placaSegundaParteController.text,
                                  color: _colorController.text,
                                  asientosNro: numeroAsientos,
                                  cilindrada: _cilindradaController.text,
                                ),
                                carController: widget.carController,
                                personalDataController:
                                    widget.personalDataController,
                                paqueteStock: widget.paqueteStock,
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        child: const Text(
                          "Siguiente",
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
