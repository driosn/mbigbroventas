import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mibigbro_ventas_mobile/dialogs/custom_dialog.dart';
import 'package:mibigbro_ventas_mobile/motorized_data/motorized_photo_front_back_screen.dart';
import 'package:mibigbro_ventas_mobile/widgets/bigbro_scaffold.dart';
import 'package:mibigbro_ventas_mobile/widgets/selector_foto.dart';

class MotorizedPhotoRuatScreen extends StatefulWidget {
  const MotorizedPhotoRuatScreen({
    super.key,
  });

  @override
  _MotorizedPhotoRuatScreenState createState() =>
      _MotorizedPhotoRuatScreenState();
}

class _MotorizedPhotoRuatScreenState extends State<MotorizedPhotoRuatScreen> {
  File? imageRuat;

  @override
  Widget build(BuildContext context) {
    return BigBroScaffold(
      title: 'Datos del motorizado',
      subtitle: 'Foto del documento RUAT',
      subtitleStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 46,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              SelectorFoto(
                onTapImagen: () {
                  getImage("RUAT");
                },
                imagen: imageRuat,
                onTapInfo: () {
                  CustomDialog(
                    context: context,
                    iconColor: Theme.of(context).colorScheme.secondary,
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                    content: Column(
                      children: [
                        Text(
                          'Tomar en cuenta para la foto',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                            'En la foto debe estar visible el RUAT del vehículo a asegurar'),
                        const SizedBox(
                          height: 32,
                        )
                      ],
                    ),
                    extraActions: const [],
                    hideActions: false,
                  );
                },
                placeHolderAsset: 'assets/img/foto_ruat.png',
                description:
                    'En la fotografía debe estar visible el RUAT del vehículo a asegurar',
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0.0),
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                              width: 1.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: const Text(
                          'Continuar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const MotorizedPhotoFrontBackScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getImage(String tipoFoto) async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 20);

    switch (tipoFoto) {
      case "RUAT":
        {
          setState(() {
            if (pickedFile != null) {
              imageRuat = File(pickedFile.path);
            } else {
              print('No image selected.');
            }
          });
        }
        break;
      default:
        {
          setState(() {
            if (pickedFile != null) {
              imageRuat = File(pickedFile.path);
            } else {
              print('No image selected.');
            }
          });
        }

        break;
    }
  }
}

class FormularioDatosBasicos {
  const FormularioDatosBasicos({
    required this.placaPrimeraParte,
    required this.placaSegundaParte,
    required this.chasis,
    required this.color,
    required this.motor,
    required this.numeroAsientos,
    required this.cilindrada,
    required this.toneladas,
  });

  final String placaPrimeraParte;
  final String placaSegundaParte;
  final String chasis;
  final String color;
  final String motor;
  final String numeroAsientos;
  final String cilindrada;
  final String toneladas;
}
