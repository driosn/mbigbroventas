import 'dart:async';
import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mibigbro_ventas_mobile/controllers/car_controller.dart';
import 'package:mibigbro_ventas_mobile/controllers/inspeccion_controller.dart';
import 'package:mibigbro_ventas_mobile/controllers/personal_data_controller.dart';
import 'package:mibigbro_ventas_mobile/data/models/paquetes/paquete_stock.dart';
import 'package:mibigbro_ventas_mobile/dialogs/custom_dialog.dart';
import 'package:mibigbro_ventas_mobile/screens/signature/signature_screen.dart';
import 'package:mibigbro_ventas_mobile/widgets/bigbro_scaffold.dart';
import 'package:mibigbro_ventas_mobile/widgets/selector_foto.dart';

class MotorizedPhotoExtraScreen extends StatefulWidget {
  const MotorizedPhotoExtraScreen({
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
  _MotorizedPhotoExtraScreenState createState() =>
      _MotorizedPhotoExtraScreenState();
}

class _MotorizedPhotoExtraScreenState extends State<MotorizedPhotoExtraScreen> {
  File? imageTablero;
  File? imageDamage;

  final _pageController = PageController();
  double currentPage = 0.0;

  ValueNotifier<String> subtitleNotifier =
      ValueNotifier<String>('Foto del tablero del automóvil');

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(
        () {
          currentPage = _pageController.page ?? 0.0;

          if (currentPage == 2.0) {
            subtitleNotifier.value = 'Foto del automóvil';
          }

          if (currentPage == 1.0) {
            subtitleNotifier.value =
                'Foto de algun daño con el que cuente el automóvil (si corresponde)';
          }

          if (currentPage == 0.0) {
            subtitleNotifier.value = 'Foto del tablero del automóvil';
          }
        },
      );
    });
  }

  Future getImage(String tipoFoto) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 20);

    switch (tipoFoto) {
      case "TABLERO":
        {
          setState(() {
            if (pickedFile != null) {
              imageTablero = File(pickedFile.path);
            } else {
              print('No image selected.');
            }
          });
        }
        break;
      case "DAMAGE":
        {
          setState(() {
            if (pickedFile != null) {
              imageDamage = File(pickedFile.path);
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
            } else {
              print('No image selected.');
            }
          });
        }

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: subtitleNotifier,
      builder: (context, subtitle, child) {
        return BigBroScaffold(
          title: 'Datos del motorizado',
          subtitle: subtitle,
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
                  SizedBox(
                    width: double.infinity,
                    height: 440,
                    child: PageView(
                      controller: _pageController,
                      children: [
                        SelectorFoto(
                          onTapImagen: () {
                            getImage("TABLERO");
                          },
                          imagen: imageTablero,
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Tomar en cuenta para la foto',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    'Foto del tablero',
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
                                      'La foto debe mostrar todo el tablero del automóvil, asegurate de que se pueda ver la marca de la radio'),
                                  const SizedBox(
                                    height: 32,
                                  )
                                ],
                              ),
                              extraActions: const [],
                              hideActions: false,
                            );
                          },
                          placeHolderAsset: 'assets/img/foto_tablero.png',
                          description:
                              'Se debe tomar la fotografía en un lugar iluminado y con el tablero encendido',
                        ),
                        SelectorFoto(
                          onTapImagen: () {
                            getImage("DAMAGE");
                          },
                          imagen: imageDamage,
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Tomar en cuenta para la foto',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    'Foto del daño',
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
                                      'Si su automóvil tiene algún daño debe incluir una fotografía'),
                                  const SizedBox(
                                    height: 32,
                                  )
                                ],
                              ),
                              extraActions: const [],
                              hideActions: false,
                            );
                          },
                          placeHolderAsset: 'assets/img/foto_dano.png',
                          description:
                              'Se debe tomar la fotografía en un lugar iluminado y con el automóvil limpio',
                        ),
                        _PreviewFotos(
                          imageFrontal: imageTablero,
                          imageTrasera: imageDamage,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  DotsIndicator(
                    dotsCount: 3,
                    position: currentPage.toInt(),
                  ),
                  const SizedBox(
                    height: 12,
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
                            if (_pageController.page == 2.0) {
                              if (imageDamage != null && imageTablero != null) {
                                final inspectionResponse =
                                    await widget.inspectionController.update2(
                                  damage: imageDamage!,
                                  tablero: imageTablero!,
                                  carId: widget.carController.carId,
                                );

                                if (inspectionResponse != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => SignatureScreen(
                                        carController: widget.carController,
                                        inspectionController:
                                            widget.inspectionController,
                                        paqueteStock: widget.paqueteStock,
                                        personalDataController:
                                            widget.personalDataController,
                                      ),
                                    ),
                                  );
                                } else {
                                  // TODO: Manejar Excepciones
                                }
                              } else {
                                Fluttertoast.showToast(
                                  msg: 'Debe subir las fotos adicionales',
                                );
                              }
                            } else {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 750),
                                curve: Curves.linear,
                              );
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
        );
      },
    );
  }
}

class _PreviewFotos extends StatelessWidget {
  final File? imageFrontal;
  final File? imageTrasera;

  const _PreviewFotos({
    super.key,
    required this.imageFrontal,
    required this.imageTrasera,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              height: 370,
              width: 280,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xffEC1C24),
                        ),
                      ),
                      child: imageFrontal == null
                          ? Container()
                          : Image.file(imageFrontal!),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xffEC1C24),
                        ),
                      ),
                      child: imageTrasera == null
                          ? Container()
                          : Image.file(imageTrasera!),
                    ),
                  ),
                ],
              )),
          const SizedBox(
            height: 14,
          ),
          const Text(
            'Valida que las fotografías se encuentren nítidas antes de continuar',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
