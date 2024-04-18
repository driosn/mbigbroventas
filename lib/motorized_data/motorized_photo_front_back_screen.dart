import 'dart:async';
import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mibigbro_ventas_mobile/dialogs/custom_dialog.dart';
import 'package:mibigbro_ventas_mobile/motorized_data/motorized_photo_left_right_screen.dart';
import 'package:mibigbro_ventas_mobile/widgets/bigbro_scaffold.dart';
import 'package:mibigbro_ventas_mobile/widgets/selector_foto.dart';

class MotorizedPhotoFrontBackScreen extends StatefulWidget {
  const MotorizedPhotoFrontBackScreen({
    super.key,
  });

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

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page ?? 0.0;
      });
    });
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
    return BigBroScaffold(
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
                                'Foto frontal',
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
                      placeHolderAsset: 'assets/img/foto_automovil.png',
                      description:
                          'Se debe tomar la fotografía en un lugar iluminado y con el automóvil limpio',
                    ),
                    SelectorFoto(
                      onTapImagen: () {
                        getImage("TRASERA");
                      },
                      imagen: imageTrasera,
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
                                'Foto posterior',
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
                      placeHolderAsset: 'assets/img/foto_automovil.png',
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const MotorizedPhotoLeftRightScreen(),
                            ),
                          );
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
