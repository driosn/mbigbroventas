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
import 'package:mibigbro_ventas_mobile/motorized_data/motorized_photo_left_right_screen.dart';
import 'package:mibigbro_ventas_mobile/utils/app_colors.dart';
import 'package:mibigbro_ventas_mobile/widgets/bigbro_scaffold.dart';
import 'package:mibigbro_ventas_mobile/widgets/selector_foto.dart';

class MotorizedPhotoFrontBackScreen extends StatefulWidget {
  const MotorizedPhotoFrontBackScreen({
    super.key,
    required this.paqueteStock,
    required this.carController,
    required this.personalDataController,
  });

  final PaqueteStock paqueteStock;
  final CarController carController;
  final PersonalDataController personalDataController;

  @override
  _MotorizedPhotoFrontBackScreenState createState() =>
      _MotorizedPhotoFrontBackScreenState();
}

class _MotorizedPhotoFrontBackScreenState
    extends State<MotorizedPhotoFrontBackScreen> {
  File? imageFrontal;
  File? imageTrasera;

  final _pageController = PageController();
  double currentPage = 0.0;
  late ValueNotifier<bool> _isLoadingNotifier;

  //
  // Own Controllers
  //
  final inspectionController = InspeccionController();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page ?? 0.0;
      });
    });

    _isLoadingNotifier = ValueNotifier<bool>(false);
  }

  Future getImage(String tipoFoto) async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 20);

    switch (tipoFoto) {
      case "FRONTAL":
        {
          setState(() {
            if (pickedFile != null) {
              imageFrontal = File(pickedFile.path);
            } else {
              print('No image selected.');
            }
          });
        }
        break;
      case "TRASERA":
        {
          setState(() {
            if (pickedFile != null) {
              imageTrasera = File(pickedFile.path);
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
              imageFrontal = File(pickedFile.path);
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
    return ValueListenableBuilder<bool>(
        valueListenable: _isLoadingNotifier,
        builder: (context, isLoading, child) {
          return Stack(
            children: [
              BigBroScaffold(
                title: 'Datos del motorizado',
                subtitle: 'Foto del automóvil',
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
                                  getImage("FRONTAL");
                                },
                                imagen: imageFrontal,
                                onTapInfo: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return CustomDialog(
                                        context: context,
                                        iconColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
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
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              'Foto frontal',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Text(
                                                'La foto delantera debe mostrar toda la parte delantera del vehículo y la placa'),
                                            const SizedBox(
                                              height: 32,
                                            )
                                          ],
                                        ),
                                        extraActions: const [],
                                        hideActions: false,
                                      );
                                    },
                                  );
                                },
                                placeHolderAsset:
                                    'assets/img/foto_automovil.png',
                                description:
                                    'Se debe tomar la fotografía en un lugar iluminado y con el automóvil limpio',
                              ),
                              SelectorFoto(
                                onTapImagen: () {
                                  getImage("TRASERA");
                                },
                                imagen: imageTrasera,
                                onTapInfo: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return CustomDialog(
                                        context: context,
                                        iconColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
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
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              'Foto posterior',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Text(
                                                'La foto debe mostrar toda la parte posterior del vehículo y placa visible'),
                                            const SizedBox(
                                              height: 32,
                                            )
                                          ],
                                        ),
                                        extraActions: const [],
                                        hideActions: false,
                                      );
                                    },
                                  );
                                },
                                placeHolderAsset:
                                    'assets/img/foto_automovil_trasera.png',
                                description:
                                    'Se debe tomar la fotografía en un lugar iluminado y con el automóvil limpio',
                              ),
                              _PreviewFotos(
                                imageFrontal: imageFrontal,
                                imageTrasera: imageTrasera,
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
                                  if (_pageController.page == 2.0) {
                                    if (imageFrontal != null &&
                                        imageTrasera != null) {
                                      _isLoadingNotifier.value = true;

                                      final inspectionResponse =
                                          await inspectionController
                                              .createInspection(
                                        frontalPhoto: imageFrontal!,
                                        backPhoto: imageTrasera!,
                                        carId: widget.carController.carId,
                                      );

                                      if (inspectionResponse != null) {
                                        _isLoadingNotifier.value = false;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                MotorizedPhotoLeftRightScreen(
                                              carController:
                                                  widget.carController,
                                              inspectionController:
                                                  inspectionController,
                                              paqueteStock: widget.paqueteStock,
                                              personalDataController:
                                                  widget.personalDataController,
                                            ),
                                          ),
                                        );
                                      } else {
                                        _isLoadingNotifier.value = false;

                                        Fluttertoast.showToast(
                                          msg:
                                              'Hubo un problema subiendo fotos frontal y trasera',
                                        );
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                        msg:
                                            'Debe subir las fotos frontal y trasera',
                                      );
                                    }
                                  } else {
                                    _pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 750),
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
            'Valida que las fotografías se encuentren nítidas antes de  continuar',
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
