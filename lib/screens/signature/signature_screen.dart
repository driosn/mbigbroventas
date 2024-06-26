import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mibigbro_ventas_mobile/controllers/car_controller.dart';
import 'package:mibigbro_ventas_mobile/controllers/inspeccion_controller.dart';
import 'package:mibigbro_ventas_mobile/controllers/personal_data_controller.dart';
import 'package:mibigbro_ventas_mobile/data/models/paquetes/paquete_stock.dart';
import 'package:mibigbro_ventas_mobile/screens/summary/summary_screen.dart';
import 'package:mibigbro_ventas_mobile/widgets/bigbro_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({
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

  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final appTitle = 'Firma de póliza';
  File? _imageFirma;
  bool? _valueCheckTerminos = true;
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print("Value changed"));
  }

  @override
  Widget build(BuildContext context) {
    return BigBroScaffold(
      title: 'Firma de la póliza',
      subtitle: 'Ingrese su firma en el recuadro',
      subtitleStyle: const TextStyle(
        color: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Container(
                width: 360,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff1D2766),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Signature(
                  controller: _controller,
                  height: 360,
                  width: 280,
                  backgroundColor: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _controller.clear();
                },
                child: const Text(
                  "Borrar firma",
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _valueCheckTerminos = !(_valueCheckTerminos ?? true);
                      });
                    },
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          border: Border.all(
                        width: 4,
                        color: Theme.of(context).primaryColor,
                      )),
                      child: _valueCheckTerminos ?? false
                          ? Center(
                              child: Icon(
                              Icons.check,
                              size: 14,
                              color: Theme.of(context).primaryColor,
                            ))
                          : const SizedBox(),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const Expanded(
                      child: Text(
                    "Estoy de acuerdo con los términos y condiciones de la póliza",
                    style: TextStyle(color: Color(0xff1D2766), fontSize: 15),
                  )),
                ],
              ),
              const SizedBox(
                height: 48,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            (_valueCheckTerminos!)
                                ? Theme.of(context).primaryColor
                                : Colors.grey),
                      ),
                      onPressed: () async {
                        if (_valueCheckTerminos! == true) {
                          final Uint8List dataFirma =
                              await (_controller.toPngBytes()) as Uint8List;

                          final tempDir = await getTemporaryDirectory();
                          File file =
                              await File('${tempDir.path}/image.png').create();
                          file.writeAsBytesSync(dataFirma);

                          final signatureResponse = await widget
                              .personalDataController
                              .updateClientSignature(
                            signature: file,
                          );

                          if (signatureResponse == null) {
                            // TODO: Manejar Excepcion
                          } else {
                            print(signatureResponse);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SummaryScreen(
                                  carController: widget.carController,
                                  inspectionController:
                                      widget.inspectionController,
                                  paqueteStock: widget.paqueteStock,
                                  personalDataController:
                                      widget.personalDataController,
                                ),
                              ),
                            );
                          }
                        }
                      },
                      child: _valueCheckTerminos!
                          ? const Text(
                              "Continuar",
                              style: TextStyle(fontSize: 14.0),
                            )
                          : const Text(
                              "Debe aceptar los términos y condiciones",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14.0),
                            ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
