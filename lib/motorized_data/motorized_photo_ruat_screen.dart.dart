import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mibigbro_ventas_mobile/controllers/car_controller.dart';
import 'package:mibigbro_ventas_mobile/controllers/personal_data_controller.dart';
import 'package:mibigbro_ventas_mobile/data/models/paquetes/paquete_stock.dart';
import 'package:mibigbro_ventas_mobile/dialogs/custom_dialog.dart';
import 'package:mibigbro_ventas_mobile/motorized_data/motorized_data_crpva_screen.dart';
import 'package:mibigbro_ventas_mobile/motorized_data/motorized_photo_front_back_screen.dart';
import 'package:mibigbro_ventas_mobile/utils/app_colors.dart';
import 'package:mibigbro_ventas_mobile/widgets/bigbro_scaffold.dart';
import 'package:mibigbro_ventas_mobile/widgets/selector_foto.dart';

class MotorizedPhotoRuatScreen extends StatefulWidget {
  const MotorizedPhotoRuatScreen({
    super.key,
    required this.carUpdateData,
    required this.carController,
    required this.paqueteStock,
    required this.personalDataController,
  });

  final CarUpdateData carUpdateData;
  final CarController carController;
  final PaqueteStock paqueteStock;
  final PersonalDataController personalDataController;

  @override
  _MotorizedPhotoRuatScreenState createState() =>
      _MotorizedPhotoRuatScreenState();
}

class _MotorizedPhotoRuatScreenState extends State<MotorizedPhotoRuatScreen> {
  File? imageRuat;

  late ValueNotifier<bool> _isLoadingNotifier;

  @override
  void initState() {
    _isLoadingNotifier = ValueNotifier<bool>(false);
    super.initState();
  }

  @override
  void dispose() {
    _isLoadingNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: _isLoadingNotifier,
        builder: (context, isLoading, child) {
          return Stack(
            children: [
              BigBroScaffold(
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
                              iconColor:
                                  Theme.of(context).colorScheme.secondary,
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
                                  elevation: WidgetStateProperty.all(0.0),
                                  backgroundColor: WidgetStateProperty.all(
                                    Theme.of(context).primaryColor,
                                  ),
                                  shape: WidgetStateProperty.all(
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
                                  if (imageRuat == null) {
                                    Fluttertoast.showToast(
                                        msg: 'Debe subir la foto del ruat');
                                  } else {
                                    _isLoadingNotifier.value = true;

                                    final updateResponse = await widget
                                        .carController
                                        .updateCarWithRuat(
                                      ruatPhoto: imageRuat!,
                                      userId:
                                          widget.personalDataController.userId,
                                      placa: widget.carUpdateData.placa,
                                      color: widget.carUpdateData.color,
                                      asientosNro:
                                          widget.carUpdateData.asientosNro,
                                      cilindrada:
                                          widget.carUpdateData.cilindrada,
                                    );

                                    if (updateResponse != null) {
                                      _isLoadingNotifier.value = false;
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
                                    } else {
                                      _isLoadingNotifier.value = false;
                                      // TODO: Manejar Excepciones
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (isLoading)
                Container(
                  color: AppColors.primary.withOpacity(0.20),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
            ],
          );
        });
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
